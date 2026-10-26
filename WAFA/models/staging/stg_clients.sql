with source as (

    select *
    from {{ source('raw_wafa', 'clients') }}

),

renamed as (

    select

        client_id,
        trim(first_name) as first_name,
        trim(last_name) as last_name,

        upper(gender) as gender,

        age,

        trim(city) as city,
        trim(region) as region,

        customer_since,

        _etl_loaded_at

    from source

)

select *
from renamed