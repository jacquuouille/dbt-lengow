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

), 

metrics as (

    select 
        *,

        client_price - market_price as price_difference,
        
        round(
            (client_price - market_price) / market_price * 100, 1) as price_difference_percentage,

        round(
            client_price / market_price, 2) as price_ratio,
        
        case 
            when client_price < market_price then 'winning' 
            when client_price > market_price then 'losing'
            when client_price = market_price then 'tie'
        end as price_comparison_result
    
    from filtered

)

select * from metrics