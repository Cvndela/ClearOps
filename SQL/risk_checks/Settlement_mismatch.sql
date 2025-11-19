--Risk Check 05: Settlement Mismatch
/*Flags cases where user exposures conflict with
the markets recorded outcome, indicating potential 
settlement errors*/
insert into risk_exceptions (exception_type, description, user_id, trade_id, market_id)
select 
  'SETTLEMENT_MISMATCH' as exception_type,
  'Exposure inconsistent with market outcome',
  p.user_id,
  null,
  p.market_id
from positions p
join markets m on p.market_id = m.market_id
where m.outcome is not null
 and (
      (m.outcome = 'YES' and p.no_position > 50)
    or (m.outcome = 'NO' and p.yes_position > 50)
 );


SELECT count(*), exception_type FROM risk_exceptions GROUP BY exception_type