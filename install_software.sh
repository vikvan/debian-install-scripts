#!/bin/bash

set -e

SOFTWARE_LIST='alsa-utils
aptitude
aptitude-doc-en
autoconf
build-essential
cmake
cmake-doc
command-not-found
cppcheck
cscope
cutils
doxygen
doxygen-doc
dvd+rw-tools
exuberant-ctags
feh
fonts-dejavu
fonts-droid
fonts-liberation
g++
gcc
gdb
gimp
git
git-doc
gpart
gparted
gvfs-backends
html-xml-utils
iceweasel
imagemagick
iotop
libatk1.0-dev
libbonoboui2-dev
libboost-all-dev
libcairo2-dev
libfreetype6-dev
libgnome2-dev
libgnomeui-dev
libgtk2.0-dev
libncurses5-dev
libncursesw5-dev
libreoffice
libx11-dev
libxft-dev
libxinerama-dev
libxml2-utils
libxpm-dev
libxt-dev
make
mesa-utils
mupdf
mupdf-tools
mypaint
openjdk-7-jdk
openssh-client
pigz
pulseaudio-utils
python3-dev
python3-doc
python-dev
python-doc
ranger
renameutils
ruby-dev
rxvt-unicode
screen
sshfs
tcpdump
testdisk
thunar
udisks2
valgrind
vlc
x11-xserver-utils
xfonts-base
xfonts-cyrillic
xinit
xserver-xorg-dev
xterm
zathura
zathura-cb
zathura-djvu
zathura-ps'

apt-get install -y $SOFTWARE_LIST

update-command-not-found

apt-get install -y lightdm

git clone https://github.com/vikvan/dwm-6.1.git
cd dwm*/
make -j
make install
cd ../

git clone https://github.com/vikvan/dmenu-4.6.git
cd dmenu*/
make -j
make install
cd ../

git clone https://github.com/hishamhm/htop.git
cd htop*/
./autogen.sh && ./configure && make
make -j
make install
cd ../

git clone https://github.com/vim/vim.git
cd vim*/
./configure --with-features=huge --enable-multibyte --enable-rubyinterp --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/ --enable-perlinterp --enable-luainterp --enable-gui=gtk2 --enable-cscope --prefix=/usr
make -j VIMRUNTIMEDIR=/usr/share/vim/vim74
make install
cd ..

rm -rf dmenu*/ dwm*/ htop*/ vim*/
cd ..

update-alternatives --install /usr/bin/dwm dwm /usr/local/bin/dwm 200
update-alternatives --install /usr/bin/dmenu_run dmenu_run /usr/local/bin/dmenu_run 200
update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/urxvt 200
update-alternatives --install /usr/bin/editor editor /usr/bin/vim 200
update-alternatives --install /usr/bin/vi vi /usr/bin/vim 200

apt-get install -y network-manager
