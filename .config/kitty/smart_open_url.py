#!/usr/bin/env python3
"""Kitty open_url handler with Velja detection + default fallback.

- http(s) URLs -> velja:open?url=<encoded>&prompt, but only if Velja is installed.
- everything else (or Velja missing) -> normal macOS handler via `open <raw>`.
- Works without external deps (stdlib only), checked per-click so no restart needed.
"""
import os
import shutil
import subprocess
import sys
import urllib.parse

VELJA_APP_NAMES = ("Velja",)
VELJA_APP_PATHS = (
    "/Applications/Velja.app",
    os.path.expanduser("~/Applications/Velja.app"),
    "/Applications/Setapp/Velja.app",
)


def velja_installed() -> bool:
    # Fast path: well-known bundle locations.
    for p in VELJA_APP_PATHS:
        if os.path.isdir(p):
            return True
    # General path: LaunchServices knows an app named Velja (handles
    # non-standard install locations without extra deps).
    try:
        r = subprocess.run(
            ["/usr/bin/open", "-Ra", "Velja"],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        if r.returncode == 0:
            return True
    except OSError:
        pass
    # CLI on PATH (future-proofing).
    if shutil.which("velja"):
        return True
    return False


def main() -> int:
    if len(sys.argv) < 2:
        return 1
    raw = sys.argv[1]
    is_web = raw.lower().startswith(("http://", "https://"))

    candidates: list[str] = []
    if is_web and velja_installed():
        encoded = urllib.parse.quote(raw, safe="")
        candidates.append(f"velja:open?url={encoded}&prompt")
    # Default / fallback: normal macOS handler.
    candidates.append(raw)

    for target in candidates:
        try:
            r = subprocess.run(
                ["/usr/bin/open", target],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )
            if r.returncode == 0:
                return 0
        except OSError:
            continue
    return 1


if __name__ == "__main__":
    sys.exit(main())
