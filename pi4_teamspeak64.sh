# 64 bit raspberry pi os

sudo apt update
sudo apt full-upgrade
sudo apt install git build-essential cmake screen -y
git clone --branch "v0.2.2" https://github.com/ptitSeb/box86
sudo dpkg --add-architecture armhf
sudo apt update
sudo apt install gcc-arm-linux-gnueabihf libc6:armhf libncurses5:armhf libstdc++6:armhf -y
cd ~/box86
mkdir build
cd build
cmake .. -DRPI4ARM64=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j$(nproc)
sudo make install
sudo systemctl restart systemd-binfmt

cd ~
wget https://files.teamspeak-services.com/releases/server/3.13.3/teamspeak3-server_linux_x86-3.13.3.tar.bz2
tar -xvpf teamspeak3-server_linux_x86-3.13.3.tar.bz2
cd teamspeak3-server_linux_x86
touch .ts3server_license_accepted
screen -S teamspeak ./ts3server
