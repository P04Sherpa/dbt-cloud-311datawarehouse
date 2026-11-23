with resolution_columns as (
    select distinct
        status,
        agency,
        resolution_description
    from {{ ref('street_conditions') }}
    order by 1, 2, 3
)
select
    row_number() over (order by status, agency, resolution_description) as resolution_dimension_id,
    status,
    agency,
    resolution_description,
    current_timestamp() as loaded_at
from resolution_columns
order by status, agency, resolution_description