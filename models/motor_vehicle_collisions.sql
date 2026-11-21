WITH street_conditions_311 AS
(
    SELECT *
    FROM `raw.motor_vehicle_collisions`
)
SELECT *, current_timestamp() as loaded_at
FROM street_conditions_311