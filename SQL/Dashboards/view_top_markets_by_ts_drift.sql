create or replace view view_top_markets_by_timestamp_drift as
select 
  market_id,
  count(*) as timestamp_anomalies
from risk_exceptions
where exception_type = 'TIMESTAMP_OUT_OF_ORDER'
group by market_id
order by timestamp_anomalies desc;