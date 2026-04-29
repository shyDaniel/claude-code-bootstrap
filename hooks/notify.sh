#!/bin/bash
# Desktop notification when the coding agent needs attention.

TITLE="${AGENT_NOTIFY_TITLE:-Coding Agent}"
MESSAGE="${AGENT_NOTIFY_MESSAGE:-Agent turn finished or needs attention}"

if command -v osascript >/dev/null 2>&1; then
  osascript -e "display notification \"$MESSAGE\" with title \"$TITLE\" sound name \"Glass\""
elif command -v notify-send >/dev/null 2>&1; then
  notify-send "$TITLE" "$MESSAGE"
fi
