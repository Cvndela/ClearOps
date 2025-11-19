create or replace view view_kpi_total_positions as
select count(*) as total_positions
from positions;