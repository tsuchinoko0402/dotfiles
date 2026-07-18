#!/bin/bash
# herdr tab title auto-renamer hook for Antigravity CLI (agy)
# Extracts the first 20 characters of the user prompt and renames the current herdr tab.

# Read stdin to parse JSON prompt
PROMPT=$(jq -r '.prompt' 2>/dev/null)

# Skip if prompt is empty or null
if [ -z "$PROMPT" ] || [ "$PROMPT" = "null" ]; then
    exit 0
fi

# Replace newlines with spaces, trim, and take the first 20 characters
TITLE=$(echo "$PROMPT" | tr '\n' ' ' | head -c 20 | xargs)

# If we are inside herdr and have active tab ID, rename the tab
if [ -n "$HERDR_ACTIVE_TAB_ID" ] && [ -n "$TITLE" ]; then
    herdr tab rename "$HERDR_ACTIVE_TAB_ID" "$TITLE" >/dev/null 2>&1
fi

exit 0
