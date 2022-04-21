create or replace procedure dev_inbound.customer_360.sp_create_pivot_view_cust360()
returns varchar 
language sql
execute as caller
as
$$
declare

create_stmt varchar;
res resultset;
c2 cursor for 
select create_statement 
  from dev_inbound.customer_360.vw_pivot_generate;

begin

open c2 ;
fetch c2 into create_stmt;
res := (execute immediate :create_stmt );
close c2;

create or replace view dev_edp.edp.vw_dim_customer360 as select * from dev_edp.edp_data.dim_customer360;

return 'SUCCESS' ;

end;
$$;