{{ config(materialized='view') }}

select
    billing_id,
    appt_id,
    patient_id,
    cpt_code::text                               as cpt_code,
    service_type,
    charge_amount::numeric                       as charge_amount,
    paid_amount::numeric                         as paid_amount,
    round(paid_amount::numeric /
        nullif(charge_amount::numeric, 0), 4)    as collection_rate,
    insurance_type,
    payment_date::date                           as payment_date,
    transformed_at
from {{ source('public', 'billing') }}
where is_valid = true -- keeps "bad" rows out of transformation layer