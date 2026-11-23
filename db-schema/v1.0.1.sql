BEGIN;

ALTER TABLE public.account
  ADD COLUMN IF NOT EXISTS auth_user_uuid uuid;

CREATE UNIQUE INDEX IF NOT EXISTS idx_account_auth_user_live
  ON public.account (auth_user_uuid)
  WHERE auth_user_uuid IS NOT NULL AND archived_at IS NULL;

CREATE OR REPLACE FUNCTION public.current_account_uuid()
RETURNS uuid
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT uuid
  FROM public.account
  WHERE auth_user_uuid = auth.uid()
    AND archived_at IS NULL
  LIMIT 1
$$;

CREATE OR REPLACE FUNCTION public.current_account_role()
RETURNS text
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT role
  FROM public.account
  WHERE auth_user_uuid = auth.uid()
    AND archived_at IS NULL
  LIMIT 1
$$;

ALTER TABLE public.account ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.business ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.product ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.customer_order ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.order_line ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.content_report ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.app_setting ENABLE ROW LEVEL SECURITY;

CREATE POLICY account_self_read ON public.account
  FOR SELECT USING (auth_user_uuid = auth.uid());

CREATE POLICY business_public_read ON public.business
  FOR SELECT USING (archived_at IS NULL AND verified_at IS NOT NULL);

CREATE POLICY business_owner_write ON public.business
  FOR ALL USING (
    owner_uuid = public.current_account_uuid()
    OR public.current_account_role() IN ('platform_admin', 'system_admin')
  )
  WITH CHECK (
    owner_uuid = public.current_account_uuid()
    OR public.current_account_role() IN ('platform_admin', 'system_admin')
  );

CREATE POLICY product_public_read ON public.product
  FOR SELECT USING (
    archived_at IS NULL
    AND EXISTS (
      SELECT 1 FROM public.business b
      WHERE b.uuid = business_uuid
        AND b.archived_at IS NULL
        AND b.verified_at IS NOT NULL
    )
  );

CREATE POLICY product_owner_write ON public.product
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.business b
      WHERE b.uuid = business_uuid
        AND (
          b.owner_uuid = public.current_account_uuid()
          OR public.current_account_role() IN ('platform_admin', 'system_admin')
        )
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.business b
      WHERE b.uuid = business_uuid
        AND (
          b.owner_uuid = public.current_account_uuid()
          OR public.current_account_role() IN ('platform_admin', 'system_admin')
        )
    )
  );

CREATE POLICY order_participant_access ON public.customer_order
  FOR SELECT USING (
    customer_uuid = public.current_account_uuid()
    OR EXISTS (
      SELECT 1 FROM public.business b
      WHERE b.uuid = business_uuid
        AND b.owner_uuid = public.current_account_uuid()
    )
    OR public.current_account_role() IN ('platform_admin', 'system_admin')
  );

CREATE POLICY order_customer_insert ON public.customer_order
  FOR INSERT WITH CHECK (
    customer_uuid = public.current_account_uuid()
    OR public.current_account_role() IN ('platform_admin', 'system_admin')
  );

CREATE POLICY order_business_update ON public.customer_order
  FOR UPDATE USING (
    EXISTS (
      SELECT 1 FROM public.business b
      WHERE b.uuid = business_uuid
        AND b.owner_uuid = public.current_account_uuid()
    )
    OR (
      customer_uuid = public.current_account_uuid()
      AND status = 'submitted'
    )
    OR public.current_account_role() IN ('platform_admin', 'system_admin')
  );

CREATE POLICY order_line_participant_access ON public.order_line
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.customer_order o
      WHERE o.uuid = order_uuid
    )
  );

CREATE POLICY report_actor_access ON public.content_report
  FOR SELECT USING (
    reporter_uuid = public.current_account_uuid()
    OR public.current_account_role() IN ('platform_admin', 'system_admin')
  );

CREATE POLICY report_actor_insert ON public.content_report
  FOR INSERT WITH CHECK (reporter_uuid = public.current_account_uuid());

CREATE POLICY report_admin_update ON public.content_report
  FOR UPDATE USING (
    public.current_account_role() IN ('platform_admin', 'system_admin')
  );

CREATE POLICY setting_admin_access ON public.app_setting
  FOR ALL USING (
    public.current_account_role() IN ('platform_admin', 'system_admin')
  )
  WITH CHECK (
    public.current_account_role() IN ('platform_admin', 'system_admin')
  );

COMMIT;
