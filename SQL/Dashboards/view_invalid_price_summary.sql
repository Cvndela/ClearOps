create or replace view view_invalid_price_summary as
select 
  user_id,
  market_id,
  count(*) as bad_prices
from risk_exceptions
where exception_type = 'INVALID_PRICE'
group by user_id, market_id
order by bad_prices desc;