# agent-bootstrap

Optimized Claude Code and OpenAI Codex configuration. Clone -> run setup -> done.

## Quick Setup

Paste this into any machine with Claude Code and/or Codex installed:

```bash
git clone https://github.com/shyDaniel/agent-bootstrap.git
cd agent-bootstrap
bash setup.sh
```

Then restart Claude Code and Codex.

## What's Included

```
├── CLAUDE.md                      # Claude Code global instructions
├── AGENTS.md                      # Codex global instructions
├── settings.json                  # Claude permissions, MCP servers, hooks
├── codex/
│   ├── config.toml                # Codex model, full-auto mode, MCP servers
│   ├── hooks.json                 # Codex protected-file hook wiring
│   ├── agents/code-reviewer.toml  # Codex read-only reviewer custom agent
│   ├── rules/default.rules        # Codex execpolicy guardrails
│   └── skills/new-project/        # Codex $new-project scaffolding skill
├── hooks/
│   ├── notify.sh                  # macOS/Linux desktop notification
│   └── protect-files.sh           # Blocks edits to .env, .pem, credentials, node_modules
├── skills/new-project/SKILL.md    # Claude /new-project scaffolding skill
├── rules/*.md                     # Shared style/testing/frontend/API reference rules
├── agents/code-reviewer.md        # Claude code reviewer subagent
└── setup.sh                       # One-command installer for both agents
```

## Install Targets

| Tool | Files |
|------|-------|
| Claude Code | `~/.claude/CLAUDE.md`, `settings.json`, hooks, rules, skills, agents |
| Codex | `$CODEX_HOME/config.toml` (default `~/.codex/config.toml`), `AGENTS.md`, `hooks.json`, hooks, custom agents, execpolicy rules |
| Codex skills | `~/.agents/skills/new-project/` |

Existing `CLAUDE.md`, `settings.json`, Codex `config.toml`, `hooks.json`, and Codex `AGENTS.md` are timestamp-backed up before overwrite.

## MCP Servers

Configured for both tools:

| Server | Purpose |
|--------|---------|
| **Context7** | Real-time, version-accurate library docs. |
| **Playwright** | Browser automation, screenshots, E2E testing. |

## Key Design Decisions

- **Separate native entry points**: Claude gets `CLAUDE.md` and `settings.json`; Codex gets `AGENTS.md`, `config.toml`, `hooks.json`, `.rules`, skills, and custom agent TOML.
- **Shared intent, native mechanics**: the same development standards and guardrails are expressed in each tool's preferred format.
- **Protected files**: `.env`, `.pem`, `.key`, credentials, `.git`, and `node_modules` edits are blocked through Claude permissions and Codex hooks.
- **Autonomous defaults**: Codex installs with GPT-5.5, `danger-full-access`, `approval_policy = "never"`, live web search, MCP servers, and multi-agent support.
- **Reviewer parity**: Claude has `agents/code-reviewer.md`; Codex has `codex/agents/code-reviewer.toml`.

## Customization

### Change Codex model or approval mode
Edit `codex/config.toml`, then re-run:

```bash
bash setup.sh
```

### Add more MCP servers
For Claude Code, edit `settings.json` under `mcpServers`.

For Codex, edit `codex/config.toml`:

```toml
[mcp_servers.my_server]
command = "npx"
args = ["-y", "@scope/mcp-server@latest"]
```

### Change notification style
Edit `hooks/notify.sh`. It uses `osascript` on macOS and `notify-send` on Linux when available.

## Updating

After changing files in this repo, re-run `bash setup.sh` to sync both `~/.claude/` and `$CODEX_HOME`.
