# 09 — Security

**Purpose:** Prevent account, location, and marketplace abuse.

**Confidence note:** Verified against v1.1 privacy rules on 2026-11-23.

Threats include account takeover, business impersonation, unauthorized order
access, precise-location exposure, malicious listings, and token leakage.
Use Google authentication, server-side role checks, least privilege, input
validation, parameterized queries, secure secrets, and audit-safe logs.
Expose service areas publicly, not exact customer addresses. Apply retention
limits and thresholded analytics.

Miss → leaked delivery details can endanger customers.
