#!/bin/bash

# @raycast.title Restart Hyperkey
# @raycast.author eeram
# @raycast.authorURL https://github.com/eeram
# @raycast.description Force kill Hyperkey and starts it again

# @raycast.icon 🔁
# @raycast.mode fullOutput
# @raycast.packageName Scripts
# @raycast.schemaVersion 1

echo "Stopping Hyperkey..."
if pkill -f "/Applications/Hyperkey.app/Contents/MacOS/Hyperkey"; then
    echo "Hyperkey stopped successfully."
else
    echo "Hyperkey was not running."
fi

sleep 1

echo "Starting Hyperkey..."
if open -a Hyperkey; then
    echo "Hyperkey started successfully."
else
    echo "Failed to start Hyperkey."
    exit 1
fi

sleep 2  # Allow some time for the app to launch

echo "Opening Hyperkey..."

open -a Hyperkey --args --preferences