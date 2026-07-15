BEGIN;

-- 1
SELECT p.desc_prod, i.no_ped FROM item_pedido i
RIGHT JOIN produto p
ON p.cod_prod = i.cd_prod;

-- 2
SELECT c.nome_cli, p.num_ped FROM cliente c
FULL JOIN pedido p
ON c.cod_cli = p.cd_cli;

-- 3
SELECT nome_vend, (
    SELECT inner_v.nome_vend FROM vendedor inner_v
    WHERE inner_v.cod_vend = outer_v.cd_supervisor
) AS supervisor FROM vendedor outer_v;

-- 4
SELECT pe.num_ped, c.nome_cli, v.nome_vend, (i.qtd_ped * pr.val_unit) AS val_financ_total FROM produto pr
INNER JOIN item_pedido i
ON pr.cod_prod = i.cd_prod
INNER JOIN pedido pe
ON pe.num_ped = i.no_ped
INNER JOIN vendedor v
ON pe.cd_vend = v.cod_vend
INNER JOIN cliente c
ON pe.cd_cli = c.cod_cli;

-- 5
SELECT nome_vend FROM vendedor
WHERE cod_vend IN (
    SELECT cd_supervisor FROM vendedor
    GROUP BY cd_supervisor
    HAVING COUNT(1) >= 2
);

-- 6
SELECT c.nome_cli, pr.desc_prod, i.qtd_ped FROM produto pr
INNER JOIN item_pedido i
ON pr.cod_prod = i.cd_prod
INNER JOIN pedido pe
ON pe.num_ped = i.no_ped
INNER JOIN cliente c
ON pe.cd_cli = c.cod_cli
WHERE c.uf = 'SP'
AND pr.unid_prod = 'KG';

-- 7
SELECT v.nome_vend, COUNT(pe.cd_vend) AS quant_vendas FROM pedido pe
RIGHT JOIN vendedor v
ON pe.cd_vend = v.cod_vend
GROUP BY v.nome_vend; 

-- 8
SELECT c.nome_cli, COALESCE(CAST(pe.num_ped AS VARCHAR), 'Sem Pedido') FROM cliente c
LEFT JOIN pedido pe
ON c.cod_cli = pe.cd_cli;

-- 9
WITH x AS (
    SELECT c.nome_cli, SUM(pr.val_unit * i.qtd_ped) AS total_gasto FROM produto pr
    INNER JOIN item_pedido i
    ON pr.cod_prod = i.cd_prod
    INNER JOIN pedido pe
    ON pe.num_ped = i.no_ped
    INNER JOIN cliente c
    ON pe.cd_cli = c.cod_cli
    GROUP BY c.nome_cli
)
SELECT * FROM x
WHERE total_gasto > (
    SELECT AVG(sal_fixo) FROM vendedor
);

-- 10
SELECT pe.num_ped, c.nome_cli, v.nome_vend, (
    SELECT inner_v.nome_vend FROM vendedor inner_v
    WHERE inner_v.cod_vend = v.cd_supervisor
) AS nome_supervisor, SUM(pr.val_unit * i.qtd_ped) AS total_pedido FROM produto pr
INNER JOIN item_pedido i
ON pr.cod_prod = i.cd_prod
INNER JOIN pedido pe
ON pe.num_ped = i.no_ped
INNER JOIN cliente c
ON pe.cd_cli = c.cod_cli
INNER JOIN vendedor v
ON pe.cd_vend = v.cod_vend
GROUP BY pe.num_ped, c.nome_cli, v.nome_vend, nome_supervisor
ORDER BY total_pedido DESC;   


ROLLBACK;