1. How many users do we have?
- 130
select count(distinct user_id)
from dev_db.dbt_mbmgorczak.stg_users


2. On average, how many orders do we receive per hour?
- 7.68
select 
    count( distinct order_id) as orders_count,
    datediff(hour, min(created_at), max(created_at)) as hour_amount,
    div0(orders_count, hour_amount)
from 
    stg_greenery__orders


3. On average, how long does an order take from being placed to being delivered?
- 93.4 hours (less than 4 days)
select 
    avg(datediff(hour, created_at, delivered_at)) as avg_delivery_time
from 
    stg_greenery__orders


4. How many users have only made one purchase? Two purchases? Three+ purchases?
- 1 -> 25
- 2 -> 28
- 3 -> 71
with stage as (
    select 
        count( distinct order_id) as purchases,
        user_id
    from 
        stg_greenery__orders
    group by
        user_id)

select
    CASE WHEN purchases = 1 then '1'
        when purchases = 2 then '2'
        when purchases >= 3 then '3+'
        end as purchases,
    count(distinct user_id)
from stage
group by 1


On average, how many unique sessions do we have per hour?
- 16,32
with sessions_per_hour as (
    select
      date_trunc('hour',created_at) as hour_created_at
      , count(distinct session_id) as session_count
    from stg_greenery__events
    group by 1
)
select avg(session_count) from sessions_per_hour
