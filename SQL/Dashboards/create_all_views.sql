-- CLEAROPS: DASHBOARD VIEW LOADER
-- Runs all dashboard view creation scripts in the correct order.
-- Execute file ONCE after cloning the repo or refreshing views.

\i view_kpi_total_trades.sql
\i view_kpi_total_users.sql
\i view_kpi_total_markets.sql
\i view_kpi_total_positions.sql
\i view_kpi_total_anomalies.sql

\i view_anomalies_by_type.sql
\i view_anomaly_rate.sql
\i view_anomalies_by_market.sql

\i view_top_users_by_ts_drift.sql
\i view_top_markets_by_ts_drift.sql

\i view_duplicate_trade_summary.sql
\i view_invalid_price_summary.sql
\i view_conflicting_positions_summary.sql
\i view_settlement_mismatch_summary.sql

\i view_dashboard_master_summary.sql

-- END OF FILE

