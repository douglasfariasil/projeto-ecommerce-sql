-- Script que cria as tabelas automaticamente no Docker, caso elas não existam.
USE ecommerce_db;

-- Criação da tabela de Clientes
CREATE TABLE IF NOT EXISTS clientes (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    estado VARCHAR(2) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Criação da tabela de Produtos
CREATE TABLE IF NOT EXISTS produtos (
    produto_id INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(150) NOT NULL,
    categoria VARCHAR(50),
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT DEFAULT 0
);

-- Criação da tabela de Pedidos (Relaciona Clientes e Produtos)
CREATE TABLE IF NOT EXISTS pedidos (
    pedido_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_pedido VARCHAR(50) DEFAULT 'Pendente',
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    FOREIGN KEY (produto_id) REFERENCES produtos(produto_id)
);

-- Inserindo alguns dados para teste 
INSERT INTO clientes (nome, email, estado, cidade) VALUES
('Douglas Silva', 'douglas@email.com', 'SP', 'São Paulo'),
('Maria Oliveira', 'maria@email.com', 'RJ', 'Rio de Janeiro'),
('João Santos', 'joao@email.com', 'MG', 'Belo Horizonte'),
('Carlos Souza','carlos@email.com', 'BA', 'Salvador'),
('Ana Lima', 'ana@email.com', 'RS', 'Porto Alegre'),
('Fernanda Costa', 'fernanda@email.com', 'PR', 'Curitiba'),
('Rafael Almeida', 'rafael@email.com', 'SC', 'Florianópolis');

INSERT INTO produtos (nome_produto, categoria, preco, estoque) VALUES
('Teclado Mecânico RGB', 'Periféricos', 350.00, 15),
('Mouse Gamer 1600 DPI', 'Periféricos', 220.00, 30),
('Monitor LED 24 polegadas 144Hz', 'Monitores', 1200.00, 8),
('Notebook Dell Inspiron', 'Eletrônicos', 3500.00, 10),
('Smartphone Samsung Galaxy', 'Eletrônicos', 2500.00, 15),
('Camiseta Polo', 'Roupas', 80.00, 50),
('Tênis Nike Air Max', 'Calçados', 300.00, 20),
('Livro "Aprendendo SQL"', 'Livros', 45.00, 30),
('Fone de Ouvido Bluetooth', 'Eletrônicos', 150.00, 25),
('Relógio Smartwatch', 'Eletrônicos', 500.00, 12);

INSERT INTO pedidos (cliente_id, produto_id, quantidade, status_pedido) VALUES
(1, 1, 1, 'Entregue'),
(1, 2, 1, 'Entregue'),
(2, 3, 1, 'Processando'),
(3, 2, 2, 'Pendente'),
(5, 4, 1, 'Processando'),
(6, 6, 4, 'Pendente'),
(7, 7, 2, 'Cancelado');


-- Tabela real para os clientes da Olist
CREATE TABLE IF NOT EXISTS olist_clientes (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50) NOT NULL,
    customer_zip_code_prefix INT NOT NULL,
    customer_city VARCHAR(100) NOT NULL,
    customer_state VARCHAR(2) NOT NULL
);

-- Tabela real para os produtos da Olist
CREATE TABLE IF NOT EXISTS olist_produtos (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

-- Tabela de junção: Itens dos Pedidos (Une produtos e pedidos)
CREATE TABLE IF NOT EXISTS olist_pedido_itens (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME,
    price DECIMAL(10, 2),
    freight_value DECIMAL(10, 2)
);
