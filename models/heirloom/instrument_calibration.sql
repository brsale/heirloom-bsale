{{ config(enabled=false) }}

with instrument as (
    select *
    from {{ ref('instrument') }}
),

calibration as (
    select *
    from {{ ref('calibration') }}
),

-- if you wanted historical status "time windows", you'd start with a
-- date spine and then join equipment onto that
-- ideally, there would be an "acquisition date" or something of that
-- sort on the instrument object/entity
last_status as (
    select *
    from calibration c
    qualify row_number() over (partition by c.instrument_id order by c.event_time desc) = 1
),

current_status as (
    select
        i.instrument_id,
        s.pass as calibrated -- this is a bool T/F
    from instrument i
    left join status s
        on i.instrument_id = s.instrument_id
)

select *
from current_status
