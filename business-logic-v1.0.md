# Business Logic v1.0

> Development of a Web and Android local grocery marketplace using React,
> Kotlin, and Supabase for people and local businesses in Baybay City

- Allowed Platforms: Web, Android

## Project Details

- Company/Startup/Team Name: Baybay Local Commerce Team
- Project Code Name: baybay-basket
- Project Short Code: BB
- Short Description: A local grocery ordering and delivery marketplace for Baybay City.
- Long Description: Baybay Basket connects residents with public-market vendors and
  nearby local stores. Customers browse available goods, place scheduled orders,
  and coordinate pickup or delivery. Businesses manage listings and fulfill orders.

## User Levels

| User Level | Description |
|---|---|
| A. System Administrator | Maintains platform configuration, privacy controls, backups, and accounts. |
| B. Platform Administrator | Reviews businesses, handles reports, manages categories, and views aggregated analytics. |
| C. Local Business | Manages its store profile, products, availability, prices, and customer orders. |
| D. Customer | Searches local products, creates a basket, places orders, and tracks order status. |
| E. Guest | Views public stores and products without ordering or seeing private customer data. |

## System Requirements

1. The system shall allow customers and businesses to authenticate using Google Sign-In.
2. The system shall allow a customer to browse Baybay businesses and available products by category and location area.
3. The system shall allow a business to create, edit, pause, and archive its own product listings.
4. The system shall allow a customer to add products from one business to a basket and submit an order.
5. The system shall allow a business to accept, reject, prepare, and mark an order ready for pickup or delivery.
6. The system shall allow a customer to choose pickup or a delivery area and view order status updates.
7. The system shall allow customers and businesses to report misleading, unsafe, or inappropriate content.
8. The system shall protect exact customer locations, retain personal data only as long as needed,
   avoid per-user public trails, and show only aggregated analytics.

## MVP Features and Access

| Feature | Access |
|---|---|
| Browse public stores and products | A, B, C, D, E |
| Search and filter products | A, B, C, D, E |
| Manage business profile and products | A, B, C |
| Create and submit a basket order | A, B, D |
| Accept and update business orders | A, B, C |
| View personal order history and status | A, B, C, D |
| Moderate reports and manage categories | A, B |
| System configuration and backups | A |

## Rules and Boundaries

- A basket contains products from one business in the MVP.
- Prices and availability are snapshots on the order line and do not change after submission.
- Customers do not receive monetary, credit, or convertible rewards.
- Exact addresses are visible only to the customer and the authorized business handling the order.
- Public views show business service areas, not customer locations.
- A business may edit only its own listings and orders.
- A customer may cancel only before the business accepts the order.
- Archived products and businesses are excluded from normal browsing but remain as sync tombstones.
- Analytics use aggregated counts and minimum group thresholds; no public per-user activity trails exist.
- The platform does not resell personal data without explicit consent and a documented legal basis.
