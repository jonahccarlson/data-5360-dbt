{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
)}}

select
    date_key,
    employee_key,
    certification_name,
    certification_cost
from {{ ref('stg_employee_certifications') }} ec
left join {{ ref('oliver_dim_date') }} d on ec.certification_awarded_date = d.date_key
left join {{ ref('oliver_dim_employee') }} e on ec.employee_id = e.employee_id