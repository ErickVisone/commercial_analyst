create procedure usp_full_fac_sales_insights as 

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



truncate table dw_procfit.dbo.fact_sales_insights;


insert into dw_procfit.dbo.fact_sales_insights
select 
	*
from staging_procfit.dbo.vw_sales_insights;


