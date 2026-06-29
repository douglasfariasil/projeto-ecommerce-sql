-- Aqui queries complexas (JOINs, Window Functions, Group By)
USE ecommerce_db;

-- Query: Faturamento total por cliente (Quem são os clientes que mais gastam?)
SELECT 
    c.nome AS nome_cliente,
    c.estado,
    COUNT(p.pedido_id) AS total_pedidos,
    SUM(p.quantidade * pr.preco) AS total_gasto
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.cliente_id
JOIN produtos pr ON p.produto_id = pr.produto_id
WHERE p.status_pedido != 'Cancelado'
GROUP BY c.cliente_id, c.nome, c.estado
ORDER BY total_gasto DESC;
