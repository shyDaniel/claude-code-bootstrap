#!/bin/bash
# Claude Code + Codex Bootstrap - Setup Script
# Copies config files to ~/.claude/ and $CODEX_HOME (default ~/.codex/).
#
# Usage: bash setup.sh
# Or:    chmod +x setup.sh && ./setup.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
CODEX_DIR="${CODEX_HOME:-$HOME/.codex}"
USER_AGENTS_DIR="$HOME/.agents"

backup_file() {
  local path="$1"
  if [ -f "$path" ]; then
    local backup="$path.backup.$(date +%Y%m%d-%H%M%S)"
    cp "$path" "$backup"
    echo "Backed up existing $path -> $backup"
  fi
}

install_template() {
  local src="$1"
  local dest="$2"
  sed "s|__CODEX_DIR__|$CODEX_DIR|g" "$src" > "$dest"
}

echo "=== Claude Code + Codex Bootstrap ==="
echo "Source:      $SCRIPT_DIR"
echo "Claude:      $CLAUDE_DIR"
echo "Codex:       $CODEX_DIR"
echo "User agents: $USER_AGENTS_DIR"
echo ""

# Create directory structure
mkdir -p "$CLAUDE_DIR"/{hooks,skills/new-project,rules,agents}
mkdir -p "$CODEX_DIR"/{hooks,agents,rules,instructions/rules}
mkdir -p "$USER_AGENTS_DIR"/skills/new-project

# Backup existing generated entry points.
backup_file "$CLAUDE_DIR/CLAUDE.md"
backup_file "$CLAUDE_DIR/settings.json"
backup_file "$CODEX_DIR/AGENTS.md"
backup_file "$CODEX_DIR/config.toml"
backup_file "$CODEX_DIR/hooks.json"

echo ""
echo "Copying Claude Code files..."

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

echo "Copying Codex files..."

cp "$SCRIPT_DIR/AGENTS.md"                                     "$CODEX_DIR/AGENTS.md"
install_template "$SCRIPT_DIR/codex/config.toml"               "$CODEX_DIR/config.toml"
install_template "$SCRIPT_DIR/codex/hooks.json"                "$CODEX_DIR/hooks.json"
cp "$SCRIPT_DIR/hooks/notify.sh"                               "$CODEX_DIR/hooks/notify.sh"
cp "$SCRIPT_DIR/hooks/protect-files.sh"                        "$CODEX_DIR/hooks/protect-files.sh"
cp "$SCRIPT_DIR/codex/agents/code-reviewer.toml"               "$CODEX_DIR/agents/code-reviewer.toml"
cp "$SCRIPT_DIR/codex/rules/default.rules"                     "$CODEX_DIR/rules/default.rules"
cp "$SCRIPT_DIR/codex/skills/new-project/SKILL.md"             "$USER_AGENTS_DIR/skills/new-project/SKILL.md"
cp "$SCRIPT_DIR/rules/code-style.md"                           "$CODEX_DIR/instructions/rules/code-style.md"
cp "$SCRIPT_DIR/rules/testing.md"                              "$CODEX_DIR/instructions/rules/testing.md"
cp "$SCRIPT_DIR/rules/frontend.md"                             "$CODEX_DIR/instructions/rules/frontend.md"
cp "$SCRIPT_DIR/rules/api.md"                                  "$CODEX_DIR/instructions/rules/api.md"

# Make hooks executable
chmod +x "$CLAUDE_DIR/hooks/notify.sh"
chmod +x "$CLAUDE_DIR/hooks/protect-files.sh"
chmod +x "$CODEX_DIR/hooks/notify.sh"
chmod +x "$CODEX_DIR/hooks/protect-files.sh"

echo ""
echo "=== Installed: Claude Code ==="
echo "  CLAUDE.md               -> Global instructions"
echo "  settings.json           -> Permissions, MCP servers, hooks"
echo "  hooks/notify.sh         -> Desktop notifications"
echo "  hooks/protect-files.sh  -> Blocks .env, .pem, credentials, node_modules"
echo "  skills/new-project/     -> /new-project scaffolding skill"
echo "  rules/*.md              -> Claude path-scoped development rules"
echo "  agents/code-reviewer.md -> Claude code reviewer subagent"

echo ""
echo "=== Installed: Codex ==="
echo "  AGENTS.md                       -> Global instructions via model_instructions_file"
echo "  config.toml                     -> GPT-5.5, full-auto mode, web search, MCP servers"
echo "  hooks.json                      -> Protected-file PreToolUse hook"
echo "  hooks/*.sh                      -> Shared notification and file guard hooks"
echo "  agents/code-reviewer.toml       -> Codex read-only reviewer custom agent"
echo "  rules/default.rules             -> Codex execpolicy guardrails"
echo "  ~/.agents/skills/new-project/   -> Codex \$new-project skill"
echo "  instructions/rules/*.md         -> Reference copies of style/testing/API rules"

echo ""
echo "=== MCP Servers ==="
echo "  context7   - Real-time library docs"
echo "  playwright - Browser automation and E2E testing"
echo "  (Configured for both Claude Code and Codex; restart each client to reload.)"

echo ""
if [[ "${OSTYPE:-}" == "darwin"* ]]; then
  echo "=== macOS detected ==="
  echo "  Notification hook uses osascript."
elif [[ "${OSTYPE:-}" == "linux"* ]]; then
  echo "=== Linux detected ==="
  echo "  Notification hook uses notify-send when available."
fi

echo ""
echo "Done. Restart Claude Code and Codex to pick up the new config."
