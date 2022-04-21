create or replace view DEV_EDP.EDP.VW_DIM_CUSTOMER_ATTRIBUTE(
	ATTRIBUTE_ID,
	ATTRIBUTE_NAME,
	DISPLAY_NAME,
	ATTRIBUTE_DESC,
	ATTRIBUTE_CATEGORY_DESC,
	ATTRIBUTE_SUBCATEGORY_DESC,
	ENGINE_NAME,
	DEFAULT_VALUE,
	IS_TARGET_ATTRIBUTE
) as
select attribute_id
,attribute_name
,display_name
,attribute_desc
,attribute_category_desc
,attribute_subcategory_desc
,engine_name
,default_value
,is_target_attribute
from dev_edp.edp_data.dim_customer_attribute;