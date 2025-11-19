--Position Computation
--Full ledger build
insert
	into
	positions (user_id,
	market_id,
	yes_position,
	no_position)
select
	u.user_id,
	m.market_id,
	0,
	0
from
	users u
cross join markets m;


--Applying actual positions based on trades
update
	positions p
set
	yes_position = coalesce(t.yes_qty, 0),
	no_position = coalesce(t.no_qty, 0)
from
	(
	select
		user_id,
		market_id,
		sum(case when contract_type = 'YES' then quantity else 0 end) as yes_qty,
		sum(case when contract_type = 'NO' then quantity else 0 end) as no_qty
	from
		trades
	group by
		user_id,
		market_id
) t
where
	p.user_id = t.user_id
	and p.market_id = t.market_id;

--Sanity Check
select
	count(*)
from
	positions;

select
	sum(yes_position) as total_yes_exposure,
	sum(no_position) as total_no_exposure
from
	positions;


select count(*) from positions