with
    agency_columns as (
        select distinct agency, agency_name
        from {{ ref("street_conditions") }}
        order by 1, 2
    )
select
    row_number() over () as agency_dim_id,
    agency,
    agency_name,
    current_timestamp() as loaded_at
from agency_columns
order by agency, agency_name
