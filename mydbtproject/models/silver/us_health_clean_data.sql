{{ config(materialized='table',schema='silver') }}



with source_ush as (
SELECT 
    claim_id,
    member_id,
    name,
    address,
    email,
    CASE
        WHEN gender = 'Male' THEN 'Male'
        WHEN gender = 'Female' THEN 'Female'
        ELSE 'Others'
    END AS gender,
    CASE
        WHEN diagnosis_1 IS NOT NULL THEN diagnosis_1
        WHEN diagnosis_2 IS NOT NULL THEN diagnosis_2
        ELSE diagnosis_3
    END AS diagnosis_1,
    CASE
        WHEN diagnosis_1 IS NOT NULL AND diagnosis_2 IS NOT NULL THEN 		diagnosis_2
        WHEN diagnosis_1 IS NULL AND diagnosis_2 IS NOT NULL THEN 		diagnosis_2
        ELSE diagnosis_3
    END AS diagnosis_2,
    CASE
        WHEN diagnosis_1 IS NOT NULL AND diagnosis_2 IS NOT NULL AND 		diagnosis_3 IS NOT NULL THEN diagnosis_3
        WHEN diagnosis_1 IS NOT NULL AND diagnosis_2 IS NULL AND 		diagnosis_3 IS NOT NULL THEN diagnosis_3
        ELSE NULL
    END AS diagnosis_3,
    allowed_amount::varchar AS allowed_amount,
    paid_amount::varchar AS paid_amount,
    date_of_birth,
    enrolled_date,
    claimed_date,
    paid_date,
    created_date




 from {{ ref('us_health_table') }}
)

select *
from source_ush
