with source as (

    select * from {{ source('raw', 'products') }}

),

translation as (

    select * from {{ ref('stg_olist__product_category_name_translation') }}

),

products as (

    select
        p.product_id as product_id,
        p.product_category_name as product_category_name,
        p.product_name_lenght as product_name_lenght,
        t.product_category_name_english as product_category_name_english,
        p.product_description_lenght as product_description_lenght,
        p.product_photos_qty as product_photos_qty,
        p.product_weight_g as product_weight_g,
        p.product_length_cm as product_length_cm,
        p.product_height_cm as product_height_cm,
        p.product_width_cm as product_width_cm

    from source p
    left join translation t
        on lower(trim(p.product_category_name)) = lower(trim(t.product_category_name)) -- lower to lower the strings and trim to remove leading and trailing spaces

)

select * from products