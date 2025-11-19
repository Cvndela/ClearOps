--Risk Check 02: Invalid Prices
/*Flags trades with price outside 0,1 bounds*/
insert into risk_exceptions (exception_type, description, user_id, trade_id, market_id)
select 
  'INVALID_PRICE' as exception_type,
  'Trade price outside valid [0,1] range',
  t.user_id,
  t.trade_id,
  t.market_id
from trades t
where price <0
 or price>1;

