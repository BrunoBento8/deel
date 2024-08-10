{{
    config(
        alias = 'declined_amounts', 
        materialized = 'view',
        schema = 'financial'
    )
}}

with country_amounts as (
    select
        country,
        amount
    from
        {{ref('acceptance_with_chargeback')}}
    where
        state = 'declined'
)

select
    country,
    sum(amount) as total_amount
from
    country_amounts
group by 
	1
having
	sum(amount) > 25000000
order by
	sum(amount) desc