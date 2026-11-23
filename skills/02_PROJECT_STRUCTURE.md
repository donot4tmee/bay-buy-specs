# 02 — Project Structure

**Purpose:** Put changes in the repository that owns them.

**Confidence note:** Verified against the workspace layout on 2026-11-23.

- `baybay-basket-web/`: browser UI and web client.
- `baybay-basket-android/`: Android UI and mobile client.
- `baybay-basket-api/`: API adapters, authorization, validation, and server logic.
- `baybay-basket-specs/`: requirements, schema, privacy, testing, and release guidance.

Do not duplicate API authorization rules in a client. Do not put product code in
the specs repository.
