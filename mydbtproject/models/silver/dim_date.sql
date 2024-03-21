{{ config(materialized='table', schema='silver') }}
 
with us_healthcare_claims_data AS (
    SELECT *
    FROM {{ ref('us_health_clean_data') }}
),
dates_data AS (
    SELECT
        DISTINCT DATE(dates) as date_key,
        EXTRACT(DAY FROM dates) as day,
        EXTRACT(MONTH FROM dates) as month,
        EXTRACT(YEAR FROM dates) as year,
        EXTRACT(QUARTER FROM dates) as quarter,
        EXTRACT(DOW FROM dates) as day_of_week,
        EXTRACT(DOY FROM dates) as day_of_year,
        EXTRACT(WEEK FROM dates) as week_of_year,
        CASE WHEN EXTRACT(ISODOW FROM dates) IN (6, 7) THEN 1 ELSE 0 END as is_weekend
    FROM (
        SELECT enrolled_date as dates FROM us_healthcare_claims_data
        UNION
        SELECT claimed_date as dates FROM us_healthcare_claims_data
        UNION
        SELECT paid_date as dates FROM us_healthcare_claims_data
        UNION
        SELECT created_date as dates FROM us_healthcare_claims_data
    ) AS all_dates
    ORDER BY date_key
)
 
SELECT *
FROM dates_data
 