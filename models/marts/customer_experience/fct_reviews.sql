with reviews as (

    select * from {{ ref('stg_olist__order_reviews') }}

),

orders as (

    select * from {{ ref('int_orders_enriched') }}

),

reviews_orders as (

    select
        r.review_id as review_id,
        r.order_id as order_id,
        r.review_score as review_score,
        r.review_comment_title as review_comment_title,
        r.review_comment_message as review_comment_message,
        r.review_creation_date as review_creation_date,
        r.review_answer_timestamp as review_answer_timestamp,
        o.order_status as order_status,
        o.is_on_time as is_on_time,
        o.days_to_deliver as days_to_deliver
    from reviews r
    left join orders o on r.order_id = o.order_id
    
)
select * from reviews_orders
