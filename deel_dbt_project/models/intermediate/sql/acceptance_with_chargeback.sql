{{
    config(
        alias = 'acceptance_with_chargeback', 
        materialized = 'table',
        schema = 'intermediate'
    )
}}

-- Some of the columns were removed because they did not present different values and did not impact the analyst's requests.
select
    a.external_ref as transaction_id,
    c.is_chargeback,
    a.occurred_at,
    a.state,
    a.cvv_provided,
    a.amount,
    a.country,
    a.currency,
    a.rates,
    {{ currency_rates('rates') }} -- Bringing the currency rates 
from
    {{ref('stg_acceptance')}} a
inner join
    {{ref('stg_chargeback')}} c on a.external_ref = c.external_ref
