/* ===============================================================
Project: MAVEN FUZZY FACTORY E-COMMERCE WEB ANALYSIS
Tools: MSSQL, Power BI
===============================================================
*/

--Question 1: Total Sessions, Total Orders, and Conversion Rate (Order/Session)
SELECT COUNT(website_session_id) AS total_sessions
FROM website_sessions

SELECT COUNT(order_id) AS total_order
FROM orders

SELECT
     COUNT(ws.website_session_id) AS total_sessions,
     COUNT(o.order_id) AS total_order,
     CAST(COUNT(o.order_id)*1.0/COUNT(ws.website_session_id) AS decimal (10,4)) AS conversion_rate
FROM website_sessions ws 
 LEFT JOIN orders o ON ws.website_session_id = o.website_session_id

-- Q2: Session Count by UTM Source (Traffic volume by channel)
SELECT 
 utm_source, 
 COUNT(website_session_id) AS total_sessions
FROM website_sessions
GROUP BY utm_source
ORDER BY 2 DESC


-- Q3: Device Type Distribution (Percentage of total sessions per device)
SELECT 
 device_type,
 COUNT(website_session_id) AS total_sessions,
 CAST(COUNT(website_session_id)*100.0/(SELECT COUNT(*) FROM website_sessions) AS decimal (10,2)) AS percent_distribution
FROM website_sessions
GROUP BY device_type

-- Q4: Top 10 Most Visited URLs
SELECT
TOP 10 pageview_url,
COUNT (*) AS views
FROM website_pageviews
GROUP BY pageview_url
ORDER BY 2 DESC

-- Q5: Total Gross Revenue, Total COGS, and Gross Margin Percentage
SELECT
 SUM(price_usd) AS gross_revenue,
 SUM(cogs_usd) AS total_cost,
(SUM(price_usd) - SUM(cogs_usd))*100.0/SUM(price_usd) AS margin
FROM orders

-- Q6: Conversion Rate by UTM Source (Identifying high-quality traffic sources)
SELECT
utm_source,
COUNT (ws.website_session_id) AS total_visit,
COUNT (o.order_id) AS total_order,
CAST(COUNT (o.order_id)*100.0/COUNT(ws.website_session_id) AS decimal (10,4)) AS CR
FROM website_sessions ws 
 LEFT JOIN orders o 
 ON ws.website_session_id=o.website_session_id
GROUP BY utm_source
ORDER BY 4 DESC

--Q7: Refund Rate per Product (Total items returned vs. items sold and revenue impact)
SELECT
    product_id,
    product_name,
    COUNT(ir.order_item_refund_id) AS total_return,
    SUM (refund_amount_usd) AS total_refund,
    CAST(COUNT(ir.order_item_refund_id)*100.0/COUNT(o.order_id) AS DECIMAL (10,2)) AS return__rate,
    CAST(SUM(refund_amount_usd)*100.0/SUM(price_usd*items_purchased) AS DECIMAL (10,2)) AS refund__rate
FROM orders o
    LEFT JOIN products p ON o.primary_product_id = p.product_id
    LEFT JOIN order_item_refunds ir ON o.order_id = ir.order_id
GROUP BY product_name, product_id
ORDER BY 3 DESC

--Q8: Full Conversion Funnel Analysis: Tracking session flow from Homepage → Product → Cart → Shipping → Payment → Thank You
WITH funnel AS (
    SELECT 
        ws.website_session_id,
        CAST(ws.created_at AS DATE) AS date_key,
        ws.device_type,
        MAX(CASE WHEN pageview_url = '/home' OR pageview_url LIKE '/lander%' THEN 1 ELSE 0 END) AS [1. Homepage],
        MAX(CASE WHEN pageview_url = '/products' THEN 1 ELSE 0 END) AS [2. Product Page],
        MAX(CASE WHEN pageview_url LIKE '/the-%' THEN 1 ELSE 0 END) AS [3. Product Detail],
        MAX(CASE WHEN pageview_url = '/cart' THEN 1 ELSE 0 END) AS [4. Cart],
        MAX(CASE WHEN pageview_url = '/shipping' THEN 1 ELSE 0 END) AS [5. Delivery],
        MAX(CASE WHEN pageview_url LIKE '/billing%' THEN 1 ELSE 0 END) AS [6. Payment],
        MAX(CASE WHEN pageview_url LIKE '/thank-you%' THEN 1 ELSE 0 END) AS [7. Order Completed]
    FROM website_sessions ws
    LEFT JOIN website_pageviews wp ON ws.website_session_id = wp.website_session_id
    GROUP BY ws.website_session_id, CAST(ws.created_at AS DATE), ws.device_type
),
summary_table AS (
    SELECT
        date_key,
        device_type,
        SUM([1. Homepage]) AS [1. Homepage],
        SUM([2. Product Page]) AS [2. Product Page],
        SUM([3. Product Detail]) AS [3. Product Detail],
        SUM([4. Cart]) AS [4. Cart],
        SUM([5. Delivery]) AS [5. Delivery],
        SUM([6. Payment]) AS [6. Payment],
        SUM([7. Order Completed]) AS [7. Order Completed]
    FROM funnel
    GROUP BY date_key, device_type
)
SELECT
    date_key,
    device_type,
    step_name,
    session_count
FROM summary_table
UNPIVOT (
    session_count FOR step_name IN (
        [1. Homepage], 
        [2. Product Page], 
        [3. Product Detail], 
        [4. Cart], 
        [5. Delivery], 
        [6. Payment], 
        [7. Order Completed]
    )
) AS unpvt;

--Q9:  Total Revenue Contribution by Device Type.
SELECT device_type,
SUM(price_usd * items_purchased) AS revenue
FROM website_sessions ws 
 JOIN orders o 
 ON ws.website_session_id=o.website_session_id
GROUP BY device_type

--Q10: Retention Analysis by UTM Campaign: Comparing unique users vs. repeat sessions to evaluate campaign loyalty
SELECT 
utm_campaign,
COUNT(DISTINCT user_id) AS total_unique_user,
COUNT(DISTINCT 
 CASE WHEN is_repeat_session = 1 THEN user_id ELSE NULL END) AS repeat_user,
CAST(
    COUNT(DISTINCT CASE WHEN is_repeat_session = 1 THEN user_id ELSE NULL END) * 100.0 
        / COUNT(DISTINCT user_id) 
    AS DECIMAL(10,2)) AS retention_rate
FROM website_sessions
WHERE utm_campaign IS NOT NULL
GROUP BY utm_campaign
ORDER BY retention_rate DESC;
