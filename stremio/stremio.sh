#!/bin/sh

node server.js &

sleep 5s

echo '\n\n\n\n\n\n'

google-chrome-stable --no-touch-pinch --app=https://app.strem.io --no-proxy-server --start-fullscreen
