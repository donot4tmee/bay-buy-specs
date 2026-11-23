# 14 — Developer Workflows

**Purpose:** Give repeatable recipes for common changes.

**Confidence note:** Verified against the workspace and Git guidelines on 2026-11-23.

## Add a product field

1. Update the business logic and schema migration.
2. Update API validation and both client forms.
3. Update sync allowlists and tests.
4. Run migration and focused tests.
5. Commit with a scoped imperative message.

## Change an order status

Update the database check, server transition matrix, both clients, and tests
together; see 04 #2.

Add what surprised you to `INBOX.md`.
