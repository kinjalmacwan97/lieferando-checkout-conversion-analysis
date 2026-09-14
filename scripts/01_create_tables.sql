--- Create the 'lieferandoAnalysis' tables
CREATE TABLE customer_info(

	customer_id INT PRIMARY KEY,
	first_name NVARCHAR(50),
	last_name NVARCHAR(50),
	city NVARCHAR(50),
	birth_date DATE,
	gender NVARCHAR(50),
	address NVARCHAR(150),
	signup_date DATE
);

CREATE TABLE checkout_session (
	session_id INT PRIMARY KEY,
	customer_id INT,
	checkout_start_timestamp DATETIME,
	device_type NVARCHAR(50),
	order_value DECIMAL(10,2),
	final_status NVARCHAR(50),
	final_step_reached NVARCHAR(50),
	time_taken_to_complete_order INT,

	 CONSTRAINT FK_checkout_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer_info(customer_id)
);


CREATE TABLE payment(

	payment_id INT PRIMARY KEY,
	session_id INT, 
	payment_method NVARCHAR(50),
	payment_status NVARCHAR(50),
	payment_time DATETIME,

 CONSTRAINT FK_payment_session
        FOREIGN KEY (session_id)
        REFERENCES checkout_session(session_id)
);


CREATE TABLE event_info (
    event_id INT PRIMARY KEY,
    session_id INT,
    event_name NVARCHAR(50),
    event_timestamp DATETIME,

    CONSTRAINT FK_event_session
        FOREIGN KEY (session_id)
        REFERENCES checkout_session(session_id)
);


----------staging table

CREATE TABLE checkout_session_staging (
    session_id INT,
    customer_id INT,
    checkout_start_timestamp DATETIME,
    device_type NVARCHAR(50),
    order_value DECIMAL(10,2),
    final_status NVARCHAR(50),
    final_step_reached NVARCHAR(50),
    time_taken_to_complete_order DECIMAL(10,1)
);