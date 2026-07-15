BEGIN;

-- 1
SELECT nome_cli, (
    SELECT COUNT(1) FROM pedido
    WHERE cd_cli = cod_cli 
) AS qtd_pedidos FROM cliente;

-- 2
SELECT desc_prod, val_unit FROM produto
WHERE val_unit > (
    SELECT AVG(val_unit) FROM produto
);

-- 3
SELECT (
    SELECT nome_vend FROM vendedor
    WHERE cod_vend = cd_vend
) FROM pedido
WHERE prazo_entr > 15;

-- 4
SELECT faixa_comiss, quant_vendedores_vinculados FROM (
    SELECT faixa_comiss, COUNT(1) AS quant_vendedores_vinculados FROM vendedor
    GROUP BY faixa_comiss
)
GROUP BY faixa_comiss, quant_vendedores_vinculados
HAVING quant_vendedores_vinculados > 3;

-- 5
SELECT (
    SELECT nome_cli FROM cliente
    WHERE cod_cli = cd_cli
) FROM pedido
GROUP BY 1
HAVING COUNT(1) >= 1;

-- 6
SELECT desc_prod FROM produto
WHERE cod_prod NOT IN (
    SELECT cd_prod FROM item_pedido
);

-- 7
SELECT nome_vend, sal_fixo FROM vendedor
WHERE sal_fixo < ANY (
    SELECT sal_fixo FROM vendedor
    WHERE faixa_comiss = 'a'
);

-- 8
SELECT desc_prod, val_unit FROM produto
WHERE val_unit > (
    SELECT SUM(val_unit) FROM produto
    WHERE unid_prod = 'CX'
);


ROLLBACK;