with src as (
    select *
    from {{ source('example_data', 'samples') }}
),

rename as (
    select
        experiment_id,
        process_id,
        sample_id,
        time_taken
    from src
)

select *
from rename

