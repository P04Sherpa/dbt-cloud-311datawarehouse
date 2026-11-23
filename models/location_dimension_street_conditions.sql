with location_columns as (
    select distinct
        to_json_string(location) as location,
        incident_zip,
        borough,
        incident_address,
        longitude,
        latitude
    from {{ ref('street_conditions') }}
)
select
    row_number() over (
        order by incident_zip, borough, incident_address, longitude, latitude, location
    ) as location_dim_id,
    location,
    incident_zip,
    borough,
    incident_address,
    longitude,
    latitude,
    current_timestamp() as loaded_at
from location_columns
order by incident_zip, borough, incident_address, longitude, latitude, location