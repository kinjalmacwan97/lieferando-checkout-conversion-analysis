--Q2.c.Segment by order_value
WITH cte_1 AS (
    SELECT 
        session_id,
        order_value,
        NTILE(4) OVER (ORDER BY order_value) AS value_quartile
    FROM checkout_session
)

SELECT
    CASE 
		WHEN c.value_quartile = 4 THEN 'top_25_pct'
		ELSE 'rest' 
	END AS value_tier,
    COUNT(*) AS total_payments,

    SUM(
	CASE 
		WHEN p.payment_status = 'failed' THEN 1 
		ELSE 0 
	END
	) AS failed_payments,

    ROUND(100.0 *
	SUM(
	CASE WHEN p.payment_status = 'failed' THEN 1 
	ELSE 0 END
	) / COUNT(*), 2) AS failure_rate_pct
FROM cte_1 c
JOIN payment p ON c.session_id = p.session_id
GROUP BY CASE WHEN c.value_quartile = 4 THEN 'top_25_pct' ELSE 'rest' END
ORDER BY value_tier DESC;
