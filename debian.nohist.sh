#!/bin/bash

# Disable Bash History on Debian
# Supports: current session, current user, or all users (system-wide)

set -e

usage() {
    echo "Usage: $0 [option]"
    echo ""
    echo "Options:"
    echo "  --session     Disable history for current session only"
    echo "  --user        Disable history permanently for current user"
    echo "  --system      Disable history system-wide (requires root)"
    echo "  --clear       Clear existing history for current user"
    echo "  --all         Disable permanently + clear history for current user"
    echo "  -h, --help    Show this help message"
}

disable_session() {
    echo "Disabling history for current session..."
    unset HISTFILE
    export HISTSIZE=0
    echo "Done. History disabled for this session only."
    echo "Note: Run this script with 'source' for it to affect your current shell:"
    echo "  source $0 --session"
}

disable_user() {
    local bashrc="$HOME/.bashrc"
    echo "Disabling history permanently for user: $USER"

    # Remove any existing HISTSIZE/HISTFILESIZE lines to avoid duplicates
    sed -i '/^HISTSIZE=/d' "$bashrc"
    sed -i '/^HISTFILESIZE=/d' "$bashrc"
    sed -i '/^unset HISTFILE/d' "$bashrc"

    # Append new settings
    echo "" >> "$bashrc"
    echo "# Disable bash history" >> "$bashrc"
    echo "HISTSIZE=0" >> "$bashrc"
    echo "HISTFILESIZE=0" >> "$bashrc"
    echo "unset HISTFILE" >> "$bashrc"

    echo "Done. Added to $bashrc"
    echo "Run 'source ~/.bashrc' or open a new terminal to apply."
}

disable_system() {
    if [[ $EUID -ne 0 ]]; then
        echo "Error: --system requires root privileges. Run with sudo."
        exit 1
    fi

    local sysrc="/etc/bash.bashrc"
    echo "Disabling history system-wide in $sysrc..."

    sed -i '/^HISTSIZE=/d' "$sysrc"
    sed -i '/^HISTFILESIZE=/d' "$sysrc"
    sed -i '/^unset HISTFILE/d' "$sysrc"

    echo "" >> "$sysrc"
    echo "# Disable bash history system-wide" >> "$sysrc"
    echo "HISTSIZE=0" >> "$sysrc"
    echo "HISTFILESIZE=0" >> "$sysrc"
    echo "unset HISTFILE" >> "$sysrc"

    echo "Done. History disabled for all users via $sysrc"
}

clear_history() {
    echo "Clearing existing history for user: $USER"
    history -c
    > "$HOME/.bash_history"
    echo "Done. History cleared."
}

if [[ $# -eq 0 ]]; then
    usage
    exit 0
fi

case "$1" in
    --session)  disable_session ;;
    --user)     disable_user ;;
    --system)   disable_system ;;
    --clear)    clear_history ;;
    --all)      disable_user; clear_history ;;
    -h|--help)  usage ;;
    *)
        echo "Unknown option: $1"
        usage
        exit 1
        ;;
esac
