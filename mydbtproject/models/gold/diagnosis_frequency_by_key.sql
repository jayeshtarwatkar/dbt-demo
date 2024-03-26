{{ config(materialized='table', schema='gold') }}
 
WITH fact_claims AS (
  SELECT
    diagnosis_1_key,
    diagnosis_2_key,
    diagnosis_3_key
  FROM {{ ref('facts_claims') }}
),
dim_diagnosis AS (
  SELECT *
  FROM {{ ref('dim_diagnosis') }}
),
analysis AS (
    SELECT
    diagnosis_key,
    category_title
    FROM fact_claims f
    LEFT JOIN dim_diagnosis d1 ON f.diagnosis_1_key = d1.diagnosis_key
    UNION ALL
    SELECT
    diagnosis_key,
    category_title
    FROM fact_claims f
    LEFT JOIN dim_diagnosis d2 ON f.diagnosis_2_key = d2.diagnosis_key
    UNION ALL
    SELECT
    diagnosis_key,
    category_title
    FROM fact_claims f
    LEFT JOIN dim_diagnosis d3 ON f.diagnosis_3_key = d3.diagnosis_key
)
 
select
    diagnosis_key,
    category_title,
    count(*) as diagnosis_frequency
from
    analysis
where
    category_title is NOT NULL
group by
    diagnosis_key,
    category_title
order by
    diagnosis_frequency desc