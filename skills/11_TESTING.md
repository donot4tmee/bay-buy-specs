# 11 — Testing

**Purpose:** Define confidence for marketplace behavior.

**Confidence note:** Initial test strategy verified against v1.1 on 2026-11-23.

Test role authorization, one-business baskets, order transitions, price
snapshots, archived rows, private delivery details, report moderation, dirty
sync, conflict resolution, and migration upgrades. Run unit tests on `main`,
system tests on `beta`, and integration tests only against published release
bundles.

Miss → happy-path tests can pass while a customer reads another customer's order.
