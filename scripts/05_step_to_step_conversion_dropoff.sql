--Q1.
--Where customers drop-off is the most
--If we have drop-off then by how much %?
WITH cte_1 AS (
    SELECT 
        event_name,
        COUNT(event_timestamp) AS cnt,
        CASE event_name
            WHEN 'checkout_started' THEN 1
            WHEN 'address_confirmed' THEN 2
            WHEN 'delivery_time_selected' THEN 3
            WHEN 'payment_method_selected' THEN 4
            WHEN 'payment_submitted' THEN 5
            WHEN 'order_placed' THEN 6
        END AS step_order
    FROM event_info
    GROUP BY event_name
),

cte_2 AS (
    SELECT 
        *,
        LEAD(cnt) OVER (ORDER BY step_order) AS next_step
    FROM cte_1
)

SELECT 
    step_order,
    event_name,
    cnt,
    next_step,
    ROUND(CAST(next_step AS FLOAT) / NULLIF(cnt, 0) * 100, 2) AS conversion_rate,
    ROUND(100 - CAST(next_step AS FLOAT) / NULLIF(cnt, 0) * 100, 2) AS drop_off_rate
FROM cte_2
ORDER BY step_order;