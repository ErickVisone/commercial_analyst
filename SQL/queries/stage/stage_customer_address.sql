-- Ingest customer data from transactional database to staging area
use staging_procfit;

-- Creating tables
if object_id('staging_procfit.dbo.st_customer_address') is null
begin

create table staging_procfit.dbo.st_customer_address (
	entidade	numeric(15)
	,cidade		varchar(100)
	,UF			varchar(2)
)
end;


-- Truncate old records
truncate table staging_procfit.dbo.st_customer_address;


-- Copy from transactional database into stage area
insert into staging_procfit.dbo.st_customer_address (
	entidade
	,cidade
	,uf
)

	select 
		ed.entidade					as entidade
		,ed.cidade					as cidade
		,ed.estado					as estado
	from procfit.dbo.enderecos        ed
;


