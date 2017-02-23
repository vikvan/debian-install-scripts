#!/bin/bash

set -e

# Configure bash
echo 'set -o vi' >> ~/.bashrc

# Configure other soft
cd ./etc

cp lightdm-xsession.desktop /usr/share/xsessions/
cp avatar-default.png /usr/share/icons/Adwaita/256x256/status/

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
