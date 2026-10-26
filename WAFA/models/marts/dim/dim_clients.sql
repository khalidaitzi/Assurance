with clients as (

    select *
    from {{ ref('stg_clients') }}

),

final as (

    select
        client_id,

        first_name,
        last_name,

        concat(
            trim(first_name),
            ' ',
            trim(last_name)
        ) as full_name,

        gender,
        age,

        case
            when age between 18 and 25 then '18-25'
            when age between 26 and 35 then '26-35'
            when age between 36 and 45 then '36-45'
            when age between 46 and 60 then '46-60'
            when age > 60 then '60+'
            else 'UNKNOWN'
        end as age_group,

        city,
        region,
        customer_since,

        datediff(
            year,
            customer_since,
            current_date()
        ) as customer_tenure_years,

        _etl_loaded_at

    from clients

)

select *
from final