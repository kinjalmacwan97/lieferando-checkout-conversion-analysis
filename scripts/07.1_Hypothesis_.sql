WITH cte_1 AS
(
    SELECT 
        cs.device_type,
        p.payment_status,
        COUNT(*) AS total_transactions
    FROM checkout_session AS cs
    LEFT JOIN payment AS p
        ON cs.session_id = p.session_id
    GROUP BY
        cs.device_type,
        p.payment_status
),

cte_2 AS
(
    SELECT 
        *,
        SUM(total_transactions) OVER (
            PARTITION BY device_type
        ) AS total_submitted
    FROM cte_1
)

SELECT
    device_type,
    payment_status,
    total_transactions,
    total_submitted,
    ROUND(
        CAST(total_transactions AS FLOAT)
        / NULLIF(total_submitted, 0) * 100,
        2
    ) AS rate
FROM cte_2
ORDER BY device_type, payment_status;