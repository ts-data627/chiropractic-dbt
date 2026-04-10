{{ config(materialized='table') }}

select
    b.insurance_type,
    b.service_type,
    b.payment_date,
    count(*)                                     as total_claims,
    sum(b.charge_amount)                         as total_charged,
    sum(b.paid_amount)                           as total_paid,
    round(
        sum(b.paid_amount)::numeric
        / nullif(sum(b.charge_amount), 0)::numeric * 100, 2
    )                                            as collection_rate_pct,
    avg(b.charge_amount)                         as avg_charge,
    avg(b.paid_amount)                           as avg_paid
from {{ ref('stg_billing') }} b
group by
    b.insurance_type,
    b.service_type,
    b.payment_date