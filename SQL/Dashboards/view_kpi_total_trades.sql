create or replace view view_kpi_total_trades as
select count(*) as total_trades
from trades;