create or replace view DEV_STG.CUSTOMER_360.VW_CUST360_META_CUSTOMER_ATTRIBUTE_INSERT_GENERATE(
	TABLE_NAME,
	COLUMN_NAME,
	INSERT_STATEMENT
) as 
select distinct tbl.TABLE_NAME,COLUMN_NAME, CONCAT_WS('','INSERT INTO META_CUSTOMER_ATTRIBUTE (FK_TABLE_ID,ATTRIBUTE_ID,SOURCE_COLUMN_NAME,ATTRIBUTE_NAME,DISPLAY_NAME,ATTRIBUTE_DESC,ATTRIBUTE_CATEGORY_DESC,DEFAULT_VALUE,VALUE_DATATYPE,ATTRIBUTE_SUBCATEGORY_DESC,RECORD_CREATE_DATE,RECORD_UPDATE_DATE,IS_TARGET_ATTRIBUTE,ENGINE_NAME,IS_TRANSFORM_ATTRIBUTE,TRANSFORMATION_RULE)  values ('
  , '\'' ,cast(tbl.TABLE_ID            as VARCHAR)
  , '\',\'' , cast(SEQ_ATTRIBUTE_ID.nextval as VARCHAR)
  , '\',\'' , lower( COLUMN_NAME)
  , '\',\'' , lower( COLUMN_NAME)
  , '\',\'' , cast(INITCAP(regexp_replace(COLUMN_NAME,'_',' ')) as varchar)
  , '\',\'' , NVL(cast(COMMENT                 as VARCHAR),'')
  , '\',\'' , NVL(NULL,'')
  , '\',\'' , NVL(NULL,'')
  , '\',\'' , cast(DATA_TYPE               as VARCHAR)
  , '\',\'' , NVL(NULL,'')
  , '\', current_timestamp, current_timestamp'
  ,',\'y'
  , '\',\'' , lower(NVL(ENGINE_NAME,'engine_name'))
  ,'\',\'n'
  , '\',\'' , NVL(NULL,'')
  , '\')') as INSERT_STATEMENT
from INFORMATION_SCHEMA.COLUMNS cols inner join META_CUSTOMER_TABLE tbl on cols.TABLE_NAME=tbl.TABLE_NAME and cols.TABLE_SCHEMA=tbl.SCHEMA_NAME and cols.TABLE_CATALOG=tbl.DATABASE_NAME
order by tbl.TABLE_NAME
;