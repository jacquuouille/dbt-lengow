with clients_products as (

        select * from {{ ref('stg_clients_products') }}

), 

markets_products as (

    select * from {{ ref('stg_markets_products') }}

), 

matched as (

    select
        md5(c.product_id || '-' || m.shop_id || '-' || m.product_id) as matching_id, -- md5 hash of the concatenated keys to create a unique identifier for the match
        c.product_id as client_product_id, 
        m.shop_id,
        m.product_id as market_product_id,
        current_timestamp() as matched_at 
    from clients_products c
    join markets_products m on c.product_id = m.product_id -- using an inner join to find matches based on product_id, meaning all clients's products available in the market will be included in the result

)

select * from matched