with source as (

    select * from {{ ref('stg_olist__orders') }}

),

orders as (

    select
        order_id,
        order_status,
        order_purchase_timestamp,
        order_delivered_carrier_date,
        date(order_delivered_customer_date) as order_delivered_customer_date,
        date(order_estimated_delivery_date) as order_estimated_delivery_date,
        CASE
            WHEN order_delivered_customer_date IS NOT NULL 
            THEN date_diff(date(order_delivered_customer_date), date(order_purchase_timestamp), DAY)
        END as days_to_deliver,
        CASE
            WHEN order_delivered_customer_date IS NOT NULL 
            THEN date(order_delivered_customer_date) <= date(order_estimated_delivery_date) 
        END as is_on_time,
        CASE
            WHEN order_delivered_customer_date IS NOT NULL 
            THEN date_diff(date(order_estimated_delivery_date), date(order_purchase_timestamp), DAY)
        END as estimated_days_to_deliver,
        CASE
            WHEN order_delivered_carrier_date IS NOT NULL 
            THEN date_diff(date(order_delivered_carrier_date), date(order_purchase_timestamp), DAY)
        END as days_to_carrier_delivery

    from source
    
)

select * from orders