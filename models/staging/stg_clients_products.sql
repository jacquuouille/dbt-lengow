with source as (

    select * from {{ source('jaffle', 'clients_products') }}

), transformed as (

    select
        id as client_product_id,
        title as client_product_title,
        price,
        stock_availability,
        main_category,
        is_active,
        cast(updated_at as timestamp) as updated_at
    from source

)

select * from transformed