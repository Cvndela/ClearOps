-- ClearOps - inject_anomalies.sql
/*Introduces realistic operational anomalies into
an otherwise clean synthetic dataset.
Run AFTER trades are loaded and positions computed,
but BEFORE running risk checks.*/

--1.Inject a few duplicate trades
--Simulates replayed messages / double ingestion

with max_id as (
select
	MAX(trade_id) as max_tid
from
	trades
),
dupes as (
select
	t.user_id,
	t.market_id,
	t.contract_type,
	t.price,
	t.quantity,
	t.timestamp,
	row_number() over () as rn
from
	trades t
order by t.timestamp
limit 2
)
insert
	into
	trades (trade_id,
	user_id,
	market_id,
	contract_type,
	price,
	quantity,
	timestamp)
select
	max_tid + rn as trade_id,
	user_id,
	market_id,
	contract_type,
	price,
	quantity,
	timestamp
from
	dupes,
	max_id;

--2.Inject a few invalid prices
--Simulates bad upstream validation or corrupted feed

update
	trades
set price = -0.10
where trade_id in (select trade_id
	from
		trades
	order by random()
	limit 1);

update
	trades
set price = 1.20
where trade_id in (select trade_id
	from
		trades
	order by random()
	limit 2);

--3.Force settlement mismatches
--Flip outcomes on markets with high exposure on the opposite side

with no_heavy as (
select
	market_id
from
	positions
group by market_id
order by SUM(no_position) desc
limit 1
),
yes_heavy as (
select
	market_id
from
	positions
group by market_id
order by SUM(yes_position) desc
limit 1
)
update
	markets m
set
	outcome = case
		when m.market_id in (select market_id
		from no_heavy) then 'YES'
		when m.market_id in (
		select market_id
		from yes_heavy) 
		then 'NO'
		else m.outcome
	end
where
	m.market_id in (select market_id
	from no_heavy
union
	select market_id
	from yes_heavy);

/* !!NOTE!!: This script is intended to be run ONCE on a clean
dataset. Re-running will stack anomalies. */

