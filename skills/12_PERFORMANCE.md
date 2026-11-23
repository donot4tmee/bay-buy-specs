# 12 — Performance

**Purpose:** Keep discovery and order workflows responsive.

**Confidence note:** Initial guidance verified against schema indexes on 2026-11-23.

Use indexes on business ownership, service area, product category, order
customer, order business/status, and order lines. Paginate public listings and
orders. Avoid eager loading private delivery details in public queries. Profile
before adding denormalization.
