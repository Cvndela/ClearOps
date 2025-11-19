create or replace view view_conflicting_positions_summary as
select 
  user_id,
  market_id,
  yes_position,
  no_position
from positions
where yes_position > 20 and no_position > 20;