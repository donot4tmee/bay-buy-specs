BEGIN;

GRANT USAGE ON SCHEMA public TO anon, authenticated;

GRANT SELECT ON TABLE
  public.business,
  public.product
TO anon;

GRANT SELECT ON TABLE
  public.account,
  public.business,
  public.product,
  public.customer_order,
  public.order_line,
  public.content_report,
  public.app_setting
TO authenticated;

GRANT INSERT, UPDATE, DELETE ON TABLE
  public.account,
  public.business,
  public.product,
  public.customer_order,
  public.order_line,
  public.content_report,
  public.app_setting
TO authenticated;

COMMIT;
