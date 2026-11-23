with vehicle_type_columns as (
    select distinct
        vehicle_type_code1,
        vehicle_type_code2,
        vehicle_type_code_3,
        vehicle_type_code_4,
        vehicle_type_code_5
    from {{ ref('motor_vehicle_collisions') }}
)
select
    row_number() over (
        order by
            vehicle_type_code1,
            vehicle_type_code2,
            vehicle_type_code_3,
            vehicle_type_code_4,
            vehicle_type_code_5
    ) as vehicle_type_dimension_id,
    vehicle_type_code1,
    vehicle_type_code2,
    vehicle_type_code_3,
    vehicle_type_code_4,
    vehicle_type_code_5,
    current_timestamp() as loaded_at
from vehicle_type_columns
order by
    vehicle_type_code1,
    vehicle_type_code2,
    vehicle_type_code_3,
    vehicle_type_code_4,
    vehicle_type_code_5