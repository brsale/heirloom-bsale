with src as (
    select *
    from {{ source('example_data', 'experiment') }}
),

rename as (
    select
        experiment_id,
        name as experiment_name,
        scientist_id
    from src
)

select *
from rename

