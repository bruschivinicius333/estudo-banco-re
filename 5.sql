BEGIN;

-- 1
SELECT cd_cli FROM pedido
GROUP BY cd_cli
HAVING COUNT(1) > 1
INTERSECT
SELECT cod_cli FROM cliente
WHERE uf = 'RJ';

-- 2
SELECT cod_vend FROM vendedor
WHERE sal_fixo > 1500
EXCEPT
SELECT cod_vend FROM vendedor
GROUP BY cod_vend
HAVING COUNT(1) > 2;

-- 3
SELECT cd_prod FROM item_pedido
WHERE qtd_ped >= 300
INTERSECT
SELECT cd_prod FROM item_pedido
WHERE qtd_ped <= 500
ORDER BY cd_prod DESC
LIMIT 2;

-- 4
SELECT no_ped FROM item_pedido
GROUP BY no_ped
HAVING COUNT(1) > 2
EXCEPT
SELECT no_ped FROM item_pedido
WHERE qtd_ped > 1000;

-- 5
SELECT cd_vend FROM pedido
GROUP BY cd_vend
HAVING AVG(prazo_entr) > 10
INTERSECT 
SELECT cd_vend FROM pedido
GROUP BY cd_vend
HAVING COUNT(1) > 1;

-- 6
SELECT cidade, uf FROM cliente
EXCEPT
SELECT cidade, uf FROM cliente
WHERE cod_cli IN (1,2,3)
ORDER BY cidade ASC;

-- 7
SELECT cd_cli FROM pedido
WHERE prazo_entr < 15
INTERSECT
SELECT cd_cli FROM pedido
GROUP BY cd_cli
HAVING COUNT(1) >= 2;

-- 8 // ver como eu fiz antes
SELECT cod_prod FROM produto
WHERE val_unit > 2
EXCEPT 
SELECT cd_prod FROM item_pedido;

-- 9
SELECT cod_cli FROM cliente
WHERE uf IN ('RJ', 'SP')
INTERSECT
SELECT cod_cli FROM cliente
GROUP BY cod_cli
HAVING COUNT(1) >= 1
ORDER BY cod_cli ASC
LIMIT 3;

-- 10
(
    SELECT cod_vend FROM vendedor
    WHERE faixa_comiss = 'a'
    UNION
    SELECT cod_vend FROM vendedor
    WHERE faixa_comiss = 'b'
)
EXCEPT 
SELECT cd_vend FROM pedido
WHERE prazo_entr = 30;


ROLLBACK;