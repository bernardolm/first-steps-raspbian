#!/bin/sh

get_latest_release_v3() {
    # curl --silent -H "Accept: application/vnd.github+json" "https://api.github.com/repos/$1/tags" |
    #     jq -r '.[].name' |
    #     sed -e 's/v//g' |
    #     sort --version-sort |
    #     head -n 1
    echo '4.4.25'
}

get_latest_stremio_release() {
    get_latest_release_v3 "Stremio/stremio-shell"
}

get_latest_stremio_server_js() {
    LATEST=$(get_latest_stremio_release)
    BASE_URL="https://dl.strem.io/four/${LATEST}"
    echo 'latest stremio version is '${LATEST}'. downloading from '${BASE_URL}'...'
    curl --silent -i -o stremio/server.js ${BASE_URL}/server.js
    curl --silent -i -o stremio/stremio.asar ${BASE_URL}/stremio.asar
}

get_latest_stremio_server_js


# sudo apt purge idle3 ^geany --yes
# sudo apt --purge autoremove --yes

# sudo apt-get install debian-keyring debian-archive-keyring debian-multimedia-keyring deb-multimedia-keyring zsh matchbox-keyboard nano realvnc-vnc-viewer --yes

# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# rm ~/.bash_history
# cp -f .zshrc ~/.zshrc

# sudo wget -O - https://ftp-master.debian.org/keys/archive-key-8.asc | sudo apt-key add -
# sudo wget -O - https://ftp-master.debian.org/keys/archive-key-8-security.asc | sudo apt-key add -
# sudo wget -O - https://ftp-master.debian.org/keys/archive-key-9.asc | sudo apt-key add -
# sudo wget -O - https://ftp-master.debian.org/keys/archive-key-9-security.asc | sudo apt-key add -

# sudo rm /etc/apt/sources.list.d/raspi.list
# sudo cp -f sources.list /etc/apt
# sudo cp -f sources.list.d/*.* /etc/apt/sources.list.d

# sudo apt update
