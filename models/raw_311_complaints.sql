WITH union_311 AS
(
    SELECT *
    FROM 'raw.raw_street_conditions'
    UNION DISTINCT
    SELECT *
    FROM 'raw.raw_motor_vehicle_collision'
)
SELECT *, current_timestamp() as loaded_at
FROM union_311