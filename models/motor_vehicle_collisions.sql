WITH street_conditions_311 AS
(
    SELECT *
    FROM `nyc-311-datawarehouse.raw.motor_vehicle_collisions`
)
SELECT *, current_timestamp() as loaded_at
FROM union_311