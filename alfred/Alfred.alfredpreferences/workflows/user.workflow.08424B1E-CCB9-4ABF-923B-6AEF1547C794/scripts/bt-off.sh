#!/usr/bin/env bash

PARENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd "${PARENT_PATH}"

../lib/blueutil -p 0

if [[ $(../lib/blueutil -p) -eq 0 ]]
then
    ./notify.sh -m "Bluetooth turned off" -i "bluetooth-off.png"
else
    ./notify.sh -m "Failed to turn Bluetooth off. Click to retry." -i "bluetooth-error.png" -c "bt-off.sh"
fi
