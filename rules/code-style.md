---
description: Global code style rules for all projects
---

# Code Style Rules

## TypeScript/JavaScript
- 2-space indentation, single quotes, semicolons
- Use `const` by default, `let` only when reassignment needed
- Explicit return types on exported functions
- Prefer `interface` over `type` for object shapes
- Destructure props and parameters when > 2 fields
- Use early returns to avoid deep nesting

## Python
- 4-space indentation, double quotes
- Type hints on all function signatures
- Prefer f-strings over .format() or %
- Use pathlib over os.path
- Async by default for I/O operations

## Naming
- TS: camelCase variables/functions, PascalCase types/components
- Python: snake_case variables/functions, PascalCase classes
- Constants: UPPER_SNAKE_CASE in both languages
- Boolean vars: prefix with is/has/should/can
