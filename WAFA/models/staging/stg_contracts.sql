with source as (

    select *
    from {{ source('raw_wafa', 'contracts') }}

),

renamed as (

    select
        contract_id,
        client_id,
        product_id,
        agent_id,

        cast(start_date as date) as start_date,
        cast(end_date as date) as end_date,

        cast(annual_premium as number(18, 2)) as annual_premium,

        upper(trim(status)) as contract_status,

        cast(_etl_loaded_at as timestamp_ntz) as _etl_loaded_at

    from source

),

validated as (

    select
        *,
        datediff('day', start_date, end_date) as contract_duration_days,

        case
            when end_date < start_date then true
            else false
        end as has_invalid_date_range

    from renamed

)

select *
from validated