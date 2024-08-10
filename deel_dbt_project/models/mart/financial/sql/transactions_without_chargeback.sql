{{
    config(
        alias = 'transactions_without_chargeback', 
        materialized = 'view',
        schema = 'financial',
		tags=["mart"]
    )
}}

/* 
    Despite the fact that the table staging.stg_chargeback has a test for not null, 
    it returns the list of transactions for those who have.
*/
select
    transaction_id
from
    {{ref('acceptance_with_chargeback')}}
where
    is_chargeback is null