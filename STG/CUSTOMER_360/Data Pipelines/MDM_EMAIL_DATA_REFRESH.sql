create or replace task DEV_STG.CUSTOMER_360.MDM_EMAIL_DATA_REFRESH
	warehouse=CW_DEV_ETL_S_CS_WH
	after DEV_STG.CUSTOMER_360.MDM_DATA_REFRESH
	as CREATE OR REPLACE TABLE DEV_RAW.EDW_CWH_EDW_DBO.MDM_CSTMR_EMAIL CLONE DEV_INBOUND_HVR.EDW_CWH_EDW_DBO.MDM_CSTMR_EMAIL;