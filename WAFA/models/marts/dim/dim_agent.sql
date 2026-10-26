{{ config(
    materialized = 'table'
) }}

with agents as (

    select *
    from {{ ref('stg_agents') }}

),

final as (

    select
        agent_id,
        agent_name,
        city as agent_city,
        region as agent_region,
        _etl_loaded_at

    from agents

)

select *
from final