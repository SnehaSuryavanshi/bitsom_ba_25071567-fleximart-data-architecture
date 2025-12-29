USE fleximart_dw;

-- 1. Total sales by category (most important KPI)
SELECT 
    p.category,
    COUNT(*) as total_transactions,
    SUM(f.total_amount) as total_revenue,
    AVG(f.quantity_sold) as avg_qty_sold,
    SUM(f.total_amount) / COUNT(*) as avg_order_value
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY total_revenue DESC;

-- 2. Sales by day type (weekend vs weekday trend)
SELECT 
    d.is_weekend,
    CASE WHEN d.is_weekend THEN 'Weekend' ELSE 'Weekday' END as day_type,
    COUNT(*) as transactions,
    SUM(f.total_amount) as revenue,
    SUM(f.quantity_sold) as total_units
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.is_weekend
ORDER BY revenue DESC;

-- 3. Top 5 products by revenue
SELECT 
    p.product_name,
    p.category,
    SUM(f.total_amount) as total_revenue,
    SUM(f.quantity_sold) as units_sold,
    AVG(f.unit_price) as avg_price
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.product_key, p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 5;

-- 4. Sales by customer segment
SELECT 
    c.customer_segment,
    COUNT(*) as customers,
    SUM(f.total_amount) as total_spent,
    AVG(f.total_amount) as avg_order_value
FROM fact_sales f
JOIN dim_customer c ON f.customer_key = c.customer_key
GROUP BY c.customer_segment
ORDER BY total_spent DESC;

-- 5. Monthly sales trend (FIXED)
SELECT 
    d.month_name,
    d.year,
    d.month as month_num,
    COUNT(*) as transactions,
    SUM(f.total_amount) as revenue
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.month, d.month_name, d.year
ORDER BY d.year, d.month;


-- 6. City-wise revenue
SELECT 
    c.city,
    SUM(f.total_amount) as revenue,
    COUNT(DISTINCT c.customer_key) as unique_customers
FROM fact_sales f
JOIN dim_customer c ON f.customer_key = c.customer_key
GROUP BY c.city
ORDER BY revenue DESC;

-- 7. High-value transactions (>50k)
SELECT 
    p.product_name,
    c.customer_name,
    c.city,
    f.total_amount,
    f.quantity_sold,
    d.full_date
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
JOIN dim_customer c ON f.customer_key = c.customer_key
JOIN dim_date d ON f.date_key = d.date_key
WHERE f.total_amount > 50000
ORDER BY f.total_amount DESC;

-- 8. Discount analysis
SELECT 
    AVG(discount_amount) as avg_discount,
    SUM(discount_amount) as total_discounts,
    COUNT(*) as discounted_orders,
    AVG(total_amount) as avg_final_amount
FROM fact_sales 
WHERE discount_amount > 0;
