{{ config(materialized='view') }}

select
    provider_id,
    name                                         as provider_name,
    specialty,
    hire_date::date                              as hire_date
from {{ source('public', 'providers') }}
where is_valid = true