create procedure usp_load_st_seller as


----------------------------------------------
--           Creating tables 
----------------------------------------------
if object_id('staging_procfit.dbo.st_sellers') is null
begin
	create table staging_procfit.dbo.st_sellers (
		vendedor		varchar(50)
		,nome			varchar(100)
	)
end
;


----------------------------------------------
--           Truncating tables 
----------------------------------------------
truncate table staging_procfit.dbo.st_sellers;



----------------------------------------------
--           Ingesting Data 
----------------------------------------------
insert into staging_procfit.dbo.st_sellers (
	vendedor
	,nome
	)
select
	vendedor
	,nome
from procfit.dbo.vendedores
