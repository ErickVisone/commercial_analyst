-- Creating DW tables
if object_id('dw_procfit.dbo.dim_customer') is null
begin

create table dw_procfit.dbo.dim_customer (

	cd_customer				numeric(15)		primary key
	,customer_short_name	varchar(160)
	,customer_name			varchar(80)
	,customer_type			varchar(160)
	,city					varchar(80)
	,state_name				varchar(80)
	,state_short_name		char(10)
)

end
;

create or alter view vw_dim_customer as 

-- Including default values when fact table has unwknown customers
select 
	0															as cd_customer
	,'UNKNOWN'													as customer_short_name
	,'UNKNOWN'													as customer_name
	,'UNKNOWN'													as customer_type
	,'UNKNOWN'													as city
	,'UNKNOWN'													as state_name
	,'UNKNOWN'													as state_short_name

union all

select 
	cu.cod_cliente												as cd_customer
	,upper(cu.nome)												as customer_short_name
	,upper(cu.nome_fantasia)									as customer_name
	,upper(coalesce(cc.descricao,'Unknown'))					as customer_type
	,upper(coalesce(ca.cidade,'Unknown'))						as city
	,upper(coalesce(ce.estado,'Unknown'))						as state_name
	,upper(coalesce(ca.UF,'Unknown'))							as state_short_name
from staging_procfit.dbo.st_customer						cu
left join staging_procfit.dbo.st_customer_classification	cc
	on cu.cod_classificacao = cc.cod_classificacao
left join staging_procfit.dbo.st_customer_address			ca
	on cu.cod_cliente = ca.entidade
left join staging_procfit.dbo.st_customer_state				ce
	on ca.UF = ce.uf
;

merge into dw_procfit.dbo.dim_customer		t
using staging_procfit.dbo.vw_dim_customer	s
	on t.cd_customer = s.cd_customer

when matched then update set 
	customer_short_name	= s.customer_short_name
	,customer_name			= s.customer_name
	,customer_type			= s.customer_type
	,city					= s.city
	,state_name				= s.state_name
	,state_short_name		= s.state_short_name

when not matched by target then insert (
	cd_customer
	,customer_short_name
	,customer_name			
	,customer_type			
	,city					
	,state_name		
	,state_short_name
)
values (
	s.cd_customer
	,s.customer_short_name
	,s.customer_name			
	,s.customer_type			
	,s.city					
	,s.state_name		
	,s.state_short_name

)
;


select 
	*
from dw_procfit.dbo.dim_customer