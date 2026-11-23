with location_columns as (
    select distinct
        location,
        incident_zip,
        borough,
        incident_address,
        longitude,
        latitude
    from {{ ref('street_conditions') }}
    order by 1, 2, 3, 4, 5, 6
)
select
    row_number() over (order by location, incident_zip, borough, incident_address, longitude, latitude) as location_dim_id,
    location,
    incident_zip,
    borough,
    incident_address,
    longitude,
    latitude,
    current_timestamp() as loaded_at
from location_columns
order by location, incident_zip, borough, incident_address, longitude, latitude