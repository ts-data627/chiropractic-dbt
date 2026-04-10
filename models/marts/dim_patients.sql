{{ config(materialized='table') }}

select
    patient_id,
    first_name,
    last_name,
    date_of_birth,
    age,
    case
        when age < 18  then 'Under 18'
        when age < 35  then '18-34'
        when age < 50  then '35-49'
        when age < 65  then '50-64'
        else '65+'
    end                                          as age_bucket,
    gender,
    city,
    state,
    zip_code,
    insurance_type,
    created_at
from {{ ref('stg_patients') }}