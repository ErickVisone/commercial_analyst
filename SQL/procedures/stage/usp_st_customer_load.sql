create procedure usp_load_st_customer as

----------------------------------------------
--           Creating tables 
----------------------------------------------

if object_id('staging_procfit.dbo.st_customer') is null
create table st_customer (
	cod_cliente			numeric(15)
	,nome				varchar(100)
	,nome_fantasia		varchar(100)
	,cod_classificacao	numeric(15)

);


if object_id('staging_procfit.dbo.st_customer_state') is null
begin

create table staging_procfit.dbo.st_customer_state (
	UF			varchar(2)
	,estado     varchar(60)
)
end;


if object_id('staging_procfit.dbo.st_customer_classification') is null
begin

create table staging_procfit.dbo.st_customer_classification (
	cod_classificacao	numeric(15)
	,descricao			varchar(80)
)
end;


if object_id('staging_procfit.dbo.st_customer_address') is null
begin

create table staging_procfit.dbo.st_customer_address (
	entidade	numeric(15)
	,cidade		varchar(100)
	,UF			varchar(2)
)
end;


----------------------------------------------
--           Truncating tables 
----------------------------------------------
truncate table staging_procfit.dbo.st_customer;

truncate table staging_procfit.dbo.st_customer_state;

truncate table staging_procfit.dbo.st_customer_classification;

truncate table staging_procfit.dbo.st_customer_address;



----------------------------------------------
--           Ingesting Data 
----------------------------------------------

insert into staging_procfit.dbo.st_customer (
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



insert into staging_procfit.dbo.st_customer_state (
	UF
	,estado
)

	select 
		es.estado					as UF
		,es.nome					as estado
	from procfit.dbo.estados        es
;


insert into staging_procfit.dbo.st_customer_classification (
	cod_classificacao
	,descricao
)

	select 
		cc.classificacao_cliente					as cod_cliente
		,cc.descricao								as classificacao_descricao
	from procfit.dbo.classificacoes_clientes        cc
;


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
