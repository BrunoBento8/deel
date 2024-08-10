{{
    config(
        alias = 'stg_chargeback', 
        materialized = 'table',
        schema = 'staging'
    )
}}

with raw_data as (
    select 
        *
    from 
        {{ source('raw_globepay', 'chargeback_report') }}
)

select 
    external_ref::varchar,
    "status"::bool,
    "source"::varchar,
    chargeback::bool as is_chargeback
from
    raw_data