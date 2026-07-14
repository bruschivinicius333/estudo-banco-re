BEGIN;

-- 1
SELECT nome_cli, cidade, uf FROM cliente;

-- 2
SELECT no_ped, cd_prod, qtd_ped FROM item_pedido
WHERE qtd_ped = 500;

-- 3
SELECT * FROM cliente
WHERE cidade = 'Niteroi';

-- 4
SELECT nome_cli FROM cliente
WHERE uf != 'SP';

-- 5
SELECT * FROM pedido
WHERE cd_vend = 1 AND prazo_entr > 5;

-- 6
SELECT nome_cli FROM cliente
WHERE uf = 'RJ' AND cidade != 'Rio de Janeiro';

-- 7
SELECT desc_prod, val_unit FROM produto
WHERE unid_prod = 'L' OR val_unit != 4.5;

-- 8
SELECT * FROM pedido
WHERE cd_cli > 1000 AND (cd_vend = 4 OR cd_vend = 5);

-- 9
SELECT cod_prod, desc_prod FROM produto
WHERE val_unit BETWEEN 0.10 AND 3.00;

-- 10
SELECT * FROM produto 
WHERE unid_prod LIKE 'K%';

-- 11
SELECT * FROM vendedor
WHERE nome_vend NOT LIKE 'A%';

-- 12
SELECT * FROM cliente
WHERE endereco IS NULL;

-- 13
SELECT * FROM vendedor
ORDER BY nome_vend ASC;

-- 14
SELECT nome_cli, endereco FROM cliente
WHERE uf IN ('SP', 'RJ')
AND nome_cli LIKE 'R%'
ORDER BY cep DESC;

-- 15
SELECT (sal_fixo * 1.75) + 120 AS novo_sal_fixo FROM vendedor
WHERE faixa_comiss = 'c';

-- 16
SELECT MIN(sal_fixo), MAX(sal_fixo) FROM vendedor;

-- 17
SELECT SUM(qtd_ped) FROM item_pedido
WHERE cd_prod = 2;

-- 18
SELECT SUM(sal_fixo) FROM vendedor;

-- 19
SELECT AVG(sal_fixo) FROM vendedor;

-- 20
SELECT COUNT(1) FROM vendedor
WHERE sal_fixo > 2000;

-- 21
SELECT c.nome_cli, c.cod_cli, p.num_ped FROM cliente c
INNER JOIN pedido p
ON c.cod_cli = p.cd_cli;

-- 22
SELECT * FROM cliente c
INNER JOIN pedido p
ON c.cod_cli = p.cd_cli
WHERE p.prazo_entr > 15
AND c.uf IN ('SP', 'RJ');

-- 23
SELECT (
    SELECT nome_cli FROM cliente
    WHERE cod_cli = cd_cli
), prazo_entr FROM pedido
ORDER BY prazo_entr DESC;

-- 24
SELECT * FROM cliente 
WHERE cod_cli IN (
    SELECT cd_cli FROM pedido
    WHERE num_ped IN (
        SELECT no_ped FROM item_pedido
        WHERE cd_prod = (
            SELECT cod_prod FROM produto
            WHERE desc_prod = 'Chapa Aço'
        )
    )
    AND prazo_entr > 15
)
ORDER BY nome_cli ASC;

-- 25

SELECT COUNT(1) FROM pedido
WHERE cd_vend = (
    SELECT cod_vend FROM vendedor
    WHERE nome_vend = 'Ana Cristina'
);

ROLLBACK;

