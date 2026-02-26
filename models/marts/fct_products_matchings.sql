with matching as (

    select * from {{ ref('int_products_matching')}}

)

select * from matching