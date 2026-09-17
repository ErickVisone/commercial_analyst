-- Ingest customer data from transactional database to staging area
use staging_procfit;


-- Creating tables
if object_id('staging_procfit.dbo.st_sales_insights') is null
begin
	create table staging_procfit.dbo.st_sales_insights (
        n_doc                   numeric(15)
        ,cod_empresa             numeric(15)
        ,cod_cliente             numeric(15)
        ,cod_vendedor            numeric(15)
        ,movimento               date
        ,cod_produto             numeric(15)
        ,quantidade              money
        ,venda_bruta             money
        ,desconto                money
        ,venda_liquida           money
	)
end
;


-- Truncate old records
truncate table staging_procfit.dbo.st_sales_insights;



-- Copy from transactional database into stage area
insert into staging_procfit.dbo.st_sales_insights (
    n_doc
    ,cod_empresa
    ,cod_cliente
    ,cod_vendedor
    ,movimento
    ,cod_produto
    ,quantidade
    ,venda_bruta
    ,desconto
    ,venda_liquida
	)
select 
    documento_numero
    ,empresa
    ,cliente
    ,vendedor
    ,movimento
    ,produto
    ,quantidade
    ,venda_bruta
    ,desconto + desconto_negociado as desconto
    ,venda_liquida
from procfit.dbo.vendas_analiticas