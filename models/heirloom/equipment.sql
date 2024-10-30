with src as (
    select *
    from {{ source('example_data', 'equipment') }}
),

rename as (
    select
        ID as equipment_id,
        name as equipment_name
    from src
)

select *
from rename

