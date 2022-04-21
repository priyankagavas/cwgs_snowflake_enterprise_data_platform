create or replace TABLE DEV_EDP.EDP_DATA.DIM_TRANSACTION_REASON (
	REASON_ID NUMBER(38,0) NOT NULL autoincrement COMMENT 'System generated reason unique number',
	REASON_CODE VARCHAR(30) COMMENT 'A code that identifies an order status reason for return, cancellation etc',
	REASON_DESC VARCHAR(200) COMMENT 'Description of an order status reason for return, cancellation etc',
	REASON_CATEGORY_DESC VARCHAR(200) COMMENT 'Description of an order reason category, such as return, cancellation etc',
	RECORD_LOAD_DTM DATE DEFAULT CURRENT_DATE() COMMENT 'Record load datetime',
	constraint XPKSTSREASONDIM primary key (REASON_ID)
)COMMENT='List of order status reasons, such as return , cancelled order reason'
;