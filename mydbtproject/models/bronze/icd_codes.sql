{{ config(materialized='table',schema='bronze') }}


with source_ush as (
    select *
     from {{ source('bootcamp','ICD_Codes') }}
)

select *
from source_ush
