--- load csv files into our tables
--bulk insert customer_info

PRINT '>>Inserting Data into: customer_info';

BULK INSERT customer_info
FROM 'F:\liferando_case_study\dataset\liferando_dataset\customer_info.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
	CODEPAGE = '65001',
    TABLOCK
);


--bulk insert customer_info checkout_session

PRINT '>> Inserting Data into: checkout_session_staging';

BULK INSERT checkout_session_staging
FROM 'F:\liferando_case_study\dataset\liferando_dataset\checkout_session.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);

INSERT INTO checkout_session (
    session_id,
    customer_id,
    checkout_start_timestamp,
    device_type,
    order_value,
    final_status,
    final_step_reached,
    time_taken_to_complete_order
)
SELECT
    session_id,
    customer_id,
    checkout_start_timestamp,
    device_type,
    order_value,
    final_status,
    final_step_reached,
    CAST(time_taken_to_complete_order AS INT)
FROM checkout_session_staging;


--bulk insert  payment
PRINT '>>Inserting Data into: payment';

BULK INSERT payment
FROM 'F:\liferando_case_study\dataset\liferando_dataset\payment.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
	CODEPAGE = '65001',
    TABLOCK
);

--bulk insert  event_info
PRINT '>>Inserting Data into:event_info';

BULK INSERT event_info
FROM 'F:\liferando_case_study\dataset\liferando_dataset\event_info.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
	CODEPAGE = '65001',
    TABLOCK
);
