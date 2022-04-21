create or replace view DEV_STG.CUSTOMER_360.VW_MDM_UNPIVOT_TRANSFORM(
	CUSTOMER_ID,
	ATTRIBUTE_ID,
	ATTRIBUTE_VALUE
) as select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table
on fk_table_id=table_id where table_name='VW_MDM' and lower(source_column_name) = lower('age')) attribute_id , cast(case when dateadd(year, datediff(year,to_date(birth_dt), current_date), to_date(birth_dt)) > current_date then datediff(year,to_date(birth_dt), current_date)-1 else datediff(year,to_date(birth_dt), current_date) end as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where attribute_value is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table
on fk_table_id=table_id where table_name='VW_MDM' and lower(source_column_name) = lower('has_busn_email_addr')) attribute_id , cast(case when busn_email_addr is not null then 'Y' else 'N' end as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where attribute_value is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table
on fk_table_id=table_id where table_name='VW_MDM' and lower(source_column_name) = lower('has_busn_phone_nbr')) attribute_id , cast(case when busn_phone_nbr is not null then 'Y' else 'N' end as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where attribute_value is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table
on fk_table_id=table_id where table_name='VW_MDM' and lower(source_column_name) = lower('has_prsnl_email_addr')) attribute_id , cast(case when prsnl_email_addr is not null then 'Y' else 'N' end as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where attribute_value is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table
on fk_table_id=table_id where table_name='VW_MDM' and lower(source_column_name) = lower('has_prsnl_phone_nbr')) attribute_id , cast(case when prsnl_phone_nbr is not null then 'Y' else 'N' end as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where attribute_value is not null;