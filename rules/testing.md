---
description: Testing patterns and preferences
---

# Testing Rules

## General
- Write tests alongside implementation, not after
- Test behavior, not implementation details
- Prefer integration tests over unit tests for API endpoints
- One assertion per test when possible — makes failures clear
- Use descriptive test names: "should [expected behavior] when [condition]"

## TypeScript (Vitest)
- Run single test: `npx vitest run path/to/test.ts`
- Run all: `npx vitest run`
- Use `describe` blocks to group related tests
- Mock external services, not internal modules

## Python (pytest)
- Run single test: `uv run pytest path/to/test.py -v`
- Run all: `uv run pytest -v`
- Use fixtures over setup/teardown
- Use `pytest.mark.parametrize` for data-driven tests
- Hit real database in integration tests — don't mock the DB layer
