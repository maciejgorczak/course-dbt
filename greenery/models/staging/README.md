Week no. 2 project
What is our user repeat rate?

with orders_cohort as (
    SELECT
        USER_ID as user_id
        , count(distinct ORDER_ID) as user_orders
    from STG_GREENERY__ORDERS
    group by 1
),

users_bucket as (
    select 
        user_id
        , (user_orders = 1)::int as has_one_purchases
        , (user_orders = 2)::int as has_two_purchases
        , (user_orders = 3)::int as has_three_purchases
    from orders_cohort
)

SELECT div0(sum(has_two_purchases), count(distinct user_id)) as repeat_rate
from users_bucket

0.225806

What are good indicators of a user who will likely purchase again?
It's all about statistics, right?
I would compare behavior of users that placed only one order -> events, site engagement, what page did they visit, what was the path that resulted in a purchase, etc. with the same data for recurring users.
For me it's all about engagement time and readability of the site. Looking into it would give us information on their behavior patterns, and probably give us insights on how we can improve our product going forward.


