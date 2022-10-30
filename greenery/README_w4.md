Answers to questions for the week 4 of the project:

Which orders changed from week 3 to week 4?

5741e351-3124-4de7-9dff-01a448e7dfd4
aafb9fbd-56e1-4dcc-b6b2-a3fd91381bb6
38c516e8-b23a-493a-8a5c-bf7b2b9ea995
e24985f3-2fb3-456e-a1aa-aaf88f490d70
d1020671-7cdf-493c-b008-c48535415611
8385cfcd-2b3f-443a-a676-9756f7eb5404

 select *
      from orders_snapshot
      where cast(dbt_updated_at as date) >= '2022-10-25'

How are our users moving through the product funnel?
Users tend to spend a lot of time browsing product pages before adding a product to their cart and then checking out.

Which steps in the funnel have the largest drop-off points?
Varies between products.

Funnel:
Page View > Add to Cart > Checkout  
Dropoffs: 
First step: 19.2% drop-off
Second step: 18.34% drop-off

Funnel created on top of my int_sessions_events_agg table.

SELECT 
    COUNT_IF(page_views>0) page_views,
    COUNT_IF(add_to_carts>0) add_to_carts,
    COUNT_IF(checkouts>0) checkouts
FROM
    INT_SESSION_EVENTS_AGG

Reflecting on my learning so far:
In a current situation using dbt cloud made our data engineering really shallow, and overall a tedious part. In order to step up the game we should move into direction of the dbt core and leverage cloud only for the scheduling part. All DWHE in my company love to use their IDEs and are good in coding -nnow with my knowledge I can introduce them to dbt core. It's way more convenient that the cloud version of the dbt. Packages, code written in terminal - I can open up a whole new world for my beloved geeks in the team :)