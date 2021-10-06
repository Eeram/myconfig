#!/usr/bin/env bash

>&2 echo "[debug] ./notify script triggered"

PARENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd "${PARENT_PATH}"

while getopts ":m:i:c:" opt; do
    case ${opt} in
        m) MESSAGE="$OPTARG"
        ;;
        i) ICON="$OPTARG"
        ;;
        c) COMMAND="$OPTARG"
        ;;
    esac
done

CONTENT_ICON_OPT=""
if ! [[ -z ${ICON} ]]
then
    CONTENT_ICON_OPT="${PARENT_PATH}/../icons/${ICON}"
fi

COMMAND_OPT=""
if ! [[ -z ${COMMAND} ]]
then
    # command path must be escaped with '\ ' instead of quotes ""
    ESCAPED_PARENT_PATH=$(echo "${PARENT_PATH}" | sed 's/ /\\ /g')
    COMMAND_OPT="${ESCAPED_PARENT_PATH}/$COMMAND"
fi

>&2 echo "[debug] Send notification (message: ${MESSAGE}, icon: ${CONTENT_ICON_OPT}, command: ${COMMAND_OPT})"

if ! [[ -z ${COMMAND_OPT} ]]
then
    # do not specify -sender as this breaks the -execute command

    ../lib/terminal-notifier.app/Contents/MacOS/terminal-notifier \
        -title "Bluetooth" \
        -message "${MESSAGE}" \
        -execute "${COMMAND_OPT}" \
        -contentImage "${CONTENT_ICON_OPT}"
else
    ../lib/terminal-notifier.app/Contents/MacOS/terminal-notifier \
        -title "Bluetooth" \
        -message "${MESSAGE}" \
        -contentImage "${CONTENT_ICON_OPT}"
fi

>&2 echo "[debug] Notification sent successfully"
