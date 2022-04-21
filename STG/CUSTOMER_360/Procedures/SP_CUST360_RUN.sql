use dev_inbound;

create or replace procedure customer_360.sp_cust360_run()
returns varchar
language sql
execute as caller
as
$$
declare
select_stmt varchar;
begin

create or replace table dev_EDP.EDP_DATA.fact_customer_attribute_clone clone dev_EDP.EDP_DATA.fact_customer_attribute;

call dev_inbound.customer_360.sp_cust360_mdm_engine();
call dev_inbound.customer_360.sp_cust360_segment_engine();
call dev_inbound.customer_360.sp_cust360_attribute_to_zip_map_engine();

//inserting deleted as well as updated records into audit_customer_attribute

insert into dev_EDP.EDP_DATA.audit_customer_attribute
(
	attribute_value
	,insert_dtm
	,update_dtm
	,snapshot_dtm
	,attribute_id
	,customer_id
	,audit_type_desc
	,engine_name
)
select 
	 cl.attribute_value
	,cl.insert_dtm
	,case when f.attribute_id is not null then current_timestamp else cl.update_dtm end as update_dtm 
	,current_timestamp as snapshot_dtm
	,cl.attribute_id
	,cl.customer_id 
	,case when f.attribute_id is null then 'd' else 'u' end  as audit_type_desc
	,cl.engine_name
from dev_EDP.EDP_DATA.fact_customer_attribute_clone cl
left join dev_EDP.EDP_DATA.fact_customer_attribute f 
on cl.attribute_id 		= f.attribute_id 
and cl.customer_id 		= f.customer_id
where f.attribute_id is null
or to_timestamp(cl.update_dtm) <> to_timestamp(f.update_dtm)
;

call dev_inbound.customer_360.sp_create_pivot_view_cust360();

drop table DEV_EDP.EDP_DATA.FACT_CUSTOMER_ATTRIBUTE_CLONE;

return 'sp_cust360_run executed success';

end;
$$
;