-- Ingest customer data from transactional database to staging area
use staging_procfit;

-- Creating tables
if object_id('staging_procfit.dbo.st_customers') is null
create table st_customers (
	cod_cliente			numeric(15)
	,nome				varchar(100)
	,nome_fantasia		varchar(100)
	,cod_classificacao	numeric(15)

);

-- Truncate old records
truncate table staging_procfit.dbo.st_customers;

-- Copy from transactional database into stage area
insert into staging_procfit.dbo.st_customers (
	cod_cliente
	,nome
	,nome_fantasia
	,cod_classificacao
)

	select 
		en.entidade									as cod_cliente
		,en.nome									as nome
		,en.nome_fantasia							as nome_fantasia
		,en.classificacao_cliente					as cod_classificacao
	from procfit.dbo.entidades						en
;

