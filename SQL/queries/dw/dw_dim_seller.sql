select * from staging_procfit.dbo.st_sellers

-- Creating DW tables
if object_id('dw_procfit.dbo.dim_seller') is null
begin

create table dw_procfit.dbo.dim_seller (

	cd_seller				numeric(15)		primary key
	,seller_name			varchar(160)
)

end;



--creating view
create or alter view vw_dim_seller as 

select 
	0											as cd_seller
	,'UNKNOWN'									as seller_name

union all

select 
	vendedor									as cd_seller
	,upper(coalesce(nome,'Unknown'))			as seller_name
from staging_procfit.dbo.st_sellers
;



-- Merge
merge into dw_procfit.dbo.dim_seller		t
using staging_procfit.dbo.vw_dim_seller		s
	on t.cd_seller = s.cd_seller

when matched then update set 
	seller_name	= s.seller_name

when not matched by target then insert (
	cd_seller
	,seller_name
)
values (
	s.cd_seller
	,s.seller_name	

)
;


select * from dw_procfit.dbo.dim_seller