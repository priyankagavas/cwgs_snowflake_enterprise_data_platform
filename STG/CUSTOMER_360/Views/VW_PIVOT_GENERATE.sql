create or replace view DEV_STG.CUSTOMER_360.VW_PIVOT_GENERATE(
	CREATE_STATEMENT
) as
with a as
(
select (listagg('coalesce('||attribute_name||','||coalesce(''''||default_value||'''','NULL')||') as "'||display_name||'"',',')
within group (order by lower(engine_name),lower(attribute_name) asc)) as display_list,
'\'' ||(listagg(attribute_name,'\',\'')
within group (order by lower(engine_name),lower(attribute_name) asc)) || '\'' as attr_list,
(listagg(attribute_name,',')
within group (order by lower(engine_name),lower(attribute_name) asc)) as alias_list
from
(
select distinct attribute_name, display_name,engine_name,default_value
from customer_360.meta_customer_attribute att
where lower(is_target_attribute)=lower('y')   
)
)
select 'create or replace table dev_edp.edp_data.dim_customer360 as ' ||
        'select customer_id AS "Customer ID",'||display_list||' from (select fact.customer_id, COALESCE(fact.attribute_value, meta.default_value) as attribute_value, meta.attribute_name ' ||
          'from customer_360.meta_customer_attribute meta ' ||
     'left join dev_edp.edp_data.fact_customer_attribute fact on meta.attribute_id = fact.attribute_id ' ||
        'order by fact.customer_id asc ) d pivot ' ||
      '(min(attribute_value) for attribute_name in ('|| attr_list ||
      ' )) piv (customer_id,'||alias_list||');' as create_statement
from a 
;