{{
    config(
        alias = 'stg_acceptance', 
        materialized = 'table',
        schema = 'staging'
    )
}}

with raw_data as (
    select 
        * 
    from 
        {{ source('raw_globepay', 'ACCEPTANCE_REPORT') }}
)

select 
    external_ref::varchar as external_ref,
    status::BOOLEAN as status,
    source::varchar as source,
    ref::varchar as ref,
    date_time::timestamp as occured_at,
    lower(state)::varchar as state,
    cvv_provided::BOOLEAN as cvv_provided,
    amount::float as amount,
    country::varchar as country,
    currency::varchar as currency,
    rates::variant  as rates
from
    raw_data