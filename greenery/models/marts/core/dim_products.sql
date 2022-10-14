{{
    config(
        materialized='table'
    )
}}

with products as (
    select * from {{ ref('stg_greenery__products')}}
)

select * from products