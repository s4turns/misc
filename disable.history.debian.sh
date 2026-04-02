#!/usr/bin/env bash
# disable-history.sh — disable and clear shell history for all users
# Must be run as root

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "Must be run as root" >&2
    exit 1
fi

# System-wide config via /etc/profile.d/
cat > /etc/profile.d/disable_history.sh << 'EOF'
# Disable shell history for all users
export HISTFILE=/dev/null
export HISTSIZE=0
export HISTFILESIZE=0
EOF
chmod 644 /etc/profile.d/disable_history.sh

# Also cover zsh system-wide
if [ -f /etc/zsh/zshenv ]; then
    if ! grep -q 'HISTFILE=/dev/null' /etc/zsh/zshenv; then
        printf '\n# Disable history\nexport HISTFILE=/dev/null\nexport HISTSIZE=0\n' >> /etc/zsh/zshenv
    fi
fi

# Clear history files for all existing users (home dirs under /home + root)
for homedir in /root /home/*; do
    [ -d "$homedir" ] || continue

    for histfile in \
        "$homedir/.bash_history" \
        "$homedir/.zsh_history" \
        "$homedir/.zhistory" \
        "$homedir/.sh_history" \
        "$homedir/.history"; do
        if [ -f "$histfile" ]; then
            > "$histfile"
            echo "Cleared: $histfile"
        fi
    done
done

echo "Done. New sessions will have history disabled."
