---
description: API development rules
paths:
  - "**/api/**"
  - "**/routes/**"
  - "**/endpoints/**"
  - "**/routers/**"
---

# API Rules

## FastAPI
- Use Pydantic models for all request/response schemas
- Use dependency injection for DB sessions, auth, etc.
- Use `HTTPException` with clear detail messages
- Always include pagination for list endpoints (limit/offset or cursor)
- Use kebab-case for URL paths: `/api/user-profiles` not `/api/userProfiles`
- Return consistent response shapes: `{"data": ..., "error": null}`

## Next.js API Routes
- Use Route Handlers (app router) over API routes (pages router)
- Validate input with zod
- Return proper HTTP status codes (201 for created, 204 for deleted, etc.)

## General
- Log request/response at API boundaries
- Rate limit public endpoints
- Never expose internal IDs or stack traces in error responses
