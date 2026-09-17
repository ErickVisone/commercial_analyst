create procedure usp_load_st_product as


----------------------------------------------
--           Creating tables 
----------------------------------------------
if object_id('staging_procfit.dbo.st_product') is null
begin
	create table staging_procfit.dbo.st_product (
        produto                 numeric(15)
        ,descricao              varchar(100)
        ,descricao_reduzida     varchar(60)
        ,familia                varchar(80)
        ,secao                  varchar(80)
        ,grupo                  varchar(80)
        ,sub_grupo              varchar(80)
        ,marca                  varchar(80)
	)
end
;


----------------------------------------------
--           Truncating tables 
----------------------------------------------
truncate table staging_procfit.dbo.st_product;



----------------------------------------------
--           Ingesting Data 
----------------------------------------------
insert into staging_procfit.dbo.st_product (
	produto
    ,descricao
    ,descricao_reduzida
    ,familia
    ,secao
    ,grupo
    ,sub_grupo
    ,marca
	)
select
    pr.produto                                      as produto
    ,pr.descricao                                   as descricao
    ,pr.descricao_reduzida                          as descricao_reduzida
    ,pr.familia_produto                             as familia
    ,sp.secao_produto                               as secao
    ,gp.grupo_produto                               as grupo
    ,sg.subgrupo_produto                            as sub_grupo
    ,ma.descricao                                   as marca
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