use dev_inbound;

create or replace procedure customer_360.sp_generate_unpivot_transform_vw(engine_name varchar)
returns varchar
language sql
execute as caller
as
$$
declare
create_stmt varchar;

c1 cursor for 

select create_statement 
from dev_inbound.customer_360.vw_unpivot_transform_generate
where lower(engine_name)=lower(?);

begin
open c1 using(engine_name);
fetch c1 into create_stmt;
execute immediate :create_stmt;
close c1;

return engine_name||'- unpivot transform view created successfully!';

end;
$$;