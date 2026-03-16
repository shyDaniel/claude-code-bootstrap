---
description: Frontend development rules
paths:
  - "**/*.tsx"
  - "**/*.jsx"
  - "**/components/**"
  - "**/app/**"
  - "**/pages/**"
---

# Frontend Rules

## React / Next.js
- Use Server Components by default, Client Components only when needed (state, effects, browser APIs)
- Prefer `use` hook over useEffect for data fetching (React 19+)
- Colocate components with their styles and tests
- Use Tailwind utility classes, avoid custom CSS unless complex animations
- Keep components under 150 lines — extract subcomponents if longer

## State Management
- URL state > React state for anything shareable/bookmarkable
- Server state via React Query / SWR, not global stores
- Local state with useState/useReducer — avoid Context for frequently changing data

## Performance
- Use `React.lazy` + Suspense for code splitting
- Images: always use next/image with explicit width/height
- Prefer CSS transitions over JS animations
