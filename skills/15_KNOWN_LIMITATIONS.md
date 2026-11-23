# 15 — Known Limitations

**Purpose:** Keep deferred behavior visible.

**Confidence note:** Verified against v1.1 on 2026-11-23.

1. Payments are not implemented.
2. Driver dispatch and route optimization are not implemented.
3. A basket supports one business only.
4. Offline conflict resolution is row-level last-write-wins.
5. Business verification is administrative, not automated.
6. Analytics are intentionally limited to privacy-safe aggregates.

Future redesign candidates are payments and multi-business checkout, but neither
belongs in the MVP.
