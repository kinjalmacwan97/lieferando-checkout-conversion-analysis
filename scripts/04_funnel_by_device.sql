----Q2 Device-wise funnel conversion and drop-off analysis
WITH CTE_1 AS
(SELECT
	cs.device_type,
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
LEFT JOIN event_info AS ei
ON cs.session_id = ei.session_id
GROUP BY 
	cs.device_type,
	ei.event_name
)

--only accessing the next value of checkout_session by lead()
, CTE_2 AS
(SELECT *,
LEAD(checkout_sessions) OVER (PARTITION BY device_type ORDER BY funnel_step ) AS next_session
FROM CTE_1)


---next step sessions ÷ current step sessions × 100
SELECT *,
	ROUND((CAST(next_session AS FLOAT)/NULLIF(checkout_sessions, 0)) * 100 ,2) AS conversion_rate,
	ROUND(100 - (CAST(next_session AS FLOAT)/NULLIF(checkout_sessions, 0)) * 100 ,2) AS drop_off_rate
FROM CTE_2
ORDER BY device_type, funnel_step
