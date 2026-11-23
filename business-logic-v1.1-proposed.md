# Business Logic v1.1 Proposed

## Recommended revisions to v1.0

1. Define the MVP as one-business-per-basket to avoid complex multi-store checkout,
   split fulfillment, and delivery settlement.
2. Separate customer, local business, platform administrator, and system administrator
   permissions so ownership checks are enforceable.
3. Treat order-line price and product name as snapshots so historical orders remain accurate.
4. Add pickup and delivery-area choices without storing a public exact-location trail.
5. Add content-reporting and moderation flows because marketplace listings are user supplied.
6. Use soft deletion and timestamps so offline clients can synchronize changes safely.
7. Require explicit consent before any optional analytics or data-sharing use.
8. Defer payments, driver dispatch, ratings, coupons, loyalty points, multi-business baskets,
   and automated route optimization until after the MVP.

## Decision needed

Accept these revisions as the v1.1 baseline unless the team chooses a narrower MVP.
