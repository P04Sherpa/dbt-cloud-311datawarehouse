with complaint_type_columns as (
    select distinct
        complaint_type,
        descriptor
    from {{ ref('street_conditions') }}
    order by 1, 2
)
select
    row_number() over (order by complaint_type, descriptor) as complaint_dimension_id,
    complaint_type,
    descriptor,
    current_timestamp() as loaded_at
from complaint_type_columns
order by complaint_type, descriptor