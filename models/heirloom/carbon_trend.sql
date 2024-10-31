{{ config(enabled=false) }}

with analysis as (
    select *
    from {{ ref('analysis') }}
),

sample as (
    select *
    from {{ ref('sample') }}
),

process as (
    select *
    from {{ ref('process') }}
),

joined as (
    select
        p.experiment_id,
        p.process_id,
        s.sample_id,
        s.time_taken,
        r.result.value as carbon_content
    from analysis a
    inner join analysis_result r
        on a.experiment_id = r.experiment_id
        and a.process_id = r.process_id
        and a.sample_id = r.sample_id
        and a.analysis_id = r.analysis_id
    inner join sample s
        on a.experiment_id = s.experiment_id
        and a.process_id = s.process_id
        and a.sample_id = s.sample_id
    inner join process p
        on s.experiment_id = p.experiment_id
        and s.process_id = p.process_id
),

agg as (
    select
        experiment_id,
        process_id,
        sample_id,
        avg(carbon_content) as sample_carbon
    from joined
    group by experiment_id, process_id, sample_id
)

select
    a.experiment_id,
    a.process_id,
    a.sample_id,
    a.sample_carbon
from agg a
left join sample s
    on a.experiment_id = s.experiment_id
    and a.process_id = s.process_id
    and a.sample_id = s.sample_id
order by s.time_taken
