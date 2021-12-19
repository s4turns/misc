#!/bin/sh

sudo apt update &&
sudo apt upgrade -y &&
sudo apt dist-upgrade &&
sudo apt install tcl-tls tcl-dev tk-dev mesa-common-dev libjpeg-dev libtogl-dev build-essential -y &&
sudo apt install libc6-dev libssl-dev libperl-dev pkg-config libicu-dev sudo fail2ban ccache dstat tmux iptraf-ng libwww-perl git -y &&
sudo apt install haveged ufw psmisc net-tools ca-certificates git dnsutils -y &&
sudo apt autoremove -y

echo ".:WiTH L0VE FR0M BLCKND CREW:."
