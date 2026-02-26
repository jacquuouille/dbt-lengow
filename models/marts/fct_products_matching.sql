with matching as (

    select * from {{ ref('int_products_matching')}}

), 

filtered as (

    select 
        matching_id,
        product_id,
        title,
        category,
        client_price,
        market_price,
        client_stock,
        market_stock
    from matching
    where 
        client_active is true 
        and market_active is true -- filtering to include only products that are active both on the client's side and in the market, ensuring that the analysis focuses on currently relevant products

)

select * from filtered