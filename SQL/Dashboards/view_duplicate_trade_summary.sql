create or replace view view_duplicate_trade_summary as
select 
  user_id,
  market_id,
  count(*) as duplicate_trades
from risk_exceptions
where exception_type = 'DUPLICATE_TRADE'
group by user_id, market_id
order by duplicate_trades desc;