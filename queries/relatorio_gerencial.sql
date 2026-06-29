-- Perguntas de Negócio Respondidas com Código.
USE ecommerce_db;

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
 