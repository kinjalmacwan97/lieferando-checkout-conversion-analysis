SELECT 'customer_info' AS table_name, COUNT(*) AS row_count
FROM customer_info

UNION ALL

SELECT 'checkout_session', COUNT(*)
FROM checkout_session

UNION ALL

SELECT 'payment', COUNT(*)
FROM payment

UNION ALL

SELECT 'event_info', COUNT(*)
FROM event_info;