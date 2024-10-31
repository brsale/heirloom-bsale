with src as (
    select *
    from {{ source('example_data', 'experiment') }}
),

unnest as (
    select
        experiment_id,
        unnest(processes) as process
    from src
),

rename as (
    select
        experiment_id,
        process ->> '$.process_id' as process_id,
        process ->> '$.name' as process_name,
        process ->> '$.equipment_id' as equipment_id,
        process ->> '$.start_time' as start_time,
        process ->> '$.end_time' as end_time,
        process -> '$.inputs' ->> '$.material' as input_material,
        process -> '$.inputs' ->> '$.temperature' as input_temperature,
        process -> '$.inputs' ->> '$.catalyst' as input_catalyst,
        process -> '$.inputs' ->> '$.condition1' as input_condition1,
        process -> '$.outputs' ->> '$.material' as output_material
    from unnest
)

select *
from rename

