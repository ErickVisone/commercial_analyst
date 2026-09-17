-- Ingest customer data from transactional database to staging area
use staging_procfit;

-- Creating tables
if object_id('staging_procfit.dbo.st_sellers') is null
begin
	create table staging_procfit.dbo.st_sellers (
		vendedor		varchar(50)
		,nome			varchar(100)
	)
end
;


-- Truncate old records
truncate table staging_procfit.dbo.st_sellers;



-- Copy from transactional database into stage area
insert into staging_procfit.dbo.st_sellers (
	vendedor
	,nome
	)
select
	vendedor
	,nome
from procfit.dbo.vendedores
