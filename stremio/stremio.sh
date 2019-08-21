#!/bin/bash

PWD=`pwd`

function get_latest_release_v3() {
    /usr/bin/curl --silent -H "Accept: application/vnd.github+json" "https://api.github.com/repos/$1/tags" |
        /usr/bin/jq -r '.[].name' |
        /bin/grep -v "autoupdate" |
        /bin/sed -e 's/v//g' |
        /usr/bin/sort --version-sort --reverse |
        /usr/bin/head -n 1
}

function get_latest_stremio_release() {
    get_latest_release_v3 'Stremio/stremio-shell'
}

function run_server() {
    LATEST=$(get_latest_stremio_release)
    cd ${PWD}/v${LATEST}
    echo 'running from '`pwd`
    node server.js
}

run_server &

sleep 5s

echo '\n\n\n\n\n\n'

chromium-browser --no-touch-pinch --app=https://app.strem.io --no-proxy-server --start-fullscreen
