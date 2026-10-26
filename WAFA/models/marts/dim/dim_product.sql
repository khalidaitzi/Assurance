{{ config(
    materialized = 'table'
) }}

with products as (

    select *
    from {{ ref('stg_products') }}

),

final as (

    select
        product_id,
        product_name,
        product_category,
        _etl_loaded_at

    from products

)

select *
from final