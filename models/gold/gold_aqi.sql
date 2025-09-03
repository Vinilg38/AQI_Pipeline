{{ config(
    materialized='table'
) }}

SELECT
    -- Extract the date from the timestamp
    TO_CHAR(report_date, 'YYYY-MM') AS report_month,
    state,
    area,
    -- Calculate key metrics using the cleaned aqi value
    AVG(cleaned_aqi_value) AS avg_daily_aqi,
    MAX(cleaned_aqi_value) AS max_daily_aqi,
    MIN(cleaned_aqi_value) AS min_daily_aqi,
    -- Count the number of distinct pollutants reported for that day
    COUNT(DISTINCT pollutant_name) AS pollutants_count,
    COUNT(CASE WHEN aqi_status='Poor' THEN 1 ELSE NULL END) AS poor_aq_status_count
FROM
    {{ ref('silver_aqi') }}
GROUP BY
    1, 2,3
ORDER BY
    1,2,3

