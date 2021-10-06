#!/usr/bin/env bash

PARENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd "${PARENT_PATH}"

DEVICE=$1
TITLE=$2

if [[ $(../lib/blueutil -p) -eq 0 ]]
then
    ./bt-on.sh
    sleep 1
fi

if [[ $(../lib/blueutil --is-connected ${DEVICE}) -eq 1 ]]
then
    ../lib/blueutil --disconnect ${DEVICE}
    sleep 1 # wait a second as --is-connected might return incorrect result
    if [[ $(../lib/blueutil --is-connected ${DEVICE}) -eq 0 ]]
    then
        ./notify.sh -m "Disconnected from ${TITLE}"  -i "bluetooth-disconnected.png"
    else
        ./notify.sh -m "Failed to disconnect ${TITLE}. Click to retry." -i "bluetooth-error.png" -c "bt.sh ${DEVICE} \"${TITLE}\""
    fi
else
    ../lib/blueutil --connect ${DEVICE}
    sleep 1 # wait a second as --is-connected might return incorrect result
    if [[ $(../lib/blueutil --is-connected ${DEVICE}) -eq 1 ]]
    then
        ./notify.sh -m "Connected to ${TITLE}" -i "bluetooth-connected.png"
    else
        ./notify.sh -m "Failed to connect to ${TITLE}. Click to retry." -i "bluetooth-error.png" -c "bt.sh ${DEVICE} \"${TITLE}\""
    fi
fi
