{{ config(materialized='table', schema='gold') }}

WITH calculate AS (
    SELECT 
        dd.day AS paid_by_day,
        SUM(fc.paid_amount) AS total_paid_amount
    FROM 
        {{ ref('facts_claims') }} fc
    LEFT JOIN
        {{ ref('dim_date') }} dd ON fc.paid_date_key = dd.date_key
    WHERE
        fc.paid_date_key IS NOT NULL AND fc.paid_amount IS NOT NULL
    GROUP BY 
        dd.day 
    ORDER BY
        dd.day 
)
SELECT *
FROM calculate
