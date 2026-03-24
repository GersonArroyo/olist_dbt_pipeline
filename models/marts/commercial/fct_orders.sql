with orders as (
    select * from {{ ref('stg_olist__orders') }}
),
payments as (
    select 
        order_id,
        count(DISTINCT payment_type) as payment_type,
        sum(payment_value) as payment_value
    from {{ ref('stg_olist__order_payments') }}
    group by order_id
)

select
    orders.order_id as order_id,
    orders.customer_id as customer_id,
    orders.order_status as order_status,
    orders.order_purchase_timestamp as order_purchase_timestamp,
    orders.order_approved_at as order_approved_at,
    orders.order_delivered_carrier_date as order_delivered_carrier_date,
    orders.order_delivered_customer_date as order_delivered_customer_date,
    orders.order_estimated_delivery_date as order_estimated_delivery_date,
    payments.payment_type as payment_type,
    payments.payment_value as payment_value
from orders
left join payments on orders.order_id = payments.order_id

