Answers to questions for the week 3 of the project:

What's the conversion rate?
- 62.45%

Query:
SELECT
    DIV0(SUM(order_count), SUM(sessions))
FROM
    user_order_facts
____

What's the conversion rate per product?
You can find detailed answer running this query:
select
    product_name,
    count(distinct (case when event_type = 'checkout' then session_id end)) as checkouts,
    count(distinct session_id) as sessions,
    div0(checkouts,sessions) as conversion_rate
from fact_product_views
group by 1
order by 4 desc
_____

Macro is under the int_session_agg.sql file for looping through the event_types.
____

Post hook for granting permission is in the dbt_project.yml file
____

Packages that are used are dbt_utils and codegen.
First one is used to enumerate over distinct column entries, second one is used to generate documentation in an automated way.
____

Snapshot - these three orders below has changed over the last week:
939767ac-357a-4bec-91f8-a7b25edd46c9
05202733-0e17-4726-97c2-0520c024ab85
914b8929-e04a-40f8-86ee-357f2be3a2a2

 select *
      from orders_snapshot
      where cast(dbt_updated_at as date) >= '2022-10-13'