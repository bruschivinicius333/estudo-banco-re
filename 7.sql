BEGIN;

-- 1
SELECT p.desc_prod, i.no_ped FROM item_pedido i
RIGHT JOIN produto p
ON p.cod_prod = i.cd_prod;


-- 2
-- 3
-- 4
-- 5
-- 6
-- 7
-- 8
-- 9
-- 10

ROLLBACK;