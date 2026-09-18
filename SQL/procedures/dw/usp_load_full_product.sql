create procedure usp_full_load_product as

--creating dw tables
if object_id('dw_procfit.dbo.dim_product') is null
begin
	create table dw_procfit.dbo.dim_product (
        cd_product              numeric(15)
        ,description            varchar(100)
        ,short_description      varchar(60)
        ,family                 varchar(80)
        ,section                varchar(80)
        ,group_name             varchar(80)
        ,subgrup_name           varchar(80)
        ,brand                  varchar(80)
	)
end
;




-- Truncate dim table
truncate table dw_procfit.dbo.dim_product;



-- Insert values into dimension
insert into dw_procfit.dbo.dim_product
select
    *
from staging_procfit.dbo.vw_dim_product