BEGIN;

INSERT INTO public.app_setting (
  setting_name,
  setting_value,
  created_at,
  updated_at
)
VALUES (
  'retention.order_days',
  '365',
  now(),
  now()
)
ON CONFLICT (setting_name) WHERE archived_at IS NULL
DO UPDATE SET
  setting_value = EXCLUDED.setting_value,
  updated_at = now();

CREATE OR REPLACE FUNCTION public.run_order_retention(retention_days integer)
RETURNS integer
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  archived_count integer;
BEGIN
  IF retention_days < 30 THEN
    RAISE EXCEPTION 'retention_days must be at least 30';
  END IF;
  IF public.current_account_role() <> 'system_admin' THEN
    RAISE EXCEPTION 'system administrator access required';
  END IF;

  UPDATE public.customer_order
  SET archived_at = now(),
      updated_at = now()
  WHERE archived_at IS NULL
    AND updated_at < now() - make_interval(days => retention_days);

  GET DIAGNOSTICS archived_count = ROW_COUNT;
  RETURN archived_count;
END;
$$;

COMMIT;
