create or replace view view_dashboard_master_summary as 
select
 (select total_trades from view_kpi_total_trades) as total_trades,
 (select total_users from view_kpi_total_users) as total_users,
 (select total_markets from view_kpi_total_markets) as total_markets,
 (select total_positions from view_kpi_total_positions) as total_positions,
 (select total_anomalies from view_kpi_total_anomalies) as total_anomalies,
 (select anomaly_rate_percent from view_anomaly_rate) as anomaly_rate_percent;