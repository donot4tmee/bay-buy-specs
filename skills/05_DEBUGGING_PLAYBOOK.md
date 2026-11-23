# 05 — Debugging Playbook

**Purpose:** Diagnose marketplace and synchronization failures.

**Confidence note:** Initial playbook verified against the sync design on 2026-11-23.

1. Reproduce with the affected role and record the request ID.
2. Check server authorization and validation logs before client logs.
3. For missing data, check `archived_at`, UUID values, scope, and dirty state.
4. For duplicate products, compare natural keys and `uuid` before retrying.
5. For stale orders, compare `updated_at` and `synchronized_at`.

Miss → retrying blindly can overwrite a newer row or reveal a tombstone.
