
WITH agency_columns AS 
(
    SELECT DISTINCT agency, agency_name 
    FROM {{ ref('street_conditions') }}
    ORDER BY 1, 2
)
SELECT
    row_number() OVER () AS agency_dim_id,
    agency, agency_name, current_timestamp() as loaded_at
FROM agency_columns
ORDER BY agency, agency_name