{{
    config(
        materialized='table'
    )
}}

with events as (
    select * from {{ ref('stg_greenery__events')}}
),

{%-
    set event_types = dbt_utils.get_column_values(
        table = ref('stg_greenery__events')
        , column = 'event_type'
        , order_by = 'event_type asc'
    )

-%}

final as (
    SELECT
          user_id
        , session_id
        , min(created_at) session_start
        , max(case when event_type != 'package_shipped' then created_at else NULL end) session_end
        , timediff(second, min(created_at), max(case when event_type != 'package_shipped' then created_at else NULL end)) session_duration
        , count(*) as total_events
        , count(distinct product_id) as total_products
        {%- for event_type in event_types %}
        , sum(case when event_type = '{{ event_type }}' then 1 else 0 end) as {{ event_type }}s
        {%- endfor %}
    from events
    group by 1,2
)

select * from final