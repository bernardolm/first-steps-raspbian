#!/bin/bash
reset

echo -e '\nloading custom functions.sh\n'
source functions.sh

echo -e '\nremoving not used packages\n'
sudo apt purge idle3 ^geany --yes
sudo apt --purge autoremove --yes

echo -e '\nupdating and adding needed packages\n'
sudo mv /etc/apt/sources.list.d/raspi.list ~/raspi.list.old
sudo cp -f sources.list /etc/apt
sudo apt update
sudo apt install --yes jq nodejs debian-keyring raspbian-archive-keyring zsh matchbox-keyboard curl

echo -e '\ninstalling stremio\n'
get_latest_stremio_server_js

echo -e '\ninstalling oh-my-zsh\n'
/bin/sh -c "$(/usr/bin/curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv ~/.bash_history ~/.bash_history.old
cp -f .zshrc ~/.zshrc

echo -e '\nadding custom apt repositories\n'
sudo cp -f sources.list.d/*.* /etc/apt/sources.list.d
sudo apt update

echo -e '\nadding custom apt keys\n'
sudo wget -O - https://ftp-master.debian.org/keys/archive-key-8.asc | sudo apt-key add -
sudo wget -O - https://ftp-master.debian.org/keys/archive-key-8-security.asc | sudo apt-key add -
sudo wget -O - https://ftp-master.debian.org/keys/archive-key-9.asc | sudo apt-key add -
sudo wget -O - https://ftp-master.debian.org/keys/archive-key-9-security.asc | sudo apt-key add -

echo -e '\nadding custom keyring packages\n'
wget http://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb -O /tmp/deb-multimedia-keyring_2016.8.1_all.deb
sudo dpkg -i /tmp/deb-multimedia-keyring_2016.8.1_all.deb

echo -e '\nupgrading system\n'
sudo apt upgrade --yes
