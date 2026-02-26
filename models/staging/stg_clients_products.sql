{{ config(
    materialized='incremental',
    unique_key=['product_id'],
    incremental_strategy='merge'
) }}

with source as (

    select * from {{ source('jaffle', 'clients_products') }}

), 

transformed as (

    select
        id as product_id,
        title as title,
        price,
        cast(stock_availability as boolean) as stock_availability,
        main_category,
        cast(is_active as boolean) as is_active,
        cast(updated_at as timestamp) as updated_at
    from source

)

select * from transformed