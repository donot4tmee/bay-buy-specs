# 04 — Change Rules

**Purpose:** Identify changes that must be made together.

**Confidence note:** Verified against the schema and business logic on 2026-11-23.

1. Adding a product field requires API validation, web forms, Android forms,
   database migration, and sync allowlists.
2. Adding an order status requires the database check, API transition rules,
   both clients, and tests.
3. Changing a role requires server authorization, UI access gates, and tests.
4. Changing privacy retention requires policy text, deletion behavior, and a
   migration or scheduled job.

Miss → one client can send values the server rejects or expose a forbidden action.
