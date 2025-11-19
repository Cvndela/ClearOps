create or replace view view_kpi_total_markets as
select count(*) as total_markets
from markets;