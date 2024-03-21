{{ config(materialized='table',schema='gold') }}



with source_ush as (
SELECT 
	SUM(paid_amount) as total_paid_amount
  from {{ref('facts_claims') }}
)

select *
from source_ush
