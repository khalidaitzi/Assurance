with source as (

    select *
    from {{ source('raw_wafa', 'claims') }}

),

renamed as (

    select
        claim_id,
        contract_id,

        cast(claim_date as date) as claim_date,

        upper(trim(claim_type)) as claim_type,

        cast(declared_amount as number(18, 2)) as declared_amount,
        cast(paid_amount as number(18, 2)) as paid_amount,

        upper(trim(status)) as claim_status,

        cast(_etl_loaded_at as timestamp_ntz) as _etl_loaded_at

    from source

),

calculated as (

    select
        *,

        declared_amount - paid_amount as unpaid_amount,

        case
            when declared_amount = 0 then 0
            else round(paid_amount / declared_amount, 4)
        end as claim_payment_ratio

    from renamed

)

select *
from calculated