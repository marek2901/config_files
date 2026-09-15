import os
import subprocess
import json

DB_PATH = os.path.expanduser(
    "~/Library/Application Support/Alfred/Databases/clipboard.alfdb"
)
SQLITE_BIN = "/usr/bin/sqlite3" if os.path.exists("/usr/bin/sqlite3") else "sqlite3"
FZF_BIN = "/opt/homebrew/bin/fzf" if os.path.exists("/opt/homebrew/bin/fzf") else "/usr/local/bin/fzf"

def get_recent_entries(limit=15):
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
    entries = get_recent_entries(15)
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
            idx_str = selected.split("\t")[0]
            return idx_str
    except FileNotFoundError:
        return f"Error: fzf binary not found at {FZF_BIN}."

    return ""

def handle_result(args, result, target_window_id, boss):
    if result and result.isdigit():
        idx = int(result)
        entries = get_recent_entries(15)
        if 0 <= idx < len(entries):
            full_text = entries[idx]
            window = boss.window_id_map.get(target_window_id)
            if window:
                bracketed_paste = f"\x1b[200~{full_text}\x1b[201~"
                window.write_to_child(bracketed_paste)
