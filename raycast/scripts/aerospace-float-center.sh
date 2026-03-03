#!/bin/bash
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Float and center window
# @raycast.mode silent

WIN_ID=$(/opt/homebrew/bin/aerospace list-windows --focused --format '%{window-id}' 2>/dev/null)
STATE_FILE="/tmp/aerospace_float_${WIN_ID}"

if [ -f "$STATE_FILE" ]; then
    rm "$STATE_FILE"
    /opt/homebrew/bin/aerospace layout tiling
else
    touch "$STATE_FILE"
    /opt/homebrew/bin/aerospace layout floating
    osascript <<'EOF'
tell application "Finder"
    set screenBounds to bounds of window of desktop
    set screenW to item 3 of screenBounds
    set screenH to item 4 of screenBounds
end tell

tell application "System Events"
    set frontApp to first application process whose frontmost is true
    set frontWindow to first window of frontApp

    set winW to 1512
    set winH to 982
    set x1 to (screenW - winW) / 2
    set y1 to (screenH - winH) / 2

    set position of frontWindow to {x1, y1}
    set size of frontWindow to {winW, winH}
end tell
EOF
fi