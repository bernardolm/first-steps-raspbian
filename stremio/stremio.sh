#!/bin/bash

PWD=`pwd`
source ${PWD}/../functions.sh

run_server() {
    LATEST=$(get_latest_stremio_release)
    cd ${PWD}/v${LATEST}
    echo 'running from '`pwd`
    node server.js
}

run_server &

sleep 5s

echo '\n\n\n\n\n\n'

google-chrome-stable --no-touch-pinch --app=https://app.strem.io --no-proxy-server --start-fullscreen
