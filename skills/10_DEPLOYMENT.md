# 10 — Deployment

**Purpose:** Release the four repositories in a controlled order.

**Confidence note:** Verified against `git-guidelines.md` on 2026-11-23.

Develop on `main`, system-test on `beta`, publish bundles from `release`, then
obtain separate production approval. Deploy the exact approved candidate.
Database migrations precede code that reads new columns. If a fix must remain
in active development, merge it back deliberately.
