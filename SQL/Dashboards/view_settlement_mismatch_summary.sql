create or replace view view_settlement_mismatch_summary as
select 
  user_id,
  market_id
from risk_exceptions
where exception_type = 'SETTLEMENT_MISMATCH';