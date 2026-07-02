
-- Perguntas de Negócio Respondidas com Código.
USE ecommerce_db;

-- -------------------------------------------------------------
-- INSIGHT 1: Distribuição de Clientes por Estado (Tabela Clientes)
-- -------------------------------------------------------------

-- Query: Contagem de clientes por estado e a porcentagem que representam do total de clientes.
SELECT
    customer_state AS estado,
    COUNT(customer_id) AS total_clientes,
    ROUND((COUNT(customer_id) / 99441) * 100, 2) AS porcentagem_total
FROM
    olist_clientes   
GROUP BY
    customer_state
ORDER BY
    total_clientes DESC;

-- -------------------------------------------------------------
-- INSIGHT 2: Análise Financeira de Itens Vendidos (Tabela Itens)
-- -------------------------------------------------------------

-- Query: Faturamento total e ticket médio por estado do cliente.
SELECT 
    COUNT(order_id) AS total_itens_comercializados,
    ROUND(SUM(price), 2) AS faturamento_bruto_produtos,
    ROUND(AVG(price), 2) AS preco_medio_por_item,
    ROUND(SUM(freight_value), 2) AS total_gasto_frete
FROM olist_pedido_itens;
-- Nota: No dataset completo da Olist, existe a tabela `olist_orders` que une as duas. 
-- Como carregamos essas duas principais, você já demonstrou o domínio do LOAD DATA!
