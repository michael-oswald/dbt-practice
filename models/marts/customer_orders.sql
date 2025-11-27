with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

order_payments as (
    select
        order_id,
        sum(case when payment_method = 'credit_card' then amount else 0 end) as credit_card_amount,
        sum(case when payment_method = 'coupon' then amount else 0 end) as coupon_amount,
        sum(case when payment_method = 'bank_transfer' then amount else 0 end) as bank_transfer_amount,
        sum(case when payment_method = 'gift_card' then amount else 0 end) as gift_card_amount,
        sum(amount) as total_amount
    from payments
    group by order_id
),

customer_orders as (
    select
        customers.customer_id,
        customers.full_name,
        customers.first_name,
        customers.last_name,
        min(orders.order_date) as first_order_date,
        max(orders.order_date) as most_recent_order_date,
        count(orders.order_id) as number_of_orders,
        sum(order_payments.total_amount) as lifetime_value
    from customers
    left join orders on customers.customer_id = orders.customer_id
    left join order_payments on orders.order_id = order_payments.order_id
    group by customers.customer_id, customers.full_name, customers.first_name, customers.last_name
)

select * from customer_orders
