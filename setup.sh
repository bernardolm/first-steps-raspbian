#!/bin/bash

source functions.sh

get_latest_stremio_server_js

sudo apt purge idle3 ^geany --yes
sudo apt --purge autoremove --yes

sudo apt-get install debian-keyring raspbian-archive-keyring debian-multimedia-keyring deb-multimedia-keyring zsh matchbox-keyboard nano realvnc-vnc-viewer --yes

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
-rm ~/.bash_history
cp -f .zshrc ~/.zshrc

sudo wget -O - https://ftp-master.debian.org/keys/archive-key-8.asc | sudo apt-key add -
sudo wget -O - https://ftp-master.debian.org/keys/archive-key-8-security.asc | sudo apt-key add -
sudo wget -O - https://ftp-master.debian.org/keys/archive-key-9.asc | sudo apt-key add -
sudo wget -O - https://ftp-master.debian.org/keys/archive-key-9-security.asc | sudo apt-key add -

sudo mv /etc/apt/sources.list.d/raspi.list ~/raspi.list.old
sudo cp -f sources.list /etc/apt
sudo cp -f sources.list.d/*.* /etc/apt/sources.list.d

sudo apt update
sudo apt upgrade --yes
