create or replace task DEV_STG.CUSTOMER_360.MDM_DATA_REFRESH
	warehouse=CW_DEV_ETL_S_CS_WH
	schedule='USING CRON 0 0 * * * EST'
	USER_TASK_TIMEOUT_MS=86400000
	as CREATE OR REPLACE TABLE DEV_RAW.EDW_CWH_EDW_DBO.MDM_CSTMR_DIM CLONE DEV_INBOUND_HVR.EDW_CWH_EDW_DBO.MDM_CSTMR_DIM;