{{ config(materialized='table',schema='silver') }}


with source_ush as (
    select 
    "Diagnosis_Code" AS diagnosis_code,	
    "Category_Code" AS category_code, 	
    "Full_Code" as full_code,
    "Full_Description" as full_description,
    "Category_Title" AS category_title
     from {{ ref('icd_codes') }}
)

select *
from source_ush
