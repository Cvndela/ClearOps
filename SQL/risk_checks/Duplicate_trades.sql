--Risk Check 03: Duplicate Trades
/* Flags indentical trades by same user on same market
with same price, quantity, type and timestamp*/
insert into risk_exceptions (exception_type, description, user_id, trade_id, market_id)
select 
  'DUPLICATE_TRADE' as exception_type,
  'Duplicate trade detected',
  t1.user_id,
  t1.trade_id,
  t1.market_id
from trades t1
join trades t2 on
        t1.user_id = t2.user_id
	and t1.market_id = t2.market_id
	and t1.price = t2.price
	and t1.quantity = t2.quantity
	and t1.contract_type = t2.contract_type
	and t1.timestamp = t2.timestamp
	and t1.trade_id > t2.trade_id; --in case of double counts
	
	SELECT COUNT(*),exception_type FROM risk_exceptions
	group by exception_type;
