create or replace view DEV_STG.CUSTOMER_360.VW_MDM_UNPIVOT(
	CUSTOMER_ID,
	ATTRIBUTE_ID,
	ATTRIBUTE_VALUE
) as select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('birth_dt')) attribute_id , cast(birth_dt as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where birth_dt is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('busn_email_addr')) attribute_id , cast(busn_email_addr as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where busn_email_addr is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('busn_phone_nbr')) attribute_id , cast(busn_phone_nbr as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where busn_phone_nbr is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('city_nm')) attribute_id , cast(city_nm as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where city_nm is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('cntry_cd')) attribute_id , cast(cntry_cd as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where cntry_cd is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('cnty_nm')) attribute_id , cast(cnty_nm as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where cnty_nm is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('cstmr_ind')) attribute_id , cast(cstmr_ind as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where cstmr_ind is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('cstmr_type_desc')) attribute_id , cast(cstmr_type_desc as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where cstmr_type_desc is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('first_nm')) attribute_id , cast(first_nm as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where first_nm is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('full_nm')) attribute_id , cast(full_nm as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where full_nm is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('gndr_cd')) attribute_id , cast(gndr_cd as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where gndr_cd is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('last_nm')) attribute_id , cast(last_nm as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where last_nm is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('lat_cordt')) attribute_id , cast(lat_cordt as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where lat_cordt is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('ln_1_addr')) attribute_id , cast(ln_1_addr as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where ln_1_addr is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('ln_2_addr')) attribute_id , cast(ln_2_addr as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where ln_2_addr is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('long_cordt')) attribute_id , cast(long_cordt as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where long_cordt is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('mdm_cstmr_id')) attribute_id , cast(mdm_cstmr_id as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where mdm_cstmr_id is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('midl_nm')) attribute_id , cast(midl_nm as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where midl_nm is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('prfx_nm')) attribute_id , cast(prfx_nm as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where prfx_nm is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('prsnl_email_addr')) attribute_id , cast(prsnl_email_addr as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where prsnl_email_addr is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('prsnl_phone_nbr')) attribute_id , cast(prsnl_phone_nbr as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where prsnl_phone_nbr is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('pstl_cd')) attribute_id , cast(pstl_cd as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where pstl_cd is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('pstl_ext_cd')) attribute_id , cast(pstl_ext_cd as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where pstl_ext_cd is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('rv_type_cd')) attribute_id , cast(rv_type_cd as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where rv_type_cd is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('sfx_nm')) attribute_id , cast(sfx_nm as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where sfx_nm is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('state_cd')) attribute_id , cast(state_cd as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where state_cd is not null
 union all select cstmr_id as customer_id, (select attribute_id from dev_inbound.customer_360.meta_customer_attribute inner join dev_inbound.customer_360.meta_customer_table 
on fk_table_id=table_id where table_name='VW_MDM' and lower(SOURCE_COLUMN_NAME) = lower('title_nm')) attribute_id , cast(title_nm as varchar) attribute_value  from DEV_INBOUND.CUSTOMER_360.VW_MDM where title_nm is not null;