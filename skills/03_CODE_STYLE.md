# 03 — Code Style

**Purpose:** Keep changes understandable and safe.

**Confidence note:** Initial guidance verified against the project documents on 2026-11-23.

Use names that describe business concepts (`customer_order`, `business_uuid`).
Return explicit validation errors; never silently accept unauthorized changes.
Log identifiers and event types, not private addresses or tokens. Keep commits
imperative and scoped according to `git-guidelines.md`.

Miss → inconsistent names or hidden fallbacks make API and database drift hard
to diagnose.
