#!/bin/bash

# CSF Fire wall
sudo apt install perl
sudo wget http://download.configserver.com/csf.tgz
tar -xzf csf.tgz
cd /$HOME/csf
sudo sh install.sh
sudo nano /etc/csf/csf.conf
