#!/bin/bash
# Antigravity CLI (agy) statusline script
# Prints model info and session last updated time (mtime) in amber.

# Read JSON input from stdin
JSON_INPUT=$(cat)

# Extract transcript path to check mtime
TRANSCRIPT_PATH=$(echo "$JSON_INPUT" | jq -r '.transcript_path' 2>/dev/null)

if [ -f "$TRANSCRIPT_PATH" ]; then
    # Format modification time as HH:MM on macOS
    LAST_UPDATED=$(stat -f "%Sm" -t "%H:%M" "$TRANSCRIPT_PATH")
else
    LAST_UPDATED="--:--"
fi

# Extract model ID and simplify it
MODEL_ID=$(echo "$JSON_INPUT" | jq -r '.model.id' 2>/dev/null)
MODEL_SHORT=$(echo "$MODEL_ID" | sed -E 's/(gemini|claude)-3-[0-9]-//g' | sed 's/-latest//g' | sed 's/1.5/15/g')

# Amber escape sequences
AMBER='\033[38;5;214m'
RESET='\033[0m'

# Build output status line
printf "[%s]  Updated: %b%s%b" "$MODEL_SHORT" "$AMBER" "$LAST_UPDATED" "$RESET"
