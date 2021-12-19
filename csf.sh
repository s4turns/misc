#!/bin/bash

# CSF Fire wall
sudo apt update
sudo apt-get install libwww-perl liblwp-protocol-https-perl libgd-graph-perl -y
cd /usr/src
rm -fv csf.tgz
wget https://download.configserver.com/csf.tgz
tar -xzf csf.tgz
cd csf
sh install.sh &
perl /etc/csf/csftest.pl &
sh /usr/local/csf/bin/remove_apf_bfd.sh &
wait
sudo nano /etc/csf/csf.conf
wait
csf -r
echo CSF installed!
