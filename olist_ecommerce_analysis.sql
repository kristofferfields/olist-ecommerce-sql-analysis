
#part 1
SELECT
    ROUND(SUM(product_revenue)::numeric, 2) AS total_product_revenue
FROM order_summary;

#part 2
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', order_purchase_timestamp)::date AS month,
        ROUND(SUM(product_revenue)::numeric, 2) AS monthly_revenue,
        COUNT(DISTINCT order_id) AS monthly_orders
    FROM order_summary
    GROUP BY 1
),
with_growth AS (
    SELECT
        month,
        monthly_revenue,
        monthly_orders,
        LAG(monthly_revenue) OVER (ORDER BY month) AS prior_month_revenue
    FROM monthly
)
SELECT
    month,
    monthly_revenue,
    monthly_orders,
    ROUND(
        100.0 * (monthly_revenue - prior_month_revenue)
        / NULLIF(prior_month_revenue, 0),
        2
    ) AS mom_revenue_growth_pct
FROM with_growth
ORDER BY month;


#section 3
SELECT
    ROUND(AVG(product_revenue)::numeric, 2) AS overall_avg_order_value
FROM order_summary;

SELECT
    DATE_TRUNC('month', order_purchase_timestamp)::date AS month,
    ROUND(AVG(product_revenue)::numeric, 2) AS monthly_avg_order_value
FROM order_summary
GROUP BY 1
ORDER BY 1;  




#part 4 
SELECT
    customer_state,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(product_revenue)::numeric, 2) AS product_revenue,
    ROUND(AVG(product_revenue)::numeric, 2) AS avg_order_value
FROM order_summary
GROUP BY customer_state
ORDER BY product_revenue DESC;

#part 5
SELECT
    p.product_category_name,
    COUNT(*) AS item_count,
    COUNT(DISTINCT oi.order_id) AS orders,
    ROUND(SUM(oi.price)::numeric, 2) AS product_revenue,
    ROUND(AVG(oi.price)::numeric, 2) AS avg_item_price
FROM order_items oi
JOIN products p

#part 6 

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)
SELECT
    COUNT(*) AS unique_customers,
    COUNT(*) FILTER (WHERE order_count > 1) AS repeat_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE order_count > 1) / COUNT(*),
        2
    ) AS repeat_purchase_rate_pct
FROM customer_orders;
    ON oi.product_id = p.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY p.product_category_name
ORDER BY product_revenue DESC;

#part 7 

SELECT
    oi.seller_id,
    COUNT(DISTINCT oi.order_id) AS orders,
    COUNT(*) AS items_sold,
    ROUND(SUM(oi.price)::numeric, 2) AS product_revenue,
    ROUND(AVG(oi.price)::numeric, 2) AS avg_item_price
FROM order_items oi
GROUP BY oi.seller_id
ORDER BY product_revenue DESC
LIMIT 10;


#part 8 

SELECT
    ROUND(
        AVG(
            EXTRACT(EPOCH FROM (
                order_delivered_customer_date - order_purchase_timestamp
            )) / 86400
        )::numeric,
        2
    ) AS avg_delivery_days,

    ROUND(
        100.0 *
        COUNT(*) FILTER (
            WHERE order_delivered_customer_date > order_estimated_delivery_date
        )
        / COUNT(*),
        2
    ) AS late_delivery_rate_pct

FROM orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_purchase_timestamp IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;

  # part 9

  SELECT
    CASE
        WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date
            THEN 'On time'
        ELSE 'Late'
    END AS delivery_status,
    COUNT(*) AS review_count,
    ROUND(AVG(r.review_score)::numeric, 2) AS avg_review_score
FROM orders o
JOIN reviews r
    ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY 1
ORDER BY 1;


#part 10
WITH payment_summary AS (
    SELECT
        payment_type,
        COUNT(*) AS payment_records,
        SUM(payment_value) AS total_payment_value,
        AVG(payment_value) AS avg_payment_value
    FROM payments
    GROUP BY payment_type
),
totals AS (
    SELECT SUM(payment_records) AS total_records
    FROM payment_summary
)
SELECT
    payment_type,
    payment_records,
    ROUND(
        100.0 * payment_records / total_records,
        2
    ) AS payment_method_share_pct,
    ROUND(total_payment_value::numeric, 2) AS total_payment_value,
    ROUND(avg_payment_value::numeric, 2) AS avg_payment_value
FROM payment_summary
CROSS JOIN totals
ORDER BY payment_records DESC;

#part 11 
SELECT
    ROUND(AVG(payment_installments)::numeric, 2) AS avg_installments,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE payment_installments > 1) / COUNT(*),
        2
    ) AS share_using_installments_pct



	#part 12
	WITH seller_revenue AS (
    SELECT
        seller_id,
        SUM(price) AS revenue
    FROM order_items
    GROUP BY seller_id
),
ranked AS (
    SELECT
        seller_id,
        revenue,
        ROW_NUMBER() OVER (ORDER BY revenue DESC) AS seller_rank
    FROM seller_revenue
),
totals AS (
    SELECT SUM(revenue) AS total_revenue
    FROM seller_revenue
)
SELECT
    ROUND(
        100.0 * SUM(revenue) FILTER (WHERE seller_rank <= 10)
        / MAX(total_revenue),
        2
    ) AS top_10_seller_revenue_share_pct,
    ROUND(
        100.0 * SUM(revenue) FILTER (WHERE seller_rank <= 25)
        / MAX(total_revenue),
        2
    ) AS top_25_seller_revenue_share_pct
FROM ranked
CROSS JOIN totals;
FROM payments
WHERE payment_installments IS NOT NULL;

SELECT
    payment_installments,
    COUNT(*) AS payment_records,
    ROUND(AVG(payment_value)::numeric, 2) AS avg_payment_value
FROM payments
WHERE payment_installments IS NOT NULL
GROUP BY payment_installments
ORDER BY payment_installments;

