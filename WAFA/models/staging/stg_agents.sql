with source as (

    select *
    from {{ source('raw_wafa', 'agents') }}

),

stg_agents as (

    select
        agent_id,
        agent_name,
        city,
        region,
        _etl_loaded_at

    from source

)

select *
from stg_agents