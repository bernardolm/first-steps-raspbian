#!/bin/bash

TIMENOW=$(date +"%Y%m%d%H%M%S")

get_latest_release_v3() {
    /usr/bin/curl --silent -H "Accept: application/vnd.github+json" "https://api.github.com/repos/$1/tags" |
        jq -r '.[].name' |
        sed -e 's/v//g' |
        sort --version-sort --reverse |
        head -n 1
    # echo -e '4.4.25'
}

get_latest_stremio_release() {
    get_latest_release_v3 'Stremio/stremio-shell'
}

backup_folder() {
    /bin/mv $1 $2
}

download_file() {
    /usr/bin/curl -i --silent -o $2 $1
}

get_latest_stremio_server_js() {
    echo -e 'checking latest stremio version...\n'

    LATEST=$(get_latest_stremio_release)

    echo -e 'latest stremio version is '${LATEST}'\n'

    PATH=${PWD}/stremio/v${LATEST}

    echo -e 'path to download is '${PATH}', checking...\n'

    if [ -d ${PATH} ]; then
        echo -e 'already exist '${PATH}', backuping...\n';

        backup_folder ${PATH} ${PATH}_bkp_${TIMENOW}
    else
        echo -e 'there is not this path yet, will be created\n'
    fi

    /bin/mkdir -p ${PATH}

    BASE_URL=https://dl.strem.io/four/v${LATEST}

    echo -e 'downloading from '${BASE_URL}'...\n'

    download_file ${BASE_URL}/server.js ${PATH}/server.js
    download_file ${BASE_URL}/stremio.asar ${PATH}/stremio.asar

    echo -e 'finish download stremio server\n'
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
