with date_spine as (

    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="to_date('2020-01-01')",
        end_date="to_date('2030-01-01')"
    ) }}

),

final as (

    select
        to_number(to_char(date_day, 'YYYYMMDD')) as date_key,

        date_day as full_date,

        day(date_day) as day_of_month,
        dayofweekiso(date_day) as day_of_week,
        dayname(date_day) as day_name,

        weekiso(date_day) as week_number,

        month(date_day) as month_number,
        monthname(date_day) as month_name,

        quarter(date_day) as quarter_number,
        concat('Q', quarter(date_day)) as quarter_name,

        year(date_day) as year_number,

        case
            when dayofweekiso(date_day) in (6, 7)
                then true
            else false
        end as is_weekend

    from date_spine

    where date_day <= to_date('2029-12-31')

)

select *
from final
order by full_date