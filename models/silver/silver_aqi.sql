-- models/silver/stg_aqi.sql
-- This model cleans and standardizes the raw data from the bronze layer.

{{ config(
    materialized='table'
) }}

WITH source_data AS (
    -- Reference the aqi.csv file loaded by dbt seed
    SELECT * FROM {{ ref('aqi') }}
),

renamed_and_cleaned AS (
    SELECT
        -- Standardizing column names for clarity
        TO_DATE("date", 'DD-MM-YYYY') AS report_date,
        "state" AS state,
        "area" AS area,
        "number_of_monitoring_stations" AS num_stations,
        "prominent_pollutants" AS pollutant_name,
        "air_quality_status" AS aqi_status,
        "unit" AS unit,
        COALESCE("aqi_value", 0) AS cleaned_aqi_value
    FROM source_data
)

SELECT * FROM renamed_and_cleaned