# Business Logic v1.1

> Development of a Web and Android local grocery marketplace using React,
> Kotlin, and Supabase for people and local businesses in Baybay City

## Product identity

- Team: Baybay Local Commerce Team
- Code name: `baybay-basket`
- Short code: `BB`
- Purpose: Help Baybay residents find and order groceries from local markets and stores.

## Roles

- **System Administrator:** configuration, backups, retention, privacy controls, and emergency overrides.
- **Platform Administrator:** business verification, category management, reports, and aggregated analytics.
- **Local Business:** its store profile, product listings, inventory availability, and orders.
- **Customer:** public discovery, basket creation, order submission, and personal order status.
- **Guest:** public discovery only.

## MVP requirements

1. Authenticate customers and businesses with Google Sign-In.
2. Browse and search stores and products by category and Baybay service area.
3. Let verified businesses manage their own store profile and product listings.
4. Let customers create and submit a basket containing products from one business.
5. Let customers choose pickup or a supported delivery area.
6. Let businesses accept, reject, prepare, and complete orders.
7. Show customers their own order status and history.
8. Let users report unsafe, misleading, or inappropriate listings.
9. Let administrators review reports, manage categories, verify businesses, and view thresholded aggregates.
10. Synchronize client data using UUID identities, soft deletion, dirty-row tracking, and last-write-wins.

## Privacy and safety

- Exact addresses are private order data and never appear in public listings or public analytics.
- Public profiles show only a business service area.
- Retain order and account data only for the documented operational and legal period.
- Do not expose per-user activity trails or public reputation scores.
- Do not sell personal data without explicit consent, purpose limitation, and a lawful basis.
- Enforce least privilege with server-side authorization; client controls are not security boundaries.
- Apply minimum-group thresholds before showing analytics.

## Deliberate MVP exclusions

Online payments, driver dispatch, multi-business baskets, coupons, loyalty rewards,
public ratings, and route optimization are deferred until the core marketplace is validated.
