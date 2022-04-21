create or replace TABLE DEV_EDP.EDP_DATA.DIM_TRANSACTION_STATUS (
	TRANSACTION_STATUS_ID NUMBER(38,0) NOT NULL autoincrement COMMENT 'System generated unique transaction status identifier, such as order, cancelled, shipped, picked',
	TRANSACTION_STATUS_CODE VARCHAR(30) COMMENT 'A code that identifies transaction status, such as order, cancelled, shipped, picked, booked, return, closed',
	TRANSACTION_STATUS_DESC VARCHAR(80) COMMENT 'Description of transaction status, such as order, cancelled, shipped, picked,booked, return',
	RECORD_LOAD_DTM DATE DEFAULT CURRENT_DATE() COMMENT 'Record load datetime',
	constraint XPKTRNSSTSDIM primary key (TRANSACTION_STATUS_ID)
)COMMENT='List of transaction status, such as order, cancelled, shipped, picked, booked'
;