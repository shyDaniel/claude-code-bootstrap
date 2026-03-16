#!/bin/bash
# Prevent accidental edits to sensitive files
# Reads tool input from stdin (JSON with file_path field)

FILE_PATH=$(cat | jq -r '.tool_input.file_path // empty' 2>/dev/null)

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Block edits to sensitive files
BLOCKED_PATTERNS=(
  ".env"
  ".env.*"
  "*.pem"
  "*.key"
  "**/node_modules/**"
  "**/credentials*"
  "**/.git/**"
)

for pattern in "${BLOCKED_PATTERNS[@]}"; do
  if [[ "$FILE_PATH" == $pattern ]]; then
    echo '{"error": "BLOCKED: Cannot edit protected file: '"$FILE_PATH"'. Remove from protect-files.sh if intentional."}'
    exit 2
  fi
done

exit 0
