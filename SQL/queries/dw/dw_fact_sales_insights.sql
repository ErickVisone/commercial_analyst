if object_id('dw_procfit.dbo.fact_sales_insights') is null
begin
	create table dw_procfit.dbo.fact_sales_insights (
		cd_doc			NUMERIC(15)
		,cd_company		NUMERIC(15) references dw_procfit.dbo.dim_company (cd_company)
		,cd_customer	NUMERIC(15) references dw_procfit.dbo.dim_customer (cd_customer)
		,cd_seller		NUMERIC(15) references dw_procfit.dbo.dim_seller (cd_seller)
		,date			DATE
		,cd_product		NUMERIC(15) references dw_procfit.dbo.dim_product (cd_product)
		,quantity		INT
		,gross_sales	MONEY
		,discount		MONEY
		,net_sales		MONEY
	)
end
;


truncate table dw_procfit.dbo.fact_sales_insights ;



create view vw_sales_insights as
select 
	coalesce(n_doc,0)			as cd_doc
	,coalesce(cod_empresa,0)	as cd_company
	,coalesce(cod_cliente,0)	as cd_customer
	,coalesce(cod_vendedor,0)	as cd_seller
	,movimento					as date
	,coalesce(cod_produto,0)	as cd_product
	,quantidade					as quantity
	,venda_bruta				as gross_sales
	,desconto					as discount
	,venda_liquida				as net_sales
from staging_procfit.dbo.st_sales_insights