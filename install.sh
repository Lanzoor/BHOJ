#!/bin/bash
set -e

if [[ "${BASH_SOURCE[0]}" == "/dev/stdin" ]]; then
    REPO="Lanzoor/BHOJ"
    TMP_DIR="$(mktemp -d)"

    echo "📦 Downloading BHOJ..."
    git clone "https://github.com/$REPO.git" "$TMP_DIR/BHOJ"

    chmod +x "$TMP_DIR/BHOJ/install.sh"
    exec "$TMP_DIR/BHOJ/install.sh"
fi

APP_NAME="bhoj"
SCRIPT_NAME="bhoj.sh"

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$REPO_DIR/$SCRIPT_NAME"

LOCAL_BIN="$HOME/.local/bin"
SYSTEM_BIN="/usr/local/bin"

LOCAL_INSTALL="$LOCAL_BIN/$APP_NAME"
SYSTEM_INSTALL="$SYSTEM_BIN/$APP_NAME"

HAS_LOCAL=false
HAS_SYSTEM=false

[[ -L "$LOCAL_INSTALL" || -f "$LOCAL_INSTALL" ]] && HAS_LOCAL=true
[[ -L "$SYSTEM_INSTALL" || -f "$SYSTEM_INSTALL" ]] && HAS_SYSTEM=true

echo
echo "Welcome to the BHOJ Compiler installer!"
echo "======================================="
echo

echo "Choose an option:"
echo "  1) Local install (no sudo, recommended)  → $LOCAL_INSTALL"
echo "  2) System-wide install                   → $SYSTEM_INSTALL"

if $HAS_LOCAL || $HAS_SYSTEM; then
    echo "  3) Uninstall existing installation"
fi

echo
read -rp "Enter choice [default: 1]: " choice || true
choice=${choice:-1}

chmod +x "$TARGET"

install_local() {
    mkdir -p "$LOCAL_BIN"
    ln -sf "$TARGET" "$LOCAL_INSTALL"

    echo
    echo "✅ Installed locally as '$APP_NAME'"

    if ! echo "$PATH" | grep -q "$LOCAL_BIN"; then
        echo
        echo "⚠️  $LOCAL_BIN is not in your PATH!"
        echo "Add this to your shell config:"
        echo
        echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
    fi
}

install_system() {
    if [[ $EUID -ne 0 ]]; then
        echo "🔒 Re-running with sudo..."
        sudo "$0"
        exit 0
    fi

    ln -sf "$TARGET" "$SYSTEM_INSTALL"
    echo
    echo "✅ Installed system-wide as '$APP_NAME'"
}

uninstall() {
    echo
    echo "🧹 Uninstalling BHOJ..."

    if $HAS_SYSTEM; then
        if [[ $EUID -ne 0 ]]; then
            echo "🔒 Re-running with sudo to remove system install..."
            sudo "$0"
            exit 0
        fi
        rm -f "$SYSTEM_INSTALL"
        echo "❌ Removed system-wide install"
    fi

    if $HAS_LOCAL; then
        rm -f "$LOCAL_INSTALL"
        echo "❌ Removed local install"
    fi

    echo
    echo "✅ BHOJ successfully uninstalled"
    exit 0
}

case "$choice" in
    1)
        install_local
        ;;
    2)
        install_system
        ;;
    3)
        if $HAS_LOCAL || $HAS_SYSTEM; then
            uninstall
        else
            echo "Nothing to uninstall."
            exit 1
        fi
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

echo
echo "Try it:"
echo "  $APP_NAME --help"
