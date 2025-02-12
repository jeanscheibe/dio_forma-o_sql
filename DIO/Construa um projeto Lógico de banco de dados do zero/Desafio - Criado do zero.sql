create database agencia;

use agencia;

create table responsaveis(
id_responsavel int primary key auto_increment,
nome_responsavel varchar(30) not null,
sobrenome_responsavel varchar(30) not null,
cpf_responsavel varchar(14) not null,
endereco_responsavel int not null,
telefone_responsavel varchar(20) not null,
email_responsavel varchar(80) not null,
tipo enum ('Casa', 'Produtora', 'Artista')
);

create table enderecos(
id_endereco int primary key auto_increment,
rua varchar(80) not null,
número varchar(6) not null,
complemento varchar(255) not null,
bairro varchar(45) not null,
cidade varchar(45) not null,
estado enum("AC", "AP", "AM", "PA", "RO", "RR", "TO", "AL", "BA", "CE", "MA", "PB", "PE", "PI", "RN", "SE", "DF", "GO", "MT", "MS", "ES", "MG", "RJ", "SP", "PR", "RS", "SC"),
pais varchar(43)
);

create table artistas(
id_artista int primary key auto_increment,
nome_artista varchar(60) not null,
responsavel_artista int not null,
data_de_contratacao date not null,
valor_do_show decimal(10, 2) not null,
porcentagem_comissao decimal(5, 2),
constraint fk_responsavel_artista foreign key (responsavel_artista) references responsaveis(id_responsavel)
);


create table casas(
id_casa int primary key auto_increment,
cnpj_casa varchar(18) not null,
nome_casa varchar(80) not null,
endereco_casa int not null,
responsavel_casa int not null,
capacidade int not null,
tipo enum ('Teatro', 'Casa de show', 'Boate', 'Bar/Restaurante', 'Arena'),
constraint fk_endereco_casa foreign key (endereco_casa) references enderecos(id_endereco),
constraint fk_responsavel_casa foreign key (responsavel_casa) references responsaveis(id_responsavel)
);

create table produtoras(
id_produtora int primary key auto_increment,
nome_produtora varchar(80) not null,
cnpj_produtora varchar(18) not null, 
endereco_produtora int not null,
responsavel_produtora int not null,
constraint fk_endereco_produtora foreign key (endereco_produtora) references enderecos(id_endereco),
constraint fk_responsavel_produtora foreign key (responsavel_produtora) references responsaveis(id_responsavel)
);

create table vendas(
id_venda int primary key auto_increment,
artista_venda int not null,
casa int not null,
formato enum ('Acústico', 'Banda', 'Playback', 'DJ'),
valor_venda decimal(10, 2) not null,
desconto decimal(5, 2) not null,
porcentagem_comissão decimal(5, 2) not null,
comissao decimal(10,2) GENERATED ALWAYS AS ((valor_venda - desconto) * (porcentagem_comissão / 100)) STORED,
data_venda date not null,
constraint fk_venda_artista foreign key (artista_venda) references artistas(id_artista)
);

-- inserts 

INSERT INTO enderecos (rua, número, complemento, bairro, cidade, estado, pais) VALUES
('Rua das Flores', '123', 'Apto 101', 'Centro', 'São Paulo', 'SP', 'Brasil'),
('Avenida Brasil', '456', '', 'Jardins', 'Rio de Janeiro', 'RJ', 'Brasil'),
('Rua do Sol', '789', 'Próximo ao teatro', 'Boa Vista', 'Recife', 'PE', 'Brasil'),
('Travessa da Paz', '321', '', 'Liberdade', 'Salvador', 'BA', 'Brasil'),
('Rua do Comércio', '654', '', 'Centro', 'Curitiba', 'PR', 'Brasil');

INSERT INTO responsaveis (nome_responsavel, sobrenome_responsavel, cpf_responsavel, endereco_responsavel, telefone_responsavel, email_responsavel, tipo) VALUES
('Carlos', 'Silva', '123.456.789-00', 1, '(11) 99999-0000', 'carlos@email.com', 'Casa'),
('Ana', 'Moura', '234.567.890-11', 2, '(21) 98888-1111', 'ana@email.com', 'Produtora'),
('Rafael', 'Lima', '345.678.901-22', 3, '(81) 97777-2222', 'rafael@email.com', 'Artista'),
('Juliana', 'Souza', '456.789.012-33', 4, '(71) 96666-3333', 'juliana@email.com', 'Casa'),
('Eduardo', 'Fernandes', '567.890.123-44', 5, '(41) 95555-4444', 'eduardo@email.com', 'Produtora');

INSERT INTO artistas (nome_artista, responsavel_artista, data_de_contratacao, valor_do_show, porcentagem_comissao) VALUES
('Bandão Azul', 3, '2022-01-15', 50000.00, 10.0),
('Munição Floral', 3, '2022-02-20', 60000.00, 12.0),
('Neili e Neilerei', 3, '2023-03-10', 40000.00, 8.0),
('Ruan Castro e banda', 3, '2023-04-05', 55000.00, 15.0),
('Kay', 3, '2023-05-18', 45000.00, 10.0),
('Breno', 3, '2023-06-25', 35000.00, 9.0);

INSERT INTO casas (cnpj_casa, nome_casa, endereco_casa, responsavel_casa, capacidade, tipo) VALUES
('00.111.222/0001-33', 'Arena Music', 1, 1, 10000, 'Arena'),
('11.222.333/0001-44', 'Palácio das Artes', 2, 4, 3000, 'Teatro'),
('22.333.444/0001-55', 'Espaço das Américas', 3, 1, 8000, 'Casa de show'),
('33.444.555/0001-66', 'Vibra Hall', 4, 4, 5000, 'Boate'),
('44.555.666/0001-77', 'Teatro Municipal', 5, 1, 2000, 'Teatro');

INSERT INTO produtoras (nome_produtora, cnpj_produtora, endereco_produtora, responsavel_produtora) VALUES
('J10 Produção de eventos', '55.666.777/0001-88', 1, 2),
('Zion Produções', '66.777.888/0001-99', 2, 5),
('Tiãozin Eventos', '77.888.999/0001-00', 3, 2),
('EV Produções', '88.999.000/0001-11', 4, 5),
('Nova Geração Gospel', '99.000.111/0001-22', 5, 2);

-- Inserindo 100 registros na tabela vendas com valores aleatórios e data_venda no intervalo de 01/01/2024 a 31/12/2024
INSERT INTO vendas (artista_venda, casa, formato, valor_venda, desconto, porcentagem_comissão, data_venda)
SELECT 
    t1.artista_venda,  -- Escolhe um artista aleatório (ID 1-6)
    FLOOR(1 + (RAND() * 14)), -- Escolhe uma casa aleatória (ID 1-14)
    ELT(FLOOR(1 + (RAND() * 4)), 'Acústico', 'Banda', 'Playback', 'DJ'),  -- Escolhe formato aleatório
    a.valor_do_show,  -- Valor do show retirado da tabela artistas
    ROUND(FLOOR(5 + (RAND() * 6)), 2), -- Desconto entre 5% e 10%
    a.porcentagem_comissao,  -- Porcentagem de comissão retirada da tabela artistas
    -- Gera data aleatória entre 01/01/2024 e 31/12/2024
    DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND() * 365) DAY) AS data_venda  -- Gera data aleatória dentro de 2024
FROM 
    (SELECT 1 AS artista_venda UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 
     UNION SELECT 6) t1  -- Apenas os IDs dos artistas disponíveis
CROSS JOIN 
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
     UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t2  -- Expande para mais registros
JOIN artistas a ON a.id_artista = t1.artista_venda  -- Garantindo que os valores vêm da tabela artistas
LIMIT 100;

-- --------------------------- consultas

select * from artistas;

select * from responsaveis;

-- Faturamento total da empresa
SELECT 
    SUM(valor_venda) AS faturamento_total
FROM 
    vendas;

-- Quanto cada artista vendeu mais em 2024?
SELECT 
    a.nome_artista, 
    SUM(v.valor_venda) AS total_vendido_2024
FROM 
    vendas v
JOIN 
    artistas a ON v.artista_venda = a.id_artista
WHERE 
    YEAR(v.data_venda) = 2024
GROUP BY 
    a.nome_artista
HAVING 
    total_vendido_2024 > 0  -- Apenas artistas com vendas
ORDER BY 
    total_vendido_2024 DESC;
    
-- Quanto cada artista vendeu mais por mês?
SELECT 
    a.nome_artista,
    CONCAT(YEAR(v.data_venda), '-', LPAD(MONTH(v.data_venda), 2, '0')) AS mes_ano, 
    SUM(v.valor_venda) AS total_vendido
FROM 
    vendas v
JOIN 
    artistas a ON v.artista_venda = a.id_artista
GROUP BY 
    a.nome_artista, mes_ano
HAVING 
    total_vendido > 0  -- Apenas meses com vendas
ORDER BY 
    mes_ano DESC, total_vendido DESC;

-- Qual artista vendeu mais?
SELECT 
    a.nome_artista, 
    SUM(v.valor_venda) AS total_vendido
FROM 
    vendas v
JOIN 
    artistas a ON v.artista_venda = a.id_artista
GROUP BY 
    a.nome_artista
HAVING 
    total_vendido > 0
ORDER BY 
    total_vendido DESC
LIMIT 1;



-- Qual casa mais contratou?
SELECT 
    c.nome_casa,
    COUNT(v.id_venda) AS total_contratacoes
FROM 
    vendas v
JOIN 
    casas c ON v.casa = c.id_casa
GROUP BY 
    c.nome_casa
HAVING 
    total_contratacoes > 0
ORDER BY 
    total_contratacoes DESC
LIMIT 1;


-- Lista dos reponsaveis por produtoras
SELECT 
    r.nome_responsavel, 
    r.sobrenome_responsavel,
    p.nome_produtora
FROM 
    produtoras p
JOIN 
    responsaveis r ON p.responsavel_produtora = r.id_responsavel
ORDER BY 
    p.nome_produtora;

-- Receita total por casa de show
SELECT 
    c.nome_casa, 
    SUM(v.valor_venda) AS faturamento_total
FROM 
    vendas v
JOIN 
    casas c ON v.casa = c.id_casa
GROUP BY 
    c.nome_casa
HAVING 
    faturamento_total > 0
ORDER BY 
    faturamento_total DESC;

-- Receita total por produtora
SELECT 
    p.nome_produtora, 
    SUM(v.valor_venda) AS faturamento_total
FROM 
    vendas v
JOIN 
    artistas a ON v.artista_venda = a.id_artista
JOIN 
    produtoras p ON a.produtora = p.id_produtora
GROUP BY 
    p.nome_produtora
HAVING 
    faturamento_total > 0
ORDER BY 
    faturamento_total DESC;

-- Artistas que venderam acima da média
SELECT 
    a.nome_artista,
    SUM(v.valor_venda) AS total_vendido
FROM 
    vendas v
JOIN 
    artistas a ON v.artista_venda = a.id_artista
GROUP BY 
    a.nome_artista
HAVING 
    total_vendido > (SELECT AVG(valor_venda) FROM vendas)
ORDER BY 
    total_vendido DESC;

