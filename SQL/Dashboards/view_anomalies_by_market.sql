create or replace view view_anomalies_by_market as
select 
 market_id,
 count(*) as anomaly_count
from risk_exceptions
group by market_id
order by anomaly_count desc;