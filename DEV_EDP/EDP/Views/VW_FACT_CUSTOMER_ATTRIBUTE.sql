create or replace view DEV_EDP.EDP.VW_FACT_CUSTOMER_ATTRIBUTE(
	CUSTOMER_ID,
	ATTRIBUTE_ID,
	ATTRIBUTE_VALUE,
	ENGINE_NAME,
	INSERT_DTM,
	UPDATE_DTM
) as select * from DEV_EDP.EDP_DATA.FACT_CUSTOMER_ATTRIBUTE;