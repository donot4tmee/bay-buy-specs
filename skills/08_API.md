# 08 — API

**Purpose:** Define the server boundary used by web and Android.

**Confidence note:** Contract guidance is derived from v1.1 on 2026-11-23; route implementation is pending.

Required route groups are authentication, public discovery, business products,
customer orders, business fulfillment, reports, and administrator controls.
Every protected route derives the actor from the authenticated session and
checks ownership or role server-side. Validate status transitions and reject
unknown fields explicitly.

Miss → a client-only access gate is bypassable.
