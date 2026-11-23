# 13 — Dependencies

**Purpose:** Explain why platform dependencies exist.

**Confidence note:** Initial dependency guidance verified on 2026-11-23.

Supabase/PostgreSQL provides the server database and authentication boundary.
Google Sign-In provides the selected identity provider. Web and Android
framework choices must remain documented in the project title and manifests.
Pin versions, review security updates, and test upgrades against the API
contract and migration chain.
