create procedure usp_full_load_customer as

-- Creating DW tables
if object_id('dw_procfit.dbo.dim_customer') is null
begin

create table dw_procfit.dbo.dim_customer (

	cd_customer				numeric(15)		primary key
	,customer_short_name	varchar(160)
	,customer_name			varchar(80)
	,customer_type			varchar(160)
	,city					varchar(80)
	,state_name				varchar(80)
	,state_short_name		char(10)
)

end
;


-- Truncate dim table
truncate table dw_procfit.dbo.dim_customer;



-- Insert values into dimension
insert into dw_procfit.dbo.dim_customer
select
    *
from staging_procfit.dbo.vw_dim_customer