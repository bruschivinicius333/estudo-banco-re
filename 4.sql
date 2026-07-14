BEGIN;

-- 1
SELECT nome_vend, sal_fixo FROM vendedor
ORDER BY sal_fixo DESC
LIMIT 3; 

-- 2
SELECT desc_prod, val_unit FROM produto
ORDER BY val_unit ASC;

-- 3
SELECT cod_cli, nome_cli FROM cliente
ORDER BY cod_cli ASC
LIMIT 4;

-- 4
SELECT num_ped, prazo_entr FROM pedido
ORDER BY prazo_entr ASC
LIMIT 3;

-- 5
SELECT nome_vend, sal_fixo FROM vendedor
ORDER BY sal_fixo ASC
LIMIT 1;

-- 6
SELECT nome_cli AS nome_pessoa FROM cliente
UNION
SELECT nome_vend FROM vendedor;

-- 7
SELECT cd_cli FROM pedido
WHERE prazo_entr > 15
UNION
SELECT cod_cli FROM cliente
WHERE uf = 'SP';

-- 8
SELECT cd_cli FROM pedido
WHERE prazo_entr > 15
UNION ALL
SELECT cod_cli FROM cliente
WHERE uf = 'SP';

-- 9
SELECT val_unit AS valores_financeiros FROM produto
UNION
SELECT sal_fixo FROM vendedor;

-- 10
SELECT nome_cli, uf FROM cliente
WHERE uf = 'RJ'
UNION
SELECT nome_cli, uf FROM cliente
WHERE uf = 'SP'
ORDER BY nome_cli ASC;

ROLLBACK;