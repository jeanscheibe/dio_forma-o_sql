-- AVISO IMPORTANTE: Este projeto está em andamento <última atualização em 28/01/2025>

/*
Nesse primeiro projeto percebi alguns desafios a serem resolvidos:
		
	1 - É necessário integrar compras e vendas com os estoques
	2 - Ter terceiros vendendo pelo site implica em regras rígidas para o seu comportamento, já que sua falhas e infrações podem implicar em danos para a plataforma
	3 - Talvez fosse mais interessante criar os bancos de vendedores terceirizados como outro projeto, já que representam outro tipo de atividade para a plataforma
onde ela é mais uma mediadora, do que uma vendedora em si
	4 - É necessário integrar compras e vendas com o estoque associado
*/

create database ecommerce_desafio;
use ecommerce_desafio;

-- fornecedor
create table fornecedor(
	idFornecedor int auto_increment primary key,
    razaoSocial varchar(45),
    cnpj varchar(18)
);

insert into fornecedor (razaoSocial, cnpj)
values
	('Eletrônicos Filosofais', '00.000.000/000-00'),
    ('Moda Secreta', '11.111.111/111-11'),
    ('Azkaban Deco', '22.222.222/222-22'),
    ('Colecionáveis Cálice', '33.333.333/33-33'),
    ('Fênix Produtos Eletrônicos', '44.444.444/444-44');
    
-- produto
create table produto (
	idProduto int auto_increment primary key,
    nome varchar(80),
    categoria enum('Eletrônico', 'Vestuário', 'Decoração', 'Coleção') not null,
    descricao varchar(255),
    valor float not null
);

insert into produto (nome, categoria, descricao, valor)
values
	('Celular Fotonola - F1', 'Eletrônico', '128g, 32G ram, câmera 5mpx', 1280.99),
    ('Mouse FracWars', 'Eletrônico', '7200dpi', 90.00),
    ('Calça Urubici', 'Vestuário', 'Calça para inverno', 150.39),
    ('Óculos Oncinha', 'Vestuário', 'Óculos com estampa de oncinha', 49.90),
    ('Quadro França na chuva', 'Decoração', 'Quadro horizontal com 60cm x 25cm com ilustração impressa do centro de Paris na chuva', 48.99),
    ('Imã de geladeira Henry Dotter', 'Decoração', 'Imã de geladeira com 7cm de altura no formato do personagem Henry Dotter', 15.99),
    ('Carta Pokémon Charizard', 'Coleção', 'Carta rara do Pokémon Charizard', 600.000),
    ('Moeda PMCE', 'Coleção', 'Moeda Colecionáel da Polícia Militar do Estado do Ceará', 119.90);

-- disponibiliza
create table compraFornecedor(
	idNotaCompra int auto_increment primary key,
	idCompraFornecedor int not null,
    nomeProduto varchar(100) not null,
    qtProduto int not null,
    valorProduto float not null,
	constraint fk_fornecedor_produto foreign key (idCompraFornecedor) references fornecedor(idFornecedor)
);

insert into compraFornecedor (idCompraFornecedor, nomeProduto, qtProduto, valorProduto)
values 
	(1, 'Celular Fotonola - F1', 5, 800.00),
    (5, 'Mouse FracWars', 15, 50.99),
    (2, 'Óculos Oncinha', 20, 49.90),
    (2, 'Calça Urubici', 60, 150.39),
    (3, 'Quadro França na chuva', 5, 20.00),
    (3, 'Imã de geladeira Henry Dotter', 150, 8.59),
    (4, 'Carta Pokémon Charizard', 1, 350000.00),
    (4, 'Moeda PMCE', 15, 60.00);

-- estoque
create table estoque(
	idEstoque int auto_increment primary key,
    rua varchar(60) not null,
    numero varchar(6) not null,
    bairro varchar(30) not null,
    cep char(9) not null,
    cidade varchar(30) not null,
     estado ENUM(
        'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA',
        'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN',
        'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
    ) not null
);

insert into estoque (rua, numero, bairro, cidade, estado, pais)
values
	('Rua José Silva', '38', 'Divineia', '88888-888', 'São Paulo', 'SP'),
    ('Rua João Souza', '83', 'São Luis', '88999-999', 'Criciúma', 'SC'),
    ('Rua Tião Mezanquin', '833', 'Santo Antônio', '88111-111', 'Recife', 'PE');

-- terceiro-vendedor
create table terceiroVendedor(
	idTerceiro int auto_increment primary key,
    razaoSocial varchar(45) not null,
	rua varchar(60) not null,
    numero varchar(6) not null,
    bairro varchar(30) not null,
    cep char(9) not null,
    cidade varchar(30) not null,
	estado ENUM(
        'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA',
        'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN',
        'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
    ) not null
);

insert into terceiroVendedor(razaoSocial, rua, numero, bairro, cidade, estado, pais)
values
	('Peralta Distribuidora', 'Rua Harmonia', '251', 'Distrito Hercílio Luz', 'Araranguá', 'SC', 'Brasil'),
    ('Santiago Comércio LTDA', 'Avenida Jacó', '456', 'Brooklyn', 'Rio de Janeiro', 'RJ', 'Brasil'),
    ('Fashion Boyle', 'Travessa Ane Feliz', '789', 'Vila Rosa', 'São Paulo', 'SP', 'Brasil'),
    ('Rosa Jogos e quadrinhos', 'Estrada das Rosas', '321', 'Jardim Central', 'Curitiba', 'PR', 'Brasil'),
    ('Terry Super Suplementos', 'Alameda Jeferson', '654', 'Boa Forma', 'Fortaleza', 'CE', 'Brasil');

create table produtoTerceiroVendedor (
	idProdutoTerceiroVendedor int auto_increment primary key,
    nome varchar(80),
    categoria enum('Eletrônico', 'Vestuário', 'Decoração', 'Coleção') not null,
    descricao varchar(255),
    valor float not null
);

insert into produtoTerceiroVendedor(nome, categoria, descricao, valor)
values
    ('Console retrô Mini NES', 'Eletrônico', 'Réplica compacta do clássico console Nintendo, com 30 jogos pré-instalados.', 299.90),
    ('Tênis esportivo personalizado', 'Vestuário', 'Tênis customizado com design exclusivo e materiais de alta qualidade.', 399.00),
	('Quadro neon "Keep Calm" ', 'Decoração', 'Quadro neon com a frase "Keep Calm and Carry On" em moldura de metal.', 199.99),
    ('Vinil Pink Floyd - The Dark Side of the Moon', 'Coleção', 'Edição especial em vinil do álbum clássico do Pink Floyd.', 150.00),
    ('Smartwatch feminino com pulseira de couro', 'Eletrônico', 'Relógio inteligente com monitoramento de saúde e design elegante.', 329.99),
	('Vestido midi floral', 'Vestuário', 'Vestido midi leve e confortável, com estampa floral vibrante.', 199.90),
    ('Kit de jardinagem para iniciantes', 'Decoração', 'Kit completo com ferramentas e sementes para cultivar suas próprias plantas.', 79.99),
	('Boneco de Two Pieces edição limitada', 'Coleção', 'Boneco de ação articulado de personagem de anime, edição limitada.', 129.99);

-- produtos por vendedor
create table qtPorVendedor(
	idVendedor int not null,
    idProdutoVendedor int not null,
    quantidadePorVendedor int not null,
    constraint fk_vendedor_id foreign key (idVendedor) references terceiro_vendedor(idTerceiro),
    constraint fk_vendedor_produto foreign key (idProdutoVendedor) references produtoTerceiroVendedor(idProdutoTerceiroVendedor)
);

insert into qtPorVendedor(idVendedor, idProdutoVendedor)
values
	(1, 2, 50),
    (2, 3, 100),
    (3, 6, 50),
    (4, 1, 60),
    (5, 8, 30),
    (2, 5, 50),
    (5, 4, 5),
    (2, 7, 15);

-- cancelamento
create table cancelamento(
	idCancelamento int auto_increment primary key,
    dataCancelamento date not null,
    descricaoCancelamento varchar(255) not null    
);

insert into cancelamento (dataCancelamento, descricaoCancelamento) 
values
    ('2025-01-25', 'Pedido duplicado pelo sistema');

-- cliente
create table cliente(
	idCliente int auto_increment primary key,
    primeiroNome varchar(20) not null,
    ultimoNome varchar(20)not null,
    endereco varchar(100) not null,
    CPF char(11) not null,
    CNPJ char(18)
);

INSERT INTO cliente (primeiroNome, ultimoNome, endereco, CPF, CNPJ) 
VALUES
    ('João', 'Silva', 'Rua das Flores, 100, Centro, São Paulo - SP', '12345678901', NULL),
    ('Maria', 'Oliveira', 'Avenida Brasil, 500, Jardim das Palmeiras, Recife - PE', '98765432100', NULL),
    ('José', 'Santos', 'Estrada Velha, 10, Santo Antônio, Belo Horizonte - MG', '11223344556', '99.999.999/0001-99'),
    ('Ana', 'Souza', 'Rua da Paz, 75, Boa Vista, Porto Alegre - RS', '22334455667', NULL),
    ('Pedro', 'Almeida', 'Avenida Principal, 900, Fortaleza - CE', '33445566778', '88.888.888/0001-88');

-- pedido
create table pedido(
	idPedido int auto_increment primary key,
    idProdutoPedido int,
    quantidade int not null,
    statusPedido enum('Confirmado', 'Em separação', 'A caminho', 'Entregue'),
        idCancelamentoPedido int,
    idEntregaProduto int,
    idPagamentoPedido int,
    constraint fk_produto_pedido foreign key (idProdutoPedido) references produto (idProduto),
    constraint fk_cancelamento_pedido foreign key (idCancelamentoPedido) references cancelamento(idCancelamento),
    constraint fk_entrega_produto foreign key (idEntregaProduto) references entrega(idEntrega),
    constraint fk_pagamento_pedido foreign key (idPagamentoPedido) references FormaPagamento(idFormaPagamento)
);

insert into pedido (idProdutoPedido, quantidade, statusPedido, idCancelamentoPedido, idEntregaProduto, idPagamentoPedido) 
values
    (1, 1, 'Entregue', null, 1, 1),
    (2, 2, 'Confirmado', null, 2, 2),
    (3, 4, 'A caminho', null, 3, 3),
    (4, 2, 'Cancelado', 1, null, null),
    (5, 2, 'Confirmado', null, 4, 4);

-- inserir estoque de produtos
-- estoque de produto
create table estoqueProduto(
	idProdutoEmEstoque int not null,
    idEstEstoque int not null,
    quantidade int not null,
    constraint fk_produto_em_estoque foreign key (idProdutoEmEstoque) references produto(idProduto),
	constraint fk_local_estoque foreign key (idEstEstoque) references estoque(idEstoque)
);

insert into estoqueProduto(idProdutoEmEstoque, idEstEstoque, quantidade) 
values
	(1, 2, 4),
    (2, 1, 13),
    (3, 2, 16),
    (4, 2, 60),
    (5, 1, 3),
    (6, 1, 150),
    (7, 3, 1),
    (8, 3, 15);
-- entrega
create table entrega(
	idEntrega int auto_increment primary key,
    idEntregaPedido int not null,
    codigoRastreamento int not null,
    entregaRealizada enum('Entregue', 'A caminho', 'Segunda tentativa', 'Não realizada'),
    constraint fk_entrega_pedido foreign key (idEntregaPedido) references pedido (idPedido)
);

INSERT INTO entrega (codigoRastreamento, entregaRealizada) 
VALUES
    (1001, 1, 'Entregue'),
    (1002, 2, 'A caminho'),
    (1003, 3, 'Segunda tentativa'),
    (1004, 4, 'Não realizada'),
    (1005, 5, 'A caminho');

-- boleto
create table boleto(
	idBoleto int auto_increment primary key,
    idBoletoPedido int not null,
    numeroBoleto int not null,
    dataEmissao date not null,
    vencimento date not null,
    confirmacaoPagamento enum('Pago', 'A Receber', 'Em atraso'),
    constraint fk_boleto_pedido foreign key (idBoletoPedido) references pedido(idBoletoPedido)
);

insert into boleto (idBoletoPedido, numeroBoleto, dataEmissao, vencimento, confirmacaoPagamento) 
values
    (1, 1010101, '2025-01-01', '2025-01-15', 'Pago'),
    (2, 1010102, '2025-01-05', '2025-01-20', 'A Receber');


-- cartão de crédito
create table cartao(
	idCartao int auto_increment primary key,
    nomeTitular varchar(60) not null,
    numeroCartao int not null,
    dataVencimento int not null,
    cpfTitular char(11) not null
);

insert into cartao (nomeTitular, numeroCartao, dataVencimento, cpfTitular) 
values
    ('João Silva', 1111222233334444, 0125, '12345678901'),
    ('Maria Oliveira', 5555666677778888, 0325, '98765432100'),
    ('José Santos', 9999000011112222, 0425, '11223344556'),
    ('Ana Souza', 3333444455556666, 0525, '22334455667'),
    ('Pedro Almeida', 7777888899990000, 0625, '33445566778');

-- forma de pagamento
create table formaPagamento(
	idFormaPagamento int auto_increment primary key,
    idPagCliente int,
    idPagCartao int,
    idPagBoleto int,
    constraint fk_cliente_pagamento foreign key (idPagCliente) references cliente(idCliente),
    constraint fk_pagamento_cartão foreign key (idPagCartao) references cartao(idCartao),
    constraint fk_pagamento_boleto foreign key (idPagBoleto) references boleto(idBoleto)
);

insert into formaPagamento (idPagCliente, idPagCartao, idPagBoleto) 
values
    (1, null, 1),
    (2, null, 2),
    (3, 3, null),
    (4, 4, null),
    (5, 5, null);