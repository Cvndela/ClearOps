create or replace view view_top_users_by_timestamp_drift as
select 
 user_id,
 count(*) as timestamp_anomalies
from risk_exceptions
where exception_type= 'TIMESTAMP_OUT_OF_ORDER'
group by user_id
order by timestamp_anomalies desc
limit 10;