# Global Development Standards

## Research & Enrichment

IMPORTANT: Before implementing any non-trivial project:
- Search the internet for current best practices, libraries, and patterns
- Look up current library versions; never assume training data is current
- When using unfamiliar libraries, use available docs MCPs or official documentation
- If the user's idea is underspecified, enrich it; build the best version, not the minimum
- Document enrichment decisions in `FINAL_GOAL.md` under `## Enrichments Added`

---

## Code Style

### TypeScript
- 2-space indentation, single quotes, semicolons
- Strict mode always (`"strict": true` in tsconfig)
- Prefer `const` over `let`, never `var`
- Use explicit return types on exported functions
- Prefer `interface` over `type` for object shapes
- Use path aliases (`@/`) over deep relative imports

### Python
- 4-space indentation, double quotes for strings
- Type hints on all function signatures
- Use `uv` for package management, not pip
- Prefer `pydantic` for data validation
- Use `async`/`await` for I/O-bound operations
- Follow PEP 8, max line length 100

### General
- Prefer named exports over default exports
- Keep functions under 50 lines; extract if longer
- Error messages should be actionable, not just descriptive

---

## Stack Defaults

When starting new projects without explicit stack requirements:
- **Frontend**: Next.js 15 + TypeScript + Tailwind CSS + pnpm
- **Backend**: FastAPI + Python 3.12+ + uv
- **Database**: PostgreSQL (prod), SQLite (prototypes)
- **Testing**: Vitest (TS), pytest (Python)
- **Formatting**: Prettier (TS), Ruff (Python)

---

## PRIME DIRECTIVE: FINAL_GOAL.md

IMPORTANT: Every new project MUST have a `FINAL_GOAL.md` created before any code is written.
- Define what "done" means: features, behaviors, acceptance criteria
- Every action must serve this document
- Before stopping: re-read FINAL_GOAL.md. If anything is incomplete, keep working
- The ONLY valid stopping condition is FINAL_GOAL.md fully satisfied
- Use the `$new-project` skill for scaffolding templates when available

---

## New Project Checklist

1. `git init` immediately
2. Use `$new-project` to scaffold docs (`FINAL_GOAL.md`, `ARCHITECTURE.md`, `WORKLOG.md`)
3. Initial commit with scaffolding + docs
4. For multi-directory projects, add README.md in each non-trivial subdirectory

---

## Ongoing Development

- Append to `WORKLOG.md` after each significant milestone
- Update `ARCHITECTURE.md` when major design decisions change
- Commit frequently with descriptive messages that tell a story
- Always commit AND push after completing any unit of work

---

## Git Hygiene

- Never leave the repo in a broken state at a commit boundary
- Tag commits that complete a FINAL_GOAL.md milestone
- Group related changes in commits, write meaningful messages
- Always push; the remote should always reflect latest state

---

## Compaction Survival

IMPORTANT: When conversation is compacted, always preserve:
- The complete list of files modified in this session
- Current task context and what remains to be done
- Test commands and verification steps
- Any error messages being debugged
