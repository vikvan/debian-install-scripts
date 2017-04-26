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

# Configure bash
echo 'set -o vi' >> ~/.bashrc

# Configure other soft
cd ./etc

sudo cp lightdm-xsession.desktop /usr/share/xsessions/
sudo cp avatar-default.png /usr/share/icons/Adwaita/256x256/status/

mkdir -p "$HOME/.config"

cp -r dwm/ ~/.dwm
cp fonts.conf ~/.fonts.conf
cp -r ranger/ ~/.config/ranger
cp -r vimperator/ ~/.vimperator
cp vimperatorrc ~/.vimperatorrc
cp vimrc ~/.vimrc
cp xsessionrc ~/.xsessionrc
cp ycm_extra_conf.py ~/.ycm_extra_conf.py
cp -r zathura/ ~/.config/zathura

cd ..

git clone --depth 1 https://github.com/vikvan/Xdefaults-urxvt.git
cp Xdefaults-urxvt/Xdefaults ~/.Xdefaults
rm -rf Xdefaults-urxvt

git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer

cd -

sudo apt-get install -y network-manager

#Configure GRUB
sudo cp ./etc/grub /etc/default/grub
sudo vim /etc/default/grub
sudo vim /etc/fstab
sudo update-grub
