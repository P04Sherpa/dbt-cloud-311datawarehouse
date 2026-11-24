with location_columns as (
    select distinct
        zip_code,
        borough,
        longitude,
        latitude
    from {{ ref('motor_vehicle_collisions') }}
)
select
    row_number() over (
        order by zip_code, borough, longitude, latitude
    ) as location_dimension_id,
    zip_code,
    borough,
    longitude,
    latitude,
    current_timestamp() as loaded_at
from location_columns
order by zip_code, borough, longitude, latitude