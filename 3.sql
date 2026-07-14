BEGIN;

-- 1
SELECT uf, COUNT(1) AS quant_cadastros FROM cliente
GROUP BY uf;

-- 2
SELECT unid_prod, COUNT(1) FROM produto
GROUP BY unid_prod;

-- 3
SELECT faixa_comiss, AVG(sal_fixo) FROM vendedor
GROUP BY faixa_comiss;

-- 4
SELECT faixa_comiss, MAX(sal_fixo), MIN(sal_fixo) FROM vendedor
GROUP BY faixa_comiss;

-- 5
SELECT cd_cli, COUNT(1) FROM pedido
GROUP BY cd_cli;

-- 6
SELECT cd_vend, COUNT(1) AS quant FROM pedido
GROUP BY cd_vend
ORDER BY quant DESC;

-- 7
SELECT cd_prod, SUM(qtd_ped) FROM item_pedido
GROUP BY cd_prod;

-- 8
SELECT cd_vend, AVG(prazo_entr) FROM pedido
GROUP BY cd_vend;

-- 9
SELECT uf FROM cliente
GROUP BY uf
HAVING COUNT(1) > 2;

-- 10
SELECT cidade FROM cliente
GROUP BY cidade
HAVING COUNT(1) = 1;

-- 11
SELECT no_ped, COUNT(1) FROM item_pedido
GROUP BY no_ped
HAVING COUNT(1) > 2;

-- 12
SELECT cd_prod FROM item_pedido
GROUP BY cd_prod
HAVING SUM(qtd_ped) > 1000;

-- 13
SELECT faixa_comiss, SUM(sal_fixo) AS total FROM vendedor
GROUP BY faixa_comiss
ORDER BY total DESC;

-- 14
SELECT faixa_comiss FROM vendedor
GROUP BY faixa_comiss
HAVING SUM(sal_fixo) > 2000;

-- 15
SELECT cd_vend FROM pedido
GROUP BY cd_vend
HAVING AVG(prazo_entr) > 10;

-- 16
SELECT cd_prod, MAX(qtd_ped) FROM item_pedido
GROUP BY cd_prod;

-- 17
SELECT COUNT(1) FROM cliente
WHERE uf = 'RJ'
GROUP BY cidade;

-- 18
WITH sum_qtd_ped AS (
    SELECT no_ped, SUM(qtd_ped) AS total FROM item_pedido
    GROUP BY no_ped
)
SELECT * FROM sum_qtd_ped
WHERE total > 800;

-- 19
SELECT cd_cli FROM pedido
GROUP BY cd_cli
HAVING COUNT(1) > 2;

-- 20
WITH unrestrained AS (
    SELECT unid_prod, AVG(val_unit) AS avg_val_unit FROM produto
    GROUP BY unid_prod
)
SELECT * FROM unrestrained
ORDER BY avg_val_unit DESC;

ROLLBACK;