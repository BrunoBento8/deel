{{
    config(
        alias = 'acceptance_rate', 
        materialized = 'view',
        schema = 'financial'
    )
}}

-- Table do answer the question: What is the acceptance rate over time?
-- Granularity: Day

with structured_acceptance as (
    select
        *
    from
        {{ref('acceptance_with_chargeback')}}
),

-- Calculating quantity of acceptances each day
acceptance_numbers as (
	select
	    date_trunc('day', occured_at) as transation_day,
	    sum(case when state = 'accepted' then 1 else 0 end) as total_acceptances,
	    count(*) as total_transations
	from
	    structured_acceptance
	group by 1
)

select
	transation_day,
	round(total_acceptances*1.00/total_transations, 2) as acceptance_rate
from
	acceptance_numbers