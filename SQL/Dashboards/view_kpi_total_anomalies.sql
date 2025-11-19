create or replace view view_kpi_total_anomalies as
select count(*) as total_anomalies
from risk_exceptions;