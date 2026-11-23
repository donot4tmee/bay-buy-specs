# 08 — API

**Purpose:** Define the server boundary used by web and Android.

**Confidence note:** Contract guidance is derived from v1.1 and the API foundation on 2026-11-23. The code wins.

Required route groups are authentication, public discovery, business products,
customer orders, business fulfillment, reports, and administrator controls.
Every protected route derives the actor from the authenticated session and
checks ownership or role server-side. Validate status transitions and reject
unknown fields explicitly.

Miss → a client-only access gate is bypassable.

The API repository currently implements the HTTP boundary, public discovery,
product CRUD/tombstones, order creation and transitions, reports, and sync
contracts. Supabase repository queries and hosted integration tests remain
deployment work; see the API repository README for the route inventory.
