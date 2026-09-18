create procedure usp_full_load_seller as

-- Creating DW tables
if object_id('dw_procfit.dbo.dim_seller') is null
begin

create table dw_procfit.dbo.dim_seller (

	cd_seller				numeric(15)		primary key
	,seller_name			varchar(160)
)

end;




-- Truncate dim table
truncate table dw_procfit.dbo.dim_seller;



-- Insert values into dimension
insert into dw_procfit.dbo.dim_seller
select
    *
from staging_procfit.dbo.vw_dim_seller