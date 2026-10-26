{{ config(
    materialized = 'table'
) }}

with claims as (

    select *
    from {{ ref('stg_claims') }}

),

contracts as (

    select
        contract_id,
        client_id,
        product_id,
        agent_id

    from {{ ref('stg_contracts') }}

),

final as (

    select
        cl.claim_id,

        -- Dimension dégénérée
        cl.contract_id,

        -- Clés étrangères vers les dimensions
        co.client_id,
        co.product_id,
        co.agent_id,

        to_number(
            to_char(cl.claim_date, 'YYYYMMDD')
        ) as claim_date_key,

        cl.claim_date,

        -- Attributs descriptifs du sinistre
        cl.claim_type,
        cl.claim_status,

        -- Mesures
        cl.declared_amount,
        cl.paid_amount,

        cl.declared_amount
            - cl.paid_amount as unpaid_amount,

        case
            when cl.declared_amount > 0
                then round(
                    cl.paid_amount / cl.declared_amount,
                    4
                )
            else 0
        end as claim_payment_ratio,

        1 as claim_count,

        cl._etl_loaded_at

    from claims cl

    inner join contracts co
        on cl.contract_id = co.contract_id

)

select *
from final