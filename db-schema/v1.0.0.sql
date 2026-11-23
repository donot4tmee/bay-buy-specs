CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS public.account (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  uuid uuid NOT NULL UNIQUE DEFAULT gen_random_uuid(),
  email text NOT NULL,
  display_name text,
  role text NOT NULL DEFAULT 'customer'
    CHECK (role IN ('system_admin', 'platform_admin', 'business', 'customer')),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  archived_at timestamptz
);
CREATE UNIQUE INDEX IF NOT EXISTS idx_account_email_live
  ON public.account (lower(email)) WHERE archived_at IS NULL;

CREATE TABLE IF NOT EXISTS public.business (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  uuid uuid NOT NULL UNIQUE DEFAULT gen_random_uuid(),
  owner_uuid uuid NOT NULL,
  name text NOT NULL,
  description text,
  service_area text NOT NULL,
  contact_text text,
  verified_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  archived_at timestamptz
);
CREATE INDEX IF NOT EXISTS idx_business_owner ON public.business (owner_uuid);
CREATE INDEX IF NOT EXISTS idx_business_area_live
  ON public.business (service_area) WHERE archived_at IS NULL;

CREATE TABLE IF NOT EXISTS public.product (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  uuid uuid NOT NULL UNIQUE DEFAULT gen_random_uuid(),
  business_uuid uuid NOT NULL,
  name text NOT NULL,
  description text,
  category text NOT NULL,
  unit_label text NOT NULL,
  price numeric(12,2) NOT NULL CHECK (price >= 0),
  available_quantity numeric(12,3),
  is_available boolean NOT NULL DEFAULT true,
  created_by uuid,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  archived_at timestamptz
);
CREATE INDEX IF NOT EXISTS idx_product_business_live
  ON public.product (business_uuid, archived_at);
CREATE INDEX IF NOT EXISTS idx_product_category_live
  ON public.product (category, archived_at);

CREATE TABLE IF NOT EXISTS public.customer_order (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  uuid uuid NOT NULL UNIQUE DEFAULT gen_random_uuid(),
  customer_uuid uuid NOT NULL,
  business_uuid uuid NOT NULL,
  fulfillment_method text NOT NULL
    CHECK (fulfillment_method IN ('pickup', 'delivery')),
  delivery_area text,
  private_delivery_details text,
  status text NOT NULL DEFAULT 'submitted'
    CHECK (status IN ('submitted', 'accepted', 'rejected', 'preparing',
                      'ready', 'completed', 'cancelled')),
  total_amount numeric(12,2) NOT NULL DEFAULT 0 CHECK (total_amount >= 0),
  submitted_at timestamptz NOT NULL DEFAULT now(),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  archived_at timestamptz,
  CHECK (fulfillment_method = 'pickup'
         OR (delivery_area IS NOT NULL AND private_delivery_details IS NOT NULL))
);
CREATE INDEX IF NOT EXISTS idx_order_customer ON public.customer_order (customer_uuid, updated_at);
CREATE INDEX IF NOT EXISTS idx_order_business ON public.customer_order (business_uuid, status, updated_at);

CREATE TABLE IF NOT EXISTS public.order_line (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  uuid uuid NOT NULL UNIQUE DEFAULT gen_random_uuid(),
  order_uuid uuid NOT NULL,
  product_uuid uuid NOT NULL,
  product_name_snapshot text NOT NULL,
  unit_label_snapshot text NOT NULL,
  unit_price_snapshot numeric(12,2) NOT NULL CHECK (unit_price_snapshot >= 0),
  quantity numeric(12,3) NOT NULL CHECK (quantity > 0),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  archived_at timestamptz
);
CREATE INDEX IF NOT EXISTS idx_order_line_order ON public.order_line (order_uuid, archived_at);
CREATE UNIQUE INDEX IF NOT EXISTS idx_order_line_live_product
  ON public.order_line (order_uuid, product_uuid) WHERE archived_at IS NULL;

CREATE TABLE IF NOT EXISTS public.content_report (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  uuid uuid NOT NULL UNIQUE DEFAULT gen_random_uuid(),
  reporter_uuid uuid NOT NULL,
  target_uuid uuid NOT NULL,
  target_type text NOT NULL CHECK (target_type IN ('business', 'product')),
  reason text NOT NULL,
  status text NOT NULL DEFAULT 'open'
    CHECK (status IN ('open', 'reviewing', 'resolved', 'dismissed')),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  archived_at timestamptz
);
CREATE INDEX IF NOT EXISTS idx_report_status ON public.content_report (status, updated_at);

CREATE TABLE IF NOT EXISTS public.app_setting (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  uuid uuid NOT NULL UNIQUE DEFAULT gen_random_uuid(),
  setting_name text NOT NULL,
  setting_value text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  archived_at timestamptz
);
CREATE UNIQUE INDEX IF NOT EXISTS idx_setting_live_name
  ON public.app_setting (setting_name) WHERE archived_at IS NULL;

COMMENT ON COLUMN public.account.id IS 'Server-only surrogate; never sync to clients.';
COMMENT ON COLUMN public.business.owner_uuid IS 'UUID relationship; intentionally not a server FK for offline sync.';
COMMENT ON COLUMN public.order_line.unit_price_snapshot IS 'Historical price at order time; do not recalculate from product.';
COMMENT ON TABLE public.customer_order IS 'The order table is named customer_order to avoid the SQL ORDER keyword.';
