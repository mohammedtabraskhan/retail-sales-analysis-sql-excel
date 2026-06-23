-- =====================================================================
-- RETAIL SALES ANALYSIS PROJECT
-- Author: Mohammed Tabras Khan
-- Database: superstore.db (SQLite)
-- Table: orders  (3,464 line items | 1,850 unique orders | 2023-2025)
-- =====================================================================

-- -----------------------------------------------------------------
-- QUERY 1: Overall business snapshot
-- -----------------------------------------------------------------
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(*) AS total_line_items,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS overall_profit_margin_pct
FROM orders;

-- -----------------------------------------------------------------
-- QUERY 2: Sales and profit by region
-- -----------------------------------------------------------------
SELECT
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS num_orders
FROM orders
GROUP BY region
ORDER BY total_sales DESC;

-- -----------------------------------------------------------------
-- QUERY 3: Top 10 best-selling products by revenue
-- -----------------------------------------------------------------
SELECT
    product_name,
    category,
    SUM(quantity) AS units_sold,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY product_name, category
ORDER BY total_sales DESC
LIMIT 10;

-- -----------------------------------------------------------------
-- QUERY 4: Monthly sales trend
-- -----------------------------------------------------------------
SELECT
    strftime('%Y-%m', order_date) AS year_month,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY year_month
ORDER BY year_month;

-- -----------------------------------------------------------------
-- QUERY 5: Performance by customer segment
-- -----------------------------------------------------------------
SELECT
    segment,
    COUNT(DISTINCT customer_id) AS num_customers,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(AVG(sales), 2) AS avg_order_value,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY segment
ORDER BY total_sales DESC;

-- -----------------------------------------------------------------
-- QUERY 6: Category and sub-category profitability
-- -----------------------------------------------------------------
SELECT
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM orders
GROUP BY category, sub_category
ORDER BY category, total_sales DESC;

-- -----------------------------------------------------------------
-- QUERY 7: Loss-making orders (negative profit) - risk analysis
-- -----------------------------------------------------------------
SELECT
    COUNT(*) AS loss_making_line_items,
    ROUND(SUM(profit), 2) AS total_loss,
    ROUND(AVG(discount) * 100, 1) AS avg_discount_pct_on_losses
FROM orders
WHERE profit < 0;

-- -----------------------------------------------------------------
-- QUERY 8: Discount impact on profit margin
-- -----------------------------------------------------------------
SELECT
    CASE
        WHEN discount = 0 THEN '0% (No Discount)'
        WHEN discount <= 0.15 THEN '1-15%'
        WHEN discount <= 0.30 THEN '16-30%'
        ELSE '31%+'
    END AS discount_band,
    COUNT(*) AS num_transactions,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM orders
GROUP BY discount_band
ORDER BY MIN(discount);

-- -----------------------------------------------------------------
-- QUERY 9: Top 10 customers by total spend
-- -----------------------------------------------------------------
SELECT
    customer_name,
    segment,
    COUNT(DISTINCT order_id) AS num_orders,
    ROUND(SUM(sales), 2) AS total_spend,
    ROUND(SUM(profit), 2) AS total_profit_generated
FROM orders
GROUP BY customer_id, customer_name, segment
ORDER BY total_spend DESC
LIMIT 10;

-- -----------------------------------------------------------------
-- QUERY 10: Shipping mode usage and average delivery time
-- -----------------------------------------------------------------
SELECT
    ship_mode,
    COUNT(DISTINCT order_id) AS num_orders,
    ROUND(AVG(julianday(ship_date) - julianday(order_date)), 1) AS avg_delivery_days,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY ship_mode
ORDER BY num_orders DESC;
