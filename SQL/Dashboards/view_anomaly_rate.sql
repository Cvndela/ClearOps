create or replace view view_anomaly_rate as
select 
 round (
 (select count(*) from risk_exceptions)::numeric
 /
 (select count(*) from trades) * 100, 2) as anomaly_rate_percent;