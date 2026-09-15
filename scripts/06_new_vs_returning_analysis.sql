--Q2_b._New vs returning users analysis
WITH CTE_1 AS (
	SELECT
		CASE WHEN DATEDIFF(day, ci.signup_date, cs.checkout_start_timestamp) <= 7 THEN 'new' ELSE 'returning' END AS user_type,
		CASE
			WHEN ei.event_name = 'checkout_started' THEN 1
			WHEN ei.event_name = 'address_confirmed' THEN 2
			WHEN ei.event_name = 'delivery_time_selected' THEN 3
			WHEN ei.event_name = 'payment_method_selected' THEN 4
			WHEN ei.event_name = 'payment_submitted' THEN 5
			WHEN ei.event_name = 'order_placed' THEN 6
		END AS funnel_step,
		ei.event_name,
		COUNT(DISTINCT ei.session_id) AS checkout_sessions
	FROM checkout_session AS cs
	LEFT JOIN customer_info AS ci ON cs.customer_id = ci.customer_id
	LEFT JOIN event_info AS ei ON cs.session_id = ei.session_id
	GROUP BY
		CASE WHEN DATEDIFF(day, ci.signup_date, cs.checkout_start_timestamp) <= 7 THEN 'new' ELSE 'returning' END,
		ei.event_name
)
, CTE_2 AS (
	SELECT *, LEAD(checkout_sessions) OVER (PARTITION BY user_type ORDER BY funnel_step) AS next_session
	FROM CTE_1
)
SELECT *,
	ROUND((CAST(next_session AS FLOAT)/NULLIF(checkout_sessions, 0)) * 100, 2) AS conversion_rate,
	ROUND(100 - (CAST(next_session AS FLOAT)/NULLIF(checkout_sessions, 0)) * 100, 2) AS drop_off_rate
FROM CTE_2
ORDER BY user_type, funnel_step

