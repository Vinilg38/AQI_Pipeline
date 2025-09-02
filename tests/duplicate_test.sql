SELECT
    report_date,
    state,
    area,
    num_stations,
    pollutant_name,
    aqi_value,
    aqi_status,
    unit,
    note,
    cleaned_aqi_value
FROM {{ ref('silver_aqi') }}
GROUP BY
    report_date,
    state,
    area,
    num_stations,
    pollutant_name,
    aqi_value,
    aqi_status,
    unit,
    note,
    cleaned_aqi_value
HAVING COUNT(*) > 1