-- Ingest customer data from transactional database to staging area
use staging_procfit;


-- Creating tables
if object_id('staging_procfit.dbo.st_customer_state') is null
begin

create table staging_procfit.dbo.st_customer_state (
	UF			varchar(2)
	,estado     varchar(60)
)
end;


-- Truncate old records
truncate table staging_procfit.dbo.st_customer_state;


-- Copy from transactional database into stage area
insert into staging_procfit.dbo.st_customer_state (
	UF
	,estado
)

	select 
		es.estado					as UF
		,es.nome					as estado
	from procfit.dbo.estados        es
;

