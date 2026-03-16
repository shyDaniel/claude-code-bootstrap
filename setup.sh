#!/bin/bash
# Claude Code Bootstrap - Setup Script
# Copies all config files to ~/.claude/ and sets up Claude Code on this machine.
#
# Usage: bash setup.sh
# Or:    chmod +x setup.sh && ./setup.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "=== Claude Code Bootstrap ==="
echo "Source:  $SCRIPT_DIR"
echo "Target:  $CLAUDE_DIR"
echo ""

# Create directory structure
mkdir -p "$CLAUDE_DIR"/{hooks,skills/new-project,rules,agents}

# Backup existing CLAUDE.md and settings.json if they exist
if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
  BACKUP="$CLAUDE_DIR/CLAUDE.md.backup.$(date +%Y%m%d-%H%M%S)"
  cp "$CLAUDE_DIR/CLAUDE.md" "$BACKUP"
  echo "Backed up existing CLAUDE.md → $BACKUP"
fi

if [ -f "$CLAUDE_DIR/settings.json" ]; then
  BACKUP="$CLAUDE_DIR/settings.json.backup.$(date +%Y%m%d-%H%M%S)"
  cp "$CLAUDE_DIR/settings.json" "$BACKUP"
  echo "Backed up existing settings.json → $BACKUP"
fi

# Copy config files
echo ""
echo "Copying files..."

cp "$SCRIPT_DIR/CLAUDE.md"                     "$CLAUDE_DIR/CLAUDE.md"
cp "$SCRIPT_DIR/settings.json"                 "$CLAUDE_DIR/settings.json"
cp "$SCRIPT_DIR/hooks/notify.sh"               "$CLAUDE_DIR/hooks/notify.sh"
cp "$SCRIPT_DIR/hooks/protect-files.sh"        "$CLAUDE_DIR/hooks/protect-files.sh"
cp "$SCRIPT_DIR/skills/new-project/SKILL.md"   "$CLAUDE_DIR/skills/new-project/SKILL.md"
cp "$SCRIPT_DIR/rules/code-style.md"           "$CLAUDE_DIR/rules/code-style.md"
cp "$SCRIPT_DIR/rules/testing.md"              "$CLAUDE_DIR/rules/testing.md"
cp "$SCRIPT_DIR/rules/frontend.md"             "$CLAUDE_DIR/rules/frontend.md"
cp "$SCRIPT_DIR/rules/api.md"                  "$CLAUDE_DIR/rules/api.md"
cp "$SCRIPT_DIR/agents/code-reviewer.md"       "$CLAUDE_DIR/agents/code-reviewer.md"

# Make hooks executable
chmod +x "$CLAUDE_DIR/hooks/notify.sh"
chmod +x "$CLAUDE_DIR/hooks/protect-files.sh"

echo ""
echo "=== Installed ==="
echo "  CLAUDE.md              → Global instructions (94 lines, high-signal)"
echo "  settings.json          → Permissions, MCP servers, hooks"
echo "  hooks/notify.sh        → macOS desktop notifications"
echo "  hooks/protect-files.sh → Block edits to .env, .pem, credentials"
echo "  skills/new-project/    → /new-project scaffolding skill"
echo "  rules/code-style.md    → TS + Python style rules"
echo "  rules/testing.md       → Vitest + pytest patterns"
echo "  rules/frontend.md      → React/Next.js rules (path-scoped)"
echo "  rules/api.md           → FastAPI + API rules (path-scoped)"
echo "  agents/code-reviewer.md → Sonnet code reviewer subagent"
echo ""
echo "=== MCP Servers ==="
echo "  context7   — Real-time library docs (append 'use context7' to prompts)"
echo "  playwright — Browser automation and E2E testing"
echo "  (Configured in settings.json, will auto-start on next session)"
echo ""

# Platform-specific notes
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "=== macOS detected ==="
  echo "  Notification hook uses osascript — ready to go."
elif [[ "$OSTYPE" == "linux"* ]]; then
  echo "=== Linux detected ==="
  echo "  NOTE: Edit hooks/notify.sh to use notify-send instead of osascript:"
  echo "    notify-send 'Claude Code' 'Claude Code needs your attention'"
fi

echo ""
echo "Done. Restart Claude Code to pick up the new config."
