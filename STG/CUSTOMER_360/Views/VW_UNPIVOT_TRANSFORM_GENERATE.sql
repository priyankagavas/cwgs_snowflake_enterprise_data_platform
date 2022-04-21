create or replace view DEV_STG.CUSTOMER_360.VW_UNPIVOT_TRANSFORM_GENERATE(
	ENGINE_NAME,
	CREATE_STATEMENT
) as 
select engine_name, 'create or replace view dev_inbound.customer_360.vw_' || lower(engine_name) || '_unpivot_transform as ' || listagg(col1,'\n union all ') within group (order by col1 asc) as create_statement from (  select 'select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table
on fk_table_id=table_id where table_name=\'' || table_name || '\' and lower(source_column_name) = lower(\''
      || source_column_name || '\')) attribute_id , cast(' || nvl(transformation_rule,source_column_name) || ' as varchar) attribute_value  from ' ||database_name||'.'||schema_name||'.'|| table_name
  ||' where attribute_value is not null'  as col1, m_tbl.engine_name
  from dev_inbound.customer_360.meta_customer_attribute m_attr
  inner join dev_inbound.customer_360.meta_customer_table m_tbl on m_attr.fk_table_id=m_tbl.table_id
  where  lower(is_transform_attribute)= lower('y')
)
group by engine_name;