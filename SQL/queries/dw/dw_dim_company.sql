-- Creating DW tables
if object_id('dw_procfit.dbo.dim_company') is null
begin

create table dw_procfit.dbo.dim_company (

	cd_company				numeric(15)		primary key
	,company_name			varchar(160)
	,company_short_name		varchar(80)

)

end;



--creating view
create or alter view vw_dim_company as 

select 
	0											as cd_company
	,'UNKNOWN'									as company_name
	,'UNKNOWN'									as company_short_name

union all 

select 
	upper(coalesce(empresa_usuaria,'Unknown'))	as cd_company
	,upper(coalesce(nome,'Unknown'))			as company_name
	,upper(coalesce(nome_fantasia,'Unknown'))	as company_short_name
from staging_procfit.dbo.st_company
;



-- Merge
merge into dw_procfit.dbo.dim_company		t
using staging_procfit.dbo.vw_dim_company	s
	on t.cd_company = s.cd_company

when matched then update set 
	company_name	= s.company_name
	,company_short_name			= s.company_short_name

when not matched by target then insert (
	cd_company
	,company_name
	,company_short_name			
)
values (
	s.cd_company
	,s.company_name
	,s.company_short_name			

)
;


select * from dw_procfit.dbo.dim_company