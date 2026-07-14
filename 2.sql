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


-- 6
-- 7
-- 8
-- 9
-- 10
-- 11
-- 12
-- 13
-- 14
-- 15
-- 16
-- 17
-- 18
-- 19
-- 20
-- 21
-- 22
-- 23
-- 24
-- 25


ROLLBACK;

