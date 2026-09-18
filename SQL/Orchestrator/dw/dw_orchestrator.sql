create procedure ups_dw_full_load as

exec dw_procfit.dbo.usp_full_load_company;

exec dw_procfit.dbo.usp_full_load_customer;

exec dw_procfit.dbo.usp_full_load_product;

exec dw_procfit.dbo.usp_full_load_seller;
