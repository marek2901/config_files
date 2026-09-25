import os
import subprocess
import json

DB_PATH = os.path.expanduser(
    "~/Library/Application Support/Alfred/Databases/clipboard.alfdb"
)
SQLITE_BIN = "/usr/bin/sqlite3" if os.path.exists("/usr/bin/sqlite3") else "sqlite3"
FZF_BIN = "/opt/homebrew/bin/fzf" if os.path.exists("/opt/homebrew/bin/fzf") else "/usr/local/bin/fzf"
# Single source of truth: main() and handle_result() must use the same limit,
# otherwise an entry selected at index >= limit silently fails to paste.
LIMIT = 20

def get_recent_entries(limit=LIMIT):
    """Fetches the last N items from Alfred's SQLite DB as raw strings."""
    if not os.path.exists(DB_PATH):
        return []

    query = f"SELECT json_group_array(item) FROM (SELECT item FROM clipboard WHERE item IS NOT NULL AND dataType = 0 ORDER BY ts DESC LIMIT {limit});"

    try:
        proc = subprocess.Popen(
            [SQLITE_BIN, DB_PATH, query],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        stdout, _ = proc.communicate()
        if proc.returncode == 0 and stdout.strip():
            return json.loads(stdout.strip())
    except Exception:
        pass
    return []

def main(args):
    entries = get_recent_entries(LIMIT)
    if not entries:
        return "No entries found in Alfred clipboard."

    fzf_lines = []
    for idx, text in enumerate(entries):
        clean_preview = text.replace("\r\n", " ").replace("\n", " ").replace("\t", " ")
        fzf_lines.append(f"{idx}\t{clean_preview}")

    fzf_input = "\n".join(fzf_lines)

    # Direct SQLite command executed by fzf to render exact raw entry text instantly
    # {1} passes the selected row index number
    sqlite_query = f"SELECT item FROM clipboard WHERE item IS NOT NULL AND dataType = 0 ORDER BY ts DESC LIMIT 1 OFFSET {{1}}"
    preview_cmd = f"{SQLITE_BIN} '{DB_PATH}' '{sqlite_query}'"

    try:
        fzf_proc = subprocess.Popen(
            [
                FZF_BIN,
                "--prompt=Alfred Clipboard > ",
                "--height=60%",
                "--cycle",
                "--reverse",
                "--delimiter=\t",
                "--with-nth=2..",
                f"--preview={preview_cmd}",
                "--preview-window=right:55%:wrap"
            ],
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            text=True
        )
        selected, _ = fzf_proc.communicate(input=fzf_input)
        if selected.strip():
            idx_str = selected.strip().split("\t", 1)[0].strip()
            return idx_str
    except FileNotFoundError:
        return f"Error: fzf binary not found at {FZF_BIN}."

    return ""

def handle_result(args, result, target_window_id, boss):
    if not result:
        return
    idx_str = result.strip()
    if not idx_str.isdigit():
        return
    idx = int(idx_str)
    entries = get_recent_entries(LIMIT)
    if not (0 <= idx < len(entries)):
        return
    full_text = entries[idx]
    window = boss.window_id_map.get(target_window_id)
    if not window:
        return
    # paste_text() lets kitty signal a proper bracketed paste so the
    # receiving program treats the text literally. This matters for
    # postgresql URLs / passwords containing shell metachars like
    # & ? $ ! ` " ' \ ( ) ; | < > * which write_to_child() + manual
    # \x1b[200~ markers does not reliably protect.
    try:
        if hasattr(window, "paste_text"):
            window.paste_text(full_text)
            return
    except Exception:
        pass
    # Fallback: raw write without manual bracket markers. Manual
    # \x1b[200~/\x1b[201~ wrapping breaks when the app hasn't enabled
    # bracketed-paste mode or when the text itself contains escapes.
    try:
        if hasattr(window, "write_to_child"):
            window.write_to_child(full_text.encode("utf-8"))
    except Exception:
        try:
            window.write_to_child(full_text)
        except Exception:
            pass
