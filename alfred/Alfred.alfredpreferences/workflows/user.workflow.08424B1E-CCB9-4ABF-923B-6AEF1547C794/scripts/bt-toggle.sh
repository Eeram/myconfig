#!/usr/bin/env bash

PARENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd "${PARENT_PATH}"

../lib/blueutil -p toggle

if [[ $(../lib/blueutil -p) -eq 1 ]]
then
    ./notify.sh -m "Bluetooth turned on" -i "bluetooth.png"
else
    ./notify.sh -m "Bluetooth turned off" -i "bluetooth-off.png"
fi
