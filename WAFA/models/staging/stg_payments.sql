with source as (

    select *
    from {{ source('raw_wafa', 'payments') }}

),

renamed as (

    select
        payment_id,
        contract_id,

        cast(payment_date as date) as payment_date,
        cast(amount as number(18, 2)) as payment_amount,

        upper(trim(payment_method)) as payment_method,
        upper(trim(status)) as payment_status,

        cast(_etl_loaded_at as timestamp_ntz) as _etl_loaded_at

    from source

)

select *
from renamed