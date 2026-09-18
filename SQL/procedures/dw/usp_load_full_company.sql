create procedure usp_full_load_company as

-- Creating DW tables
if object_id('dw_procfit.dbo.dim_company') is null
begin

create table dw_procfit.dbo.dim_company (

	cd_company				numeric(15)		primary key
	,company_name			varchar(160)
	,company_short_name		varchar(80)

)

end;



-- Truncate dim table
truncate table dw_procfit.dbo.dim_company;



-- Insert values into dimension
insert into dw_procfit.dbo.dim_company
select
    *
from staging_procfit.dbo.vw_dim_company