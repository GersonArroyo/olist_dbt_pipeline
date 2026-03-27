with source as (

    select * from {{ ref('int_orders_enriched') }}

),

deliveries as (

    select
        order_id,
        order_status,
        order_purchase_timestamp,
        order_delivered_carrier_date,
        order_delivered_customer_date,
        order_estimated_delivery_date,
        days_to_deliver,
        is_on_time,
        estimated_days_to_deliver,
        days_to_carrier_delivery,
        CASE
            WHEN is_on_time = FALSE
            THEN date_diff(order_delivered_customer_date, order_estimated_delivery_date, DAY)
        END as delay_days

    from source

)
select * from deliveries
