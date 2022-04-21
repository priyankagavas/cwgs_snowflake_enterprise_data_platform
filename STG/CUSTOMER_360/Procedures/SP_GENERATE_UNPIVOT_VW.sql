Create or replace procedure dev_inbound.customer_360.sp_generate_unpivot_vw(engine_name varchar)
returns varchar
language sql
execute as caller
as
$$
declare
create_stmt varchar;

c1 cursor for 

select create_statement 
from dev_inbound.customer_360.vw_unpivot_generate
where engine_name= ?;

begin
open c1 using(engine_name);
fetch c1 into create_stmt;
execute immediate :create_stmt;
close c1;

return engine_name||'- unpivot view created successfully!';

end;
$$;