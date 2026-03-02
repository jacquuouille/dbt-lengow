with clients_products as (

    select * from {{ ref('fct_products_matching') }} 

), 

competitiveness_products as (

    select
        product_id,
        title, 
        sum(case when price_competitiveness = 'Competitive' then 1 else 0 end) as competitive_count,
    from clients_products
    group by 1, 2

), 

competitiveness_ranking as (

    select 
        *,
        dense_rank() over(order by competitive_count desc) as rank -- taking ties into account, so if multiple products have the same competitive count, they will receive the same rank
    from competitiveness_products 
    where competitive_count > 0 -- filtering to include only products that have at least one instance of being 'winning' in terms of price competitiveness

), 

final as (

    select * from competitiveness_ranking
    where rank <= 10
    order by rank

)

select * from final