create or replace view view_anomalies_by_type as
select 
 exception_type,
 count(*) as anomaly_count
from risk_exceptions
group by exception_type
order by anomaly_count desc;