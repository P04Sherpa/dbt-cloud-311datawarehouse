WITH street_conditions_311 AS
(
    SELECT *
    FROM `raw.raw_street_conditions`
)
SELECT *, current_timestamp() as loaded_at
FROM street_conditions_31