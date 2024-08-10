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
        {{ source('raw_globepay', 'acceptance_report') }}
)

select 
    external_ref::varchar,
    status::bool,
    "source"::varchar,
    "ref"::varchar,
    date_time::timestamp as occured_at,
    lower("state")::varchar as "state",
    cvv_provided::bool,
    amount::float,
    country::varchar,
    currency::varchar,
    rates::jsonb
from
    raw_data