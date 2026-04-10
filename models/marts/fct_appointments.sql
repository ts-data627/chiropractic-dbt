{{ config(materialized='table') }}

select
    a.appt_date,
    a.provider_id,
    p.provider_name,
    p.specialty,
    a.service_type,
    count(*)                                     as total_appointments,
    sum(case when a.is_no_show then 1 else 0 end) as no_shows,
    round(
        sum(case when a.is_no_show then 1 else 0 end)::numeric
        / nullif(count(*), 0)::numeric * 100, 2
    )                                            as no_show_rate_pct
from {{ ref('stg_appointments') }} a
left join {{ ref('stg_providers') }} p
    on a.provider_id = p.provider_id
group by
    a.appt_date,
    a.provider_id,
    p.provider_name,
    p.specialty,
    a.service_type