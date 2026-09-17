-- Ingest customer data from transactional database to staging area
use staging_procfit;

-- Creating tables
if object_id('staging_procfit.dbo.st_company') is null
begin
	create table staging_procfit.dbo.st_company (
		empresa_usuaria		varchar(50)
		,nome			    varchar(100)
        ,nome_fantasia      varchar(100)
	)
end
;


-- Truncate old records
truncate table staging_procfit.dbo.st_company;



-- Copy from transactional database into stage area
insert into staging_procfit.dbo.st_company (
	empresa_usuaria
	,nome
    ,nome_fantasia
	)
select
	empresa_usuaria
	,nome
    ,nome_fantasia
from procfit.dbo.empresas_usuarias
