create procedure usp_stage_load as

exec staging_procfit.dbo.usp_load_st_customer;

exec staging_procfit.dbo.usp_load_st_company;

exec staging_procfit.dbo.usp_load_st_product;

exec staging_procfit.dbo.usp_load_st_seller;

exec staging_procfit.dbo.usp_load_st_sales_insights;