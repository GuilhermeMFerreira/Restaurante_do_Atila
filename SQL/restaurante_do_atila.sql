-- 1. Criar e Selecionar o Banco de Dados
create database if not exists restaurante_atila;
USE restaurante_atila;

-- CRIAÇÃO DAS TABELAS

-- 2. Tabela de Clientes
create table if not exists clientes (
    id_cliente int auto_increment primary key,
    nome_cliente varchar(100) not null,
    cpf varchar(14),
    telefone varchar(20)
);

-- 3. Tabela de Atendimentos (Registra a mesa/sessão do cliente)
create table if not exists atendimentos (
    id_atendimento int auto_increment primary key,
    id_cliente int,
    mesa int not null,
    data_hora datetime default current_timestamp,
    foreign key (id_cliente) references clientes(id_cliente)
);

-- 4. Tabela do Cardápio
create table if not exists cardapio (
    id_cardapio int auto_increment primary key,
    nome_prato varchar(100) not null,
    preco decimal(10,2) not null,
    categoria varchar(50)
);

-- 5. Tabela do Estoque
create table if not exists estoque (
    id_estoque int auto_increment primary key,
    nome_ingrediente varchar(100) not null,
    quantidade_disponivel decimal(10,2) not null,
    unidade_medida varchar(20) -- Ex: kg, Litros, Unidades
);

-- 6. Tabela de Pedidos (Relaciona Atendimento, Cardápio e guarda o Status do Prato)
create table if not exists pedidos (
    id_pedido int auto_increment primary key,
    id_atendimento int,
    id_cardapio int,
    quantidade int default 1,
    status_prato varchar(30) default 'Em preparo', -- Ex: Recebido, Em preparo, Pronto, Entregue
    foreign key (id_atendimento) references atendimentos(id_atendimento),
    foreign key (id_cardapio) references cardapio(id_cardapio)
);

-- DADOS DE TESTE (Para popular o banco)

-- Inserir Clientes
-- Povoando Clientes (6 registros)
INSERT INTO clientes (nome_cliente, cpf, telefone) VALUES
('Lucas Silva', '123.456.789-00', '(11) 99999-1111'),
('Maria Oliveira', '987.654.321-11', '(11) 98888-2222'),
('Carlos Eduardo', '456.789.123-22', '(21) 97777-3333'),
('Ana Clara Silva', '321.654.987-33', '(11) 96666-4444'),
('Mateus Santos', '654.987.321-44', '(31) 95555-5555'),
('Fernanda Lima', '789.123.456-55', '(11) 94444-6666');

-- Povoando Atendimentos (6 registros)
INSERT INTO atendimentos (id_cliente, mesa, data_hora) VALUES
(1, 5, '2026-03-01 19:00:00'),
(2, 3, '2026-03-01 19:30:00'),
(3, 1, '2026-03-01 20:00:00'),
(4, 2, '2026-03-02 12:15:00'),
(5, 4, '2026-03-02 13:00:00'),
(6, 5, '2026-03-02 20:30:00');

-- Povoando Cardápio (6 registros)
INSERT INTO cardapio (nome_prato, preco, categoria) VALUES
('Hambúrguer Artesanal', 35.00, 'Lanche'),
('Batata Frita', 18.00, 'Acompanhamento'),
('Refrigerante Lata', 7.00, 'Bebida'),
('Pizza Broto', 28.00, 'Lanche'),
('Suco Natural', 10.00, 'Bebida'),
('Pudim de Leite', 12.00, 'Sobremesa');

-- Povoando Estoque (6 registros)
INSERT INTO estoque (nome_ingrediente, quantidade_disponivel, unidade_medida) VALUES
('Carne de Hambúrguer', 45.00, 'Unidades'),
('Batata Congelada', 15.00, 'kg'),
('Refrigerante 350ml', 80.00, 'Unidades'),
('Massa de Pizza', 25.00, 'Unidades'),
('Polpa de Fruta', 8.00, 'kg'),
('Leite Condensado', 50.00, 'Unidades');

-- Povoando Pedidos (8 registros)
INSERT INTO pedidos (id_atendimento, id_cardapio, quantidade, status_prato) VALUES
(1, 1, 2, 'Entregue'),     -- Lucas pediu 2 Hambúrgueres
(1, 3, 2, 'Entregue'),     -- Lucas pediu 2 Refrigerantes
(2, 2, 1, 'Entregue'),     -- Maria pediu 1 Batata Frita
(3, 4, 1, 'Em preparo'),   -- Carlos pediu 1 Pizza Broto
(4, 1, 1, 'Entregue'),     -- Ana Clara pediu 1 Hambúrguer
(4, 5, 1, 'Entregue'),     -- Ana Clara pediu 1 Suco Natural
(5, 6, 2, 'Recebido'),     -- Mateus pediu 2 Pudins
(6, 2, 2, 'Em preparo');   -- Fernanda pediu 2 Batatas Fritas

-- CONSULTA COM JOIN (Exibe o relatório completo)

-- 1
SELECT nome_prato, preco, categoria 
FROM cardapio 
WHERE categoria = 'Lanche' 
ORDER BY preco ASC;

-- 2
SELECT id_cliente, nome_cliente, telefone 
FROM clientes 
WHERE nome_cliente LIKE '%Silva%' OR nome_cliente LIKE 'M%';

-- 3
SELECT nome_prato, preco 
FROM cardapio 
WHERE preco BETWEEN 15.00 AND 30.00 
ORDER BY preco DESC;

-- 4
SELECT a.id_atendimento, c.nome_cliente, a.mesa, a.data_hora
FROM atendimentos a
INNER JOIN clientes c ON a.id_cliente = c.id_cliente;

-- 5
SELECT 
    p.id_pedido,
    a.mesa,
    c.nome_cliente,
    card.nome_prato,
    p.quantidade,
    p.status_prato
FROM pedidos p
INNER JOIN atendimentos a ON p.id_atendimento = a.id_atendimento
INNER JOIN clientes c ON a.id_cliente = c.id_cliente
INNER JOIN cardapio card ON p.id_cardapio = card.id_cardapio;

-- 6
SELECT 
    c.nome_cliente,
    SUM(p.quantidade * card.preco) AS total_gasto
FROM clientes c
INNER JOIN atendimentos a ON c.id_cliente = a.id_cliente
INNER JOIN pedidos p ON a.id_atendimento = p.id_atendimento
INNER JOIN cardapio card ON p.id_cardapio = card.id_cardapio
GROUP BY c.id_cliente, c.nome_cliente
ORDER BY total_gasto DESC;

-- 7
SELECT 
    card.categoria,
    COUNT(p.id_pedido) AS total_pedidos
FROM pedidos p
INNER JOIN cardapio card ON p.id_cardapio = card.id_cardapio
GROUP BY card.categoria
ORDER BY total_pedidos DESC;

-- 8
SELECT 
    categoria,
    AVG(preco) AS media_preco
FROM cardapio
GROUP BY categoria
HAVING media_preco > 15.00;

-- 9
SELECT a.id_atendimento, c.nome_cliente, a.mesa, a.data_hora
FROM atendimentos a
INNER JOIN clientes c ON a.id_cliente = c.id_cliente
WHERE a.data_hora BETWEEN '2026-03-01 18:00:00' AND '2026-03-01 23:59:59';

-- 10
SELECT 
    SUM(p.quantidade * card.preco) AS faturamento_entregue
FROM pedidos p
INNER JOIN cardapio card ON p.id_cardapio = card.id_cardapio
WHERE p.status_prato = 'Entregue';

-- 11
SELECT nome_ingrediente, quantidade_disponivel, unidade_medida
FROM estoque
WHERE quantidade_disponivel <= 20.00;

-- 12
SELECT 
    p.id_pedido,
    c.nome_cliente,
    a.mesa,
    p.quantidade,
    p.status_prato
FROM pedidos p
INNER JOIN cardapio card ON p.id_cardapio = card.id_cardapio
INNER JOIN atendimentos a ON p.id_atendimento = a.id_atendimento
INNER JOIN clientes c ON a.id_cliente = c.id_cliente
WHERE card.nome_prato LIKE '%Hambúrguer%';

-- 13
SELECT 
    card.nome_prato,
    SUM(p.quantidade) AS total_unidades_vendidas
FROM pedidos p
INNER JOIN cardapio card ON p.id_cardapio = card.id_cardapio
GROUP BY card.id_cardapio, card.nome_prato
ORDER BY total_unidades_vendidas DESC;

-- 14
SELECT 
    a.mesa,
    SUM(p.quantidade * card.preco) AS total_mesa
FROM atendimentos a
INNER JOIN pedidos p ON a.id_atendimento = p.id_atendimento
INNER JOIN cardapio card ON p.id_cardapio = card.id_cardapio
GROUP BY a.mesa
ORDER BY total_mesa DESC
LIMIT 1;

-- 15
SELECT 
    p.id_pedido,
    a.mesa,
    card.nome_prato,
    p.quantidade,
    p.status_prato,
    a.data_hora
FROM pedidos p
INNER JOIN atendimentos a ON p.id_atendimento = a.id_atendimento
INNER JOIN cardapio card ON p.id_cardapio = card.id_cardapio
WHERE p.status_prato IN ('Recebido', 'Em preparo')
ORDER BY a.data_hora ASC;