#!/bin/bash

# CSF Fire wall
sudo apt install perl
sudo wget http://download.configserver.com/csf.tgz
tar -xzf csf.tgz
cd csf
sudo sh install.sh
sudo nano /etc/csf/csf.conf
wait
csf -r

echo CSF installed!
