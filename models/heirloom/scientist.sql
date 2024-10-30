with src as (
    select *
    from {{ source('example_data', 'scientist') }}
),

rename as (
    select
        ID as scientist_id,
        name as scientist_name
    from src
)

select *
from rename

