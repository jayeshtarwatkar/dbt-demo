{{ config(materialized='table',schema='bronze') }}


with source_ush as (
    select  *
    from {{ source('bootcamp','US_Healthcare_Claims') }}
)

select *
from source_ush
