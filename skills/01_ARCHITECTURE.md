# 01 — Architecture

**Purpose:** Explain the product boundary before implementation.

**Confidence note:** Verified against `business-logic-v1.1.md` and `db-schema/v1.0.0.sql` on 2026-11-23.

Baybay Basket has web and Android clients, a Supabase-backed API/database, and
local businesses as content owners. Clients discover public listings, create
one-business baskets, and synchronize orders. The API owns authorization,
validation, moderation, and privacy boundaries.

Hard boundaries: clients never decide permissions; exact delivery details are
private; order-line prices are snapshots; public analytics are aggregated.
The main debt is deferred payments, dispatch, and multi-business checkout.
