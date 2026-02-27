with clients_products as (

    select * from {{ ref('fct_products_matching') }} 

), 

non_competitiveness_products as (

    select
        category,
        sum(case when price_competitiveness = 'losing' then 1 else 0 end) as noncompetitive_count,
    from clients_products
    group by 1

), 

non_competitiveness_ranking as (

    select 
        *,
        dense_rank() over(order by noncompetitive_count desc) as rank -- taking ties into account, so if multiple products have the same competitive count, they will receive the same rank, and the next rank will be skipped accordingly. This allows for a more accurate representation of the competitive landscape among the products.
    from non_competitiveness_products 
    where noncompetitive_count > 0 -- filtering to include only products that have at least one instance of being 'winning' in terms of price competitiveness, ensuring that the analysis focuses on products that are actively competing in the market.   

), 

final as (

    select * from non_competitiveness_ranking
    where rank <= 10
    order by rank

)

select * from final