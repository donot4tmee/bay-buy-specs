# 07 — Database

**Purpose:** Protect identity, privacy, and synchronization invariants.

**Confidence note:** Verified against `db-schema/v1.0.0.sql` and `db-design-choices.md` on 2026-11-23.

Every table has a server-only identity `id` and globally shared `uuid`.
Relationships use `*_uuid`; do not mirror local integer foreign keys. Normal
reads gate on `archived_at IS NULL`. Deletes are tombstones that bump
`updated_at`. Order lines snapshot product name, unit, and price.

Forward migrations are `v1.0.x`; full snapshots are `v1.x.0`. Never edit an
applied migration. Miss → a physical delete cannot synchronize and resurrects
on another client.
