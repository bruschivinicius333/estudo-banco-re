BEGIN;

-- 1
CREATE OR REPLACE VIEW vw_info_pedidos AS
SELECT pe.num_ped, pe.prazo_entr, c.nome_cli, v.nome_vend FROM pedido pe
INNER JOIN cliente c
ON pe.cd_cli = c.cod_cli
INNER JOIN vendedor v
ON pe.cd_vend = v.cod_vend;

-- 2
CREATE OR REPLACE FUNCTION fn_calcular_total_item(
    quantidade_pedida FLOAT,
    valor_unitario NUMERIC(10, 2)
) RETURNS NUMERIC AS $$
BEGIN
    RETURN quantidade_pedida * valor_unitario;
END;
$$ LANGUAGE plpgsql;

-- 3
CREATE OR REPLACE VIEW vw_faturamento_por_estado AS
SELECT c.uf, SUM(i.qtd_ped * pr.val_unit) FROM produto pr
INNER JOIN item_pedido i
ON pr.cod_prod = i.cd_prod
INNER JOIN pedido pe
ON pe.num_ped = i.no_ped
INNER JOIN cliente c
ON pe.cd_cli = c.cod_cli
GROUP BY c.uf;

-- 4
CREATE OR REPLACE FUNCTION fn_classificar_prazo(
    prazo_entrega INT
) RETURNS VARCHAR AS $$ 
BEGIN
    IF prazo_entrega <= 15 THEN
        RETURN 'Entrega Expressa';
    ELSE
        RETURN 'Entrega Padrão';
    END IF;
END;
$$ LANGUAGE plpgsql;

-- 5
SELECT num_ped, nome_cli, fn_classificar_prazo(prazo_entr) FROM vw_info_pedidos;

-- 6
CREATE OR REPLACE FUNCTION fn_calcular_comissao(
    total_venda DECIMAL
) RETURNS DECIMAL(12, 2) AS $$
BEGIN
    IF total_venda IS NULL THEN
        RETURN 0;
    END IF;
    RETURN total_venda * 0.05;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION supervisor_nome(
    id_supervisor INT
) RETURNS VARCHAR AS $$
BEGIN
    RETURN (
        SELECT nome_vend FROM vendedor
        WHERE cod_vend = id_supervisor
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION vendedor_total_vendido(
    id_vendedor INT
) RETURNS DECIMAL AS $$
DECLARE
    result DECIMAL;
BEGIN
    result := (
        SELECT SUM(i.qtd_ped * pr.val_unit) FROM produto pr
        INNER JOIN item_pedido i
        ON pr.cod_prod = i.cd_prod
        INNER JOIN pedido pe
        ON pe.num_ped = i.no_ped
        INNER JOIN cliente c
        ON pe.cd_cli = c.cod_cli
        INNER JOIN vendedor v
        ON v.cod_vend = pe.cd_vend
        WHERE v.cod_vend = id_vendedor
        GROUP BY v.cod_vend
    );

    IF result IS NULL THEN
        result := 0;
    END IF;
    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- 7
CREATE OR REPLACE VIEW vw_desempenho_vendedores AS
SELECT
    v.nome_vend,
    COALESCE(supervisor_nome(v.cd_supervisor), 'Sem Supervisor'),
    vendedor_total_vendido(v.cod_vend) AS total_vendido
FROM vendedor v;

-- 8
SELECT nome_vend, total_vendido, fn_calcular_comissao(total_vendido) AS comissao FROM vw_desempenho_vendedores
ORDER BY comissao DESC;

-- 9
CREATE OR REPLACE VIEW vw_produtos_sem_giro AS
SELECT cod_prod, desc_prod, val_unit FROM produto
WHERE cod_prod IN (
    SELECT cod_prod FROM produto
    EXCEPT
    SELECT cd_prod FROM item_pedido
);

-- 10
WITH unnamed AS (
    SELECT c.nome_cli, pe.num_ped, fn_calcular_total_item(i.qtd_ped, pr.val_unit) AS total_produto FROM produto pr
    INNER JOIN item_pedido i
    ON pr.cod_prod = i.cd_prod
    INNER JOIN pedido pe
    ON pe.num_ped = i.no_ped
    INNER JOIN cliente c
    ON pe.cd_cli = c.cod_cli
    INNER JOIN vendedor v
    ON v.cod_vend = pe.cd_vend
    GROUP BY pe.num_ped, c.nome_cli, total_produto
)
SELECT * FROM unnamed
WHERE total_produto > (
    SELECT AVG(sal_fixo) FROM vendedor
);


ROLLBACK;