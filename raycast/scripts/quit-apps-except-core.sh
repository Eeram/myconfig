#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Quit all apps except core (Slack/Chrome/Figma)
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Utilities
# @raycast.icon ⚙️

/usr/bin/osascript <<'APPLESCRIPT'
-- Apps to keep running
set keepApps to {"Slack", "Google Chrome", "Figma", "Raycast", "Finder"}

tell application "System Events"
	-- Get all non-background apps (the ones that show in the Dock)
	set appList to name of every process whose background only is false
end tell

repeat with appName in appList
	set appNameText to appName as text
	
	if keepApps does not contain appNameText then
		-- Try a clean quit first
		try
			tell application appNameText to quit
		end try
		
		-- If it's still running after a short delay, force kill it
		delay 1
		tell application "System Events"
			if (exists process appNameText) then
				try
					do shell script "killall " & quoted form of appNameText
				end try
			end if
		end tell
	end if
end repeat
APPLESCRIPT