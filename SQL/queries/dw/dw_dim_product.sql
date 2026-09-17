--creating dw tables
if object_id('dw_procfit.dbo.dim_product') is null
begin
	create table dw_procfit.dbo.dim_product (
        cd_product              numeric(15)
        ,description            varchar(100)
        ,short_description      varchar(60)
        ,family                 varchar(80)
        ,section                varchar(80)
        ,group_name             varchar(80)
        ,subgrup_name           varchar(80)
        ,brand                  varchar(80)
	)
end
;


--creating the view

create or alter view vw_dim_product as

select
    0                                              as cd_product
    ,'UNKNOWN'                                     as description
    ,'UNKNOWN'                                     as short_description
    ,'UNKNOWN'                                     as family
    ,'UNKNOWN'                                     as section
    ,'UNKNOWN'                                     as group_name
    ,'UNKNOWN'                                     as subgrup_name
    ,'UNKNOWN'                                     as brand

union all

select
    pr.produto                                              as cd_product
    ,upper(coalesce(pr.descricao,'Unknown'))                as description
    ,upper(coalesce(pr.descricao_reduzida,'Unknown'))       as short_description
    ,upper(coalesce(fp.descricao,'Unknown'))                as family
    ,upper(coalesce(sp.descricao,'Unknown'))                as section
    ,upper(coalesce(gp.descricao,'Unknown'))                as group_name
    ,upper(coalesce(sg.descricao,'Unknown'))                as subgrup_name
    ,upper(coalesce(ma.descricao,'Unknown'))                as brand
from procfit.dbo.produtos                            pr
left join procfit.dbo.familias_produtos              fp
    on pr.familia_produto = fp.familia_produto
left join procfit.dbo.secoes_produtos                sp
    on pr.secao_produto = sp.secao_produto
left join procfit.dbo.grupos_produtos                gp
    on pr.grupo_produto = gp.grupo_produto
left join procfit.dbo.subgrupos_produtos             sg
    on pr.subgrupo_produto = sg.subgrupo_produto
left join procfit.dbo.marcas                         ma
    on pr.marca = ma.marca
;


merge into dw_procfit.dbo.dim_product       t
using staging_procfit.dbo.vw_dim_product    s
    on t.cd_product = s.cd_product

when matched then update set
    description =       s.description
    ,short_description = s.short_description
    ,family =            s.family
    ,section =           s.section
    ,group_name =        s.group_name
    ,subgrup_name =      s.subgrup_name
    ,brand  =            s.brand

when not matched by target then insert (
    cd_product
    ,description
    ,short_description
    ,family
    ,section
    ,group_name
    ,subgrup_name
    ,brand
)
values (
    s.cd_product
    ,s.description
    ,s.short_description
    ,s.family
    ,s.section
    ,s.group_name
    ,s.subgrup_name
    ,s.brand
)
;

select 
    *
from dw_procfit.dbo.dim_product