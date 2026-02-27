with clients_products as (

    select * from {{ ref('fct_products_matching') }} 

), 

competitiveness_products as (

    select
        product_id,
        title, 
        sum(case when price_competitiveness = 'winning' then 1 else 0 end) as competitive_count,
    from clients_products
    group by 1, 2

), 

competitiveness_ranking as (

    select 
        *,
        dense_rank() over(order by competitive_count desc) as rank -- taking ties into account, so if multiple products have the same competitive count, they will receive the same rank, and the next rank will be skipped accordingly. This allows for a more accurate representation of the competitive landscape among the products.
    from competitiveness_products 
    where competitive_count > 0 -- filtering to include only products that have at least one instance of being 'winning' in terms of price competitiveness, ensuring that the analysis focuses on products that are actively competing in the market.   

), 

final as (

    select * from competitiveness_ranking
    where rank <= 10
    order by rank

)

select * from final