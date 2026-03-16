# Claude Code Bootstrap

Optimized Claude Code configuration. Clone → run setup → done.

## Quick Setup

Paste this into any machine with Claude Code installed:

```bash
git clone https://github.com/hanyusong/claude-code-bootstrap.git
cd claude-code-bootstrap
bash setup.sh
```

Then restart Claude Code.

## What's Included

```
├── CLAUDE.md                      # Global instructions (94 lines, lean & high-signal)
├── settings.json                  # Permissions, MCP servers, hooks config
├── hooks/
│   ├── notify.sh                  # macOS desktop notification when Claude needs attention
│   └── protect-files.sh           # Blocks edits to .env, .pem, credentials, node_modules
├── skills/
│   └── new-project/SKILL.md       # /new-project scaffolding (FINAL_GOAL.md, ARCHITECTURE.md, WORKLOG.md)
├── rules/
│   ├── code-style.md              # TS + Python style rules (always loaded)
│   ├── testing.md                 # Vitest + pytest patterns (always loaded)
│   ├── frontend.md                # React/Next.js rules (loaded only for .tsx/.jsx files)
│   └── api.md                     # FastAPI + API rules (loaded only for api/routes dirs)
├── agents/
│   └── code-reviewer.md           # Sonnet-powered code reviewer subagent
└── setup.sh                       # One-command installer
```

## MCP Servers

Configured in `settings.json`, auto-start on session launch:

| Server | Purpose |
|--------|---------|
| **Context7** | Real-time, version-accurate library docs. Append "use context7" to any library question. |
| **Playwright** | Browser automation, screenshots, E2E testing. |

## Key Design Decisions

- **CLAUDE.md is 94 lines** — every line earns its token cost. Personal context, doc templates, and redundant grants were removed.
- **Path-scoped rules** — frontend and API rules only load when touching relevant files, reducing context noise ~45%.
- **Doc templates in a skill** — `/new-project` loads FINAL_GOAL.md / ARCHITECTURE.md / WORKLOG.md templates on-demand instead of every session.
- **Hooks** — desktop notifications (stop watching the terminal), protected file guard (safety net for .env/credentials even with skip-permissions).
- **Deny rules** — `.env`, `.pem`, `.key`, and credentials files are protected from accidental edits.

## Customization

### Add your own rules
Drop `.md` files in `rules/`. Use frontmatter for path-scoping:
```yaml
---
paths:
  - "src/auth/**"
---
# Auth Rules
...
```

### Change notification style (Linux)
Edit `hooks/notify.sh` — replace `osascript` with `notify-send`.

### Add more MCP servers
Edit `settings.json` under `mcpServers`:
```json
"my-server": {
  "command": "npx",
  "args": ["-y", "@scope/mcp-server@latest"]
}
```

## Updating

After changing files in this repo, re-run `bash setup.sh` to sync to `~/.claude/`. The script backs up your existing `CLAUDE.md` and `settings.json` before overwriting.
