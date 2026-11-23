# 16 — Engineering Principles

**Purpose:** State the rules that protect Baybay Basket.

**Confidence note:** Verified against v1.1 and the database design on 2026-11-23.

1. **The server decides access.** Client controls are user experience, not authorization.
2. **A deletion must travel.** Use a tombstone and synchronize it.
3. **Historical orders keep historical facts.** Snapshots are intentional.
4. **Collect the least precise location that solves the task.** Exact addresses remain private.
5. **Every shared field has one owner.** Update all lockstep consumers together.
6. **The MVP earns learning before complexity.** Defer payments and multi-store checkout.

Trust the code over any document, including this one.
