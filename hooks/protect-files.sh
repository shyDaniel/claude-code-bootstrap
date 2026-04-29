#!/bin/bash
# Prevent accidental edits to sensitive files.
# Supports both Claude Code and Codex hook payloads without requiring jq.

set -euo pipefail

INPUT="$(cat)"

HOOK_INPUT="$INPUT" node <<'NODE'
const input = process.env.HOOK_INPUT || '';

let payload;
try {
  payload = JSON.parse(input);
} catch {
  process.exit(0);
}

const hookEvent = payload.hook_event_name || '';
const toolInput = payload.tool_input || {};
const targets = [
  toolInput.file_path,
  toolInput.path,
  toolInput.command,
].filter((value) => typeof value === 'string' && value.length > 0);

if (targets.length === 0) {
  process.exit(0);
}

const blocked = [
  /(^|\/)\.env($|[./\s])/,
  /\.pem($|\s)/,
  /\.key($|\s)/,
  /(^|\/)credentials[^/\s]*/i,
  /(^|\/)node_modules(\/|$)/,
  /(^|\/)\.git(\/|$)/,
];

const target = targets.find((candidate) => blocked.some((pattern) => pattern.test(candidate)));

if (!target) {
  process.exit(0);
}

const message = `BLOCKED: Cannot edit protected file: ${target}. Remove from protect-files.sh if intentional.`;
if (hookEvent === 'PreToolUse') {
  console.log(JSON.stringify({ decision: 'block', reason: message }));
} else {
  console.log(JSON.stringify({ error: message }));
}
process.exit(2);
NODE
