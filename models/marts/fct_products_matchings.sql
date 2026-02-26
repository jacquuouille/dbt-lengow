with clients_products as (

    select * from {{ ref('stg_clients_products') }}

), 

market_products as (

    select * from {{ ref('stg_markets_products') }}

), 

matching as (

    select * from {{ ref('int_products_matching')}}

),

matched as (

    select
        m.matching_id,
        cp.product_id,
        cp.title as title,
        cp.main_category as category,
        cp.price as client_price,
        cp.stock_availability as client_stock,
        mp.shop_id as market_shop_id, 
        mp.price as market_price,
        mp.stock_availability as market_stock,
        current_timestamp as created_at  
    from matching m
    left join clients_products cp on m.client_product_id = cp.product_id
    left join market_products mp on m.market_product_id = mp.product_id and m.shop_id = mp.shop_id
    where 
        cp.is_active= true 
        and mp.is_active = true

)

select * from matched