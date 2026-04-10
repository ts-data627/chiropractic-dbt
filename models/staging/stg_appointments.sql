{{ config(materialized='view') }}

select
    appt_id,
    patient_id,
    provider_id,
    appt_date::date                              as appt_date,
    service_type,
    status,
    case when status = 'no_show' then true
         else false end                          as is_no_show,
    transformed_at
from {{ source('public', 'appointments') }}
where is_valid = true