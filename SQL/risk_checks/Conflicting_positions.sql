--Risk Check 01: Conflicting Positions
/*Flags users who hold both YES and NO positions
above a threshold, indicating potential system issues*/

insert into risk_exceptions (exception_type, description, user_id, market_id)
select 
  'CONFLICTING POSITIONS' as exception_type,
  'User shows YES & NO exposure in same market' as description,
  p.user_id,
  p.market_id
 from positions p
 where yes_position >20 
  and no_position >20
  ORDER by p.market_id, p.user_id;
