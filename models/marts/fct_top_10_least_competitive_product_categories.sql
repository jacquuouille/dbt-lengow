with clients_products as (

    select * from {{ ref('fct_products_matching') }} 

), 

overpriced_products as (

    select
        category,
        sum(case when price_competitiveness = 'Overpriced' then 1 else 0 end) as overpriced_count,
    from clients_products
    group by 1

), 

overpriced_products_ranking as (

    select 
        *,
        dense_rank() over(order by overpriced_count desc) as rank -- taking ties into account, so if multiple products have the same competitive count, they will receive the same rank
    from overpriced_products 
    where overpriced_count > 0 -- filtering to include only products that have at least one instance of being 'overpriced' in terms of price competitiveness

), 

final as (

    select * from overpriced_products_ranking
    where rank <= 10
    order by rank

)

select * from final