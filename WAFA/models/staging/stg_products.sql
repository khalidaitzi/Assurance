with source as (

    select *
    from {{ source('raw_wafa', 'products') }}

),

stg_products as (

    select
        product_id,
        product_name,
        product_category,
        _etl_loaded_at

    from source

)

select *
from stg_products