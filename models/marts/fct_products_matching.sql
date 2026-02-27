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
        client_price - market_price as price_difference, -- calculating the price difference between the client's price and the market price to identify potential pricing opportunities or discrepancies
        
        round(
            (client_price - market_price) / market_price * 100, 1) as price_difference_percentage, -- calculating the percentage difference in price to provide a relative measure of
        
        case 
            when client_price < market_price then 'winning' 
            when client_price > market_price then 'losing'
            when client_price = market_price then 'tie'
        end as price_comparison_result, -- measures the share of matches where the client product is 'winning' (cheapest) vs 'losing' (more expensive) compared to the market price, providing insights into the client's competitive positioning in the market.
        
        round(
            client_price / market_price, 2) as price_ratio -- calculating the price ratio to understand how the client's price compares to the market price, with a ratio less than 1 indicating a cheaper price and greater than 1 indicating a more expensive price
    
    from filtered

)

select * from metrics