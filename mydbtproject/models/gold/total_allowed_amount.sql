{{ config(materialized='table',schema='gold') }}



with source_ush as (
SELECT 
	SUM(allowed_amount) as total_allowed_amount
  from {{ref('facts_claims') }}
)

select *
from source_ush
