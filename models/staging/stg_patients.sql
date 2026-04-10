{{ config(materialized='view') }}

select
    patient_id,
    first_name,
    last_name,
    date_of_birth::date                          as date_of_birth,
    age,
    gender,
    city,
    state,
    zip_code::text                               as zip_code,
    insurance_type,
    created_at::timestamp                        as created_at,
    transformed_at
from {{ source('public', 'patients') }}
where is_valid = true