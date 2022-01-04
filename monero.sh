sudo apt update
mkdir monero
cd monero
wget https://github.com/xmrig/xmrig/releases/download/v6.6.0/xmrig-6.6.0-linux-x64.tar.gz
tar -xvf xmrig-6.6.0-linux-x64.tar.gz
cd xmrig-6.6.0/

echo  ****change pool address and wallet address*****
echo xmr.2miners.com:2222

nano config.json
wait

echo now ./xmrig
