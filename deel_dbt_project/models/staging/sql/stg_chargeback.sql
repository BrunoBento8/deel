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
        {{ source('raw_globepay', 'CHARGEBACK_REPORT') }}
)

select 
    external_ref::varchar as external_ref,
    status::BOOLEAN as status,
    source::varchar as source,
    chargeback::BOOLEAN as is_chargeback
from
    raw_data