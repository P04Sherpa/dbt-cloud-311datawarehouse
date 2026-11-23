with contributing_factor_columns as (
    select distinct
        contributing_factor_vehicle_1,
        contributing_factor_vehicle_2,
        contributing_factor_vehicle_3,
        contributing_factor_vehicle_4,
        contributing_factor_vehicle_5
    from {{ ref('motor_vehicle_collisions') }}
)
select
    row_number() over (
        order by
            contributing_factor_vehicle_1,
            contributing_factor_vehicle_2,
            contributing_factor_vehicle_3,
            contributing_factor_vehicle_4,
            contributing_factor_vehicle_5
    ) as contributing_factor_dimension_id,
    contributing_factor_vehicle_1,
    contributing_factor_vehicle_2,
    contributing_factor_vehicle_3,
    contributing_factor_vehicle_4,
    contributing_factor_vehicle_5,
    current_timestamp() as loaded_at
from contributing_factor_columns
order by
    contributing_factor_vehicle_1,
    contributing_factor_vehicle_2,
    contributing_factor_vehicle_3,
    contributing_factor_vehicle_4,
    contributing_factor_vehicle_5