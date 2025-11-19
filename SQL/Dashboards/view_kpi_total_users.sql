create or replace view view_kpi_total_users as
select count(*) as total_users
from users;

