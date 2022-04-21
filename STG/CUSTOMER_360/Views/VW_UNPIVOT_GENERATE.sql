create or replace view DEV_STG.CUSTOMER_360.VW_UNPIVOT_GENERATE(
	ENGINE_NAME,
	CREATE_STATEMENT
) as 
select engine_name, 'create or replace view dev_inbound.customer_360.vw_' || engine_name || '_unpivot as ' || listagg(col1,'\n union all ') 
within group (order by col1 asc) as create_statement
from ( 
 select 'select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name=\'' || table_name || '\' and lower(SOURCE_COLUMN_NAME) = lower(\'' 
      || SOURCE_COLUMN_NAME || '\')) attribute_id , cast(' || SOURCE_COLUMN_NAME || ' as varchar) attribute_value  from ' ||database_name||'.'||schema_name||'.'|| table_name ||' where '
	  || SOURCE_COLUMN_NAME || ' is not null'  as col1, m_tbl.engine_name
  from dev_inbound.customer_360.meta_customer_attribute m_attr 
  inner join dev_inbound.customer_360.meta_customer_table m_tbl on m_attr.fk_table_id=m_tbl.table_id
  where  lower(is_transform_attribute)= lower('n'))
group by engine_name;