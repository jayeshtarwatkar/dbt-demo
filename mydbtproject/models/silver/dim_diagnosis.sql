{{ config(materialized='table',schema='silver') }}



with source_ush as (
SELECT 
	full_code as diagnosis_key,
	diagnosis_code,
	category_code,
	full_description,
	category_title
	
  from {{ref('icd_clean_data') }}
)

select *
from source_ush
