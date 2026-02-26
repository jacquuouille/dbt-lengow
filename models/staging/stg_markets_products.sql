{{ config(
    materialized='incremental',
    unique_key=['shop_id', 'product_id'],
    incremental_strategy='merge'
) }}

with source as (

    select * from {{ source('jaffle', 'market_products') }}

), 

transformed as (

    select
        shop_id,
        id as product_id,
        title as title,
        price,
        cast(stock_availability as boolean) as stock_availability,
        cast(is_active as boolean) as is_active,
        updated_at,
        cast(failed_to_update_at as timestamp) as failed_to_update_at
    from source 

)

select * from transformed