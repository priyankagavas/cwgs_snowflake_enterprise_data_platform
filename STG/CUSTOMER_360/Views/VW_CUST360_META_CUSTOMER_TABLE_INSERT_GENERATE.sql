create or replace view DEV_STG.CUSTOMER_360.VW_CUST360_META_CUSTOMER_TABLE_INSERT_GENERATE(
	TABLE_CATALOG,
	TABLE_SCHEMA,
	TABLE_NAME,
	INSERT_STATEMENT
) as
select distinct TABLE_CATALOG,TABLE_SCHEMA,TABLE_NAME, CONCAT_WS('','INSERT INTO META_CUSTOMER_TABLE (TABLE_ID,ENGINE_NAME,TABLE_NAME,TABLE_DESC,TABLE_CATEGORY_DESC,DATABASE_NAME,SCHEMA_NAME
) values (' 
, '\'' , cast(SEQ_TABLE_ID.nextval  as VARCHAR)
, '\',\'' , 'ENGINE_NAME'
, '\',\'' , TABLE_NAME
, '\',\'' , NVL(COMMENT,'')
, '\',\'' , NVL(null,'')
, '\',\'' , TABLE_CATALOG
, '\',\'' , TABLE_SCHEMA
, '\')'
) as INSERT_STATEMENT
from INFORMATION_SCHEMA.TABLES
order by TABLE_NAME;