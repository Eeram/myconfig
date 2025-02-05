#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Get Consio login code
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Bash command to get the Consio login code from DB
# @raycast.author louison
# @raycast.authorURL https://raycast.com/louison

export PGPASSWORD=sd9g7f9sd786htd7g89fd0sg8lmbb0v90s
/opt/homebrew/opt/libpq/bin/psql "host=127.0.0.1 port=5432 sslmode=disable dbname=consio user=api" -t -c "select login_code from public.user;" | jq -r .code| tr -d '\n' | pbcopy
echo "Login code copied to clipboard 🤖"
