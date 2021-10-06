#!/usr/bin/env bash

PARENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd "${PARENT_PATH}"

../lib/blueutil -p 1

if [[ $(../lib/blueutil -p) -eq 1 ]]
then
    ./notify.sh -m "Bluetooth turned on" -i "bluetooth.png"
else
    ./notify.sh -m "Failed to turn Bluetooth on. Click to retry." -i "bluetooth-error.png" -c "bt-on.sh"
fi

#return $(../lib/blueutil -p) -eq 1
