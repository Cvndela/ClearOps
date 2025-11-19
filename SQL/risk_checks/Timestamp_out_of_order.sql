--Risk Check 04: Timestamp Out of order
/*Detects trades with timestamps earlier/later than surrounding trades,
indicating sequencing issues or delayed messages*/
with ordered as (
select
	trade_id,
	user_id,
	market_id,
	timestamp,
	lag(timestamp) over (
            partition by user_id,
	market_id
order by
	trade_id
        ) as prev_timestamp
from
	trades
)
insert
	into
	risk_exceptions (exception_type,
	description,
	user_id,
	trade_id,
	market_id)
select
	'TIMESTAMP_OUT_OF_ORDER' as exception_type,
	'Trade timestamp earlier than previous trade' as description,
	user_id,
	trade_id,
	market_id
from
	ordered
where
	prev_timestamp is not null
	and timestamp < prev_timestamp;

