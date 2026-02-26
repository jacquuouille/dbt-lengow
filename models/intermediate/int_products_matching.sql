{{ config(
    materialized='incremental',
    unique_key=['matching_id']
) }}

with clients_products as (

    select * from {{ ref('stg_clients_products') }}

), 

markets_products as (

    select * from {{ ref('stg_markets_products') }}

), 

matched as (

    select
        md5(cp.product_id || '-' || mp.shop_id || '-' || mp.product_id) as matching_id, -- md5 hash of the concatenated keys to create a unique identifier for the match
        cp.product_id,
        cp.title as title,
        cp.main_category as category,
        cp.price as client_price,
        cp.stock_availability as client_stock,
        cp.is_active as client_active,
        mp.shop_id as market_shop_id, 
        mp.price as market_price,
        mp.stock_availability as market_stock,
        mp.is_active as market_active,
        current_timestamp() as matched_at 
    from clients_products cp
    join markets_products mp on cp.product_id = mp.product_id -- using an inner join to find matches based on product_id, meaning all clients's products available in the market will be included in the result

)

select * from matched

{% if is_incremental() %}
    where matching_id not in (select matching_id from {{ this }})
{% endif %}