-- Ingest customer data from transactional database to staging area
use staging_procfit;

-- Creating tables
if object_id(N'staging_procfit.dbo.st_clientes', N'U') is null
create table st_clientes (
	cod_cliente			numeric(15)
	,nome				varchar(100)
	,nome_fantasia		varchar(100)
	,cod_classificacao	numeric(15)

);

-- Truncate old records
truncate table staging_procfit.dbo.st_clientes;

-- Copy from transactional database into stage area
insert into staging_procfit.dbo.st_clientes (
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

