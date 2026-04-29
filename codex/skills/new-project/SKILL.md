---
name: new-project
description: Scaffold a new project with FINAL_GOAL.md, ARCHITECTURE.md, and WORKLOG.md. Use when starting a repository or when project direction is underspecified.
---

# New Project Scaffolding

When the user invokes `$new-project` or asks to start a new project, create the following files in the current working directory:

## 1. FINAL_GOAL.md
```markdown
# Final Goal

## Objective
[One paragraph: what this project does and who it's for]

## Done Looks Like
- [ ] Feature / behavior 1
- [ ] Feature / behavior 2
- [ ] ...

## Enrichments Added
- [Features or improvements added beyond the original ask, with brief rationale]

## Assumptions
- [Any ambiguities resolved at project start]

## Out of Scope
- [Explicit exclusions to avoid scope creep]
```

## 2. ARCHITECTURE.md
```markdown
# Architecture

## Purpose
[What this system does]

## Stack & Why
[Tech choices and rationale]

## Key Modules
[module name] - [what it does, why it exists]

## Non-Obvious Decisions
[decision] - [why, and what alternatives were rejected]
```

## 3. WORKLOG.md
```markdown
# Work Log

## [Date] - Project Init
**What:** Initial scaffolding and documentation
**Why:** Establish project structure and tracking
**Status:** complete
**Next:** [first implementation task]
```

After creating the files:
1. Run `git init` if not already a git repo.
2. Fill the templates from the user's project brief and your best assumptions.
3. Make an initial commit: `git commit -m "chore: scaffold project with docs"`.
