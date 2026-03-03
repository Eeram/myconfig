#!/bin/bash

# @raycast.title Restart Raycast
# @raycast.author eeram (modified by Mathieu)
# @raycast.description Quit Raycast and relaunch it
# @raycast.icon 🔁
# @raycast.mode fullOutput
# @raycast.packageName Scripts
# @raycast.schemaVersion 1

echo "Stopping Raycast..."
osascript -e 'tell application "Raycast" to quit'

# Give it a moment to shut down
sleep 1

echo "Starting Raycast..."
if open -b com.raycast.macos; then
  echo "Raycast started successfully."
else
  echo "Failed to start Raycast."
  exit 1
fi