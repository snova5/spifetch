#!/bin/sh
# Installs the `spifetch` command for the current user (no sudo needed).
#   curl -fsSL https://raw.githubusercontent.com/snova5/spifetch/main/install.sh | sh
set -e
command -v fastfetch >/dev/null 2>&1 || echo "Tip: install fastfetch for distro logos (Fedora: sudo dnf install fastfetch)."

BIN="$HOME/.local/bin"
URL="https://raw.githubusercontent.com/snova5/spifetch/main/spifetch"

if ! command -v python3 >/dev/null 2>&1; then
    echo "spifetch needs Python 3. Install it first (Fedora: sudo dnf install python3)."
    exit 1
fi

mkdir -p "$BIN"
DIR="$(cd "$(dirname "$0")" 2>/dev/null && pwd || true)"
if [ -n "$DIR" ] && [ -f "$DIR/spifetch" ]; then
    cp "$DIR/spifetch" "$BIN/spifetch"          # run from a git clone
else
    curl -fsSL "$URL" -o "$BIN/spifetch"          # run through curl | sh
fi
chmod +x "$BIN/spifetch"

case ":$PATH:" in
    *":$BIN:"*) echo "Installed! Run: spifetch" ;;
    *)
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
        echo "Installed! Open a new terminal, then run: spifetch"
        ;;
esac
