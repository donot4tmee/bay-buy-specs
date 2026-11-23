BEGIN;

GRANT USAGE ON SCHEMA public TO service_role;

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE
  public.account,
  public.business,
  public.product,
  public.customer_order,
  public.order_line,
  public.content_report,
  public.app_setting
TO service_role;

COMMIT;
