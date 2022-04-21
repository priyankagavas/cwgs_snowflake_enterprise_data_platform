create or replace view DEV_STG.CUSTOMER_360.VW_MDM(
	CSTMR_ID,
	PRFX_NM,
	FIRST_NM,
	MIDL_NM,
	LAST_NM,
	BIRTH_DT,
	TITLE_NM,
	CSTMR_TYPE_DESC,
	SFX_NM,
	FULL_NM,
	GNDR_CD,
	CSTMR_IND,
	RV_TYPE_CD,
	BUSN_EMAIL_ADDR,
	PRSNL_EMAIL_ADDR,
	BUSN_PHONE_NBR,
	PRSNL_PHONE_NBR,
	LN_1_ADDR,
	LN_2_ADDR,
	CNTY_NM,
	CITY_NM,
	STATE_CD,
	CNTRY_CD,
	PSTL_CD,
	PSTL_EXT_CD,
	LAT_CORDT,
	LONG_CORDT,
	LOAD_DTM,
	MDM_CSTMR_ID,
	DS_CD,
	IS_DELETED
) as
select CSTMR_ID, PRFX_NM, FIRST_NM, MIDL_NM, LAST_NM, BIRTH_DT, TITLE_NM, CSTMR_TYPE_DESC, SFX_NM, FULL_NM, GNDR_CD, CSTMR_IND, RV_TYPE_CD, BUSN_EMAIL_ADDR, PRSNL_EMAIL_ADDR, BUSN_PHONE_NBR, PRSNL_PHONE_NBR, LN_1_ADDR, LN_2_ADDR, CNTY_NM, CITY_NM, STATE_CD, CNTRY_CD, PSTL_CD, PSTL_EXT_CD, LAT_CORDT, LONG_CORDT, LOAD_DTM, MDM_CSTMR_ID, DS_CD, "Is_Deleted"
from DEV_RAW.EDW_CWH_EDW_DBO.MDM_CSTMR_DIM
where "Is_Deleted"=0 and FULL_NM is not null;