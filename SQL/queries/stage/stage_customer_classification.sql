-- Ingest customer data from transactional database to staging area
use staging_procfit;

-- Creating tables
if object_id('staging_procfit.dbo.st_customer_classification') is null
begin

create table staging_procfit.dbo.st_customer_classification (
	cod_classificacao	numeric(15)
	,descricao			varchar(80)
)
end;


-- Truncate old records
truncate table staging_procfit.dbo.st_customer_classification;


-- Copy from transactional database into stage area
insert into staging_procfit.dbo.st_customer_classification (
	cod_classificacao
	,descricao
)

	select 
		cc.classificacao_cliente					as cod_cliente
		,cc.descricao								as classificacao_descricao
	from procfit.dbo.classificacoes_clientes        cc
;

