#!/bin/sh

# Disable Bash History on Ubuntu
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

check_ubuntu() {
    if [ ! -f /etc/os-release ] || ! grep -qi "ubuntu" /etc/os-release; then
        echo "Warning: This script is intended for Ubuntu systems."
        printf "Continue anyway? [y/N]: "
        read -r confirm
        case "$confirm" in
            [Yy]*) ;;
            *) exit 0 ;;
        esac
    fi
}

disable_session() {
    echo "Disabling history for current session..."
    unset HISTFILE
    export HISTSIZE=0
    export HISTFILESIZE=0
    echo "Done. History disabled for this session only."
    echo "Note: Run this script with 'source' for it to affect your current shell:"
    echo "  source $0 --session"
}

disable_user() {
    bashrc="$HOME/.bashrc"
    bash_profile="$HOME/.bash_profile"

    echo "Disabling history permanently for user: $USER"

    sed -i '/^HISTSIZE=/d' "$bashrc"
    sed -i '/^HISTFILESIZE=/d' "$bashrc"
    sed -i '/^unset HISTFILE/d' "$bashrc"
    sed -i '/^# Disable bash history/d' "$bashrc"

    echo "" >> "$bashrc"
    echo "# Disable bash history" >> "$bashrc"
    echo "HISTSIZE=0" >> "$bashrc"
    echo "HISTFILESIZE=0" >> "$bashrc"
    echo "unset HISTFILE" >> "$bashrc"

    echo "  [ok] Updated $bashrc"

    if [ -f "$bash_profile" ]; then
        sed -i '/^HISTSIZE=/d' "$bash_profile"
        sed -i '/^HISTFILESIZE=/d' "$bash_profile"
        sed -i '/^unset HISTFILE/d' "$bash_profile"
        sed -i '/^# Disable bash history/d' "$bash_profile"

        echo "" >> "$bash_profile"
        echo "# Disable bash history" >> "$bash_profile"
        echo "HISTSIZE=0" >> "$bash_profile"
        echo "HISTFILESIZE=0" >> "$bash_profile"
        echo "unset HISTFILE" >> "$bash_profile"

        echo "  [ok] Updated $bash_profile"
    fi

    echo "Done. Run 'source ~/.bashrc' or open a new terminal to apply."
}

disable_system() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "Error: --system requires root privileges. Run with sudo."
        exit 1
    fi

    sysrc="/etc/bash.bashrc"
    profile="/etc/profile"

    echo "Disabling history system-wide..."

    sed -i '/^HISTSIZE=/d' "$sysrc"
    sed -i '/^HISTFILESIZE=/d' "$sysrc"
    sed -i '/^unset HISTFILE/d' "$sysrc"
    sed -i '/^# Disable bash history/d' "$sysrc"

    echo "" >> "$sysrc"
    echo "# Disable bash history system-wide" >> "$sysrc"
    echo "HISTSIZE=0" >> "$sysrc"
    echo "HISTFILESIZE=0" >> "$sysrc"
    echo "unset HISTFILE" >> "$sysrc"

    echo "  [ok] Updated $sysrc"

    sed -i '/^HISTSIZE=/d' "$profile"
    sed -i '/^HISTFILESIZE=/d' "$profile"
    sed -i '/^unset HISTFILE/d' "$profile"
    sed -i '/^# Disable bash history/d' "$profile"

    echo "" >> "$profile"
    echo "# Disable bash history system-wide" >> "$profile"
    echo "HISTSIZE=0" >> "$profile"
    echo "HISTFILESIZE=0" >> "$profile"
    echo "unset HISTFILE" >> "$profile"

    echo "  [ok] Updated $profile"

    echo "Done. History disabled for all users."
}

clear_history() {
    echo "Clearing existing history for user: $USER"
    history -c 2>/dev/null || true
    if [ -f "$HOME/.bash_history" ]; then
        > "$HOME/.bash_history"
        echo "  [ok] Cleared ~/.bash_history"
    fi
    echo "Done."
}

check_ubuntu

if [ $# -eq 0 ]; then
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
