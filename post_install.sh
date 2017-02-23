#!/bin/bash

set -e

#Reconfigure packages
sudo dpkg-reconfigure locales
sudo dpkg-reconfigure keyboard-configuration
sudo dpkg-reconfigure console-setup

#Configure wireless network
sudo python wlan_setup.py

#Update existing packages
sudo apt-get update
sudo apt-get dist-upgrade

#Install new software
sudo ./install_software.sh

#Configure software
sudo ./configure_software.sh

#Configure GRUB
sudo cp ./etc/grub /etc/default/grub
sudo vim /etc/default/grub
sudo vim /etc/fstab
sudo update-grub
