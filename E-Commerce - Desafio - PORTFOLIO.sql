-- AVISO IMPORTANTE: Este projeto está em andamento <última atualização em 25/01/2025>

create database ecommerce_desafio;
use ecommerce_desafio;

-- fornecedor
create table fornecedor(
	idFornecedor int auto_increment primary key,
    razaoSocial varchar(45),
    cnpj varchar(18)
);

insert into fornecedor (razaoSocial, cnpj) values
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

insert into produto (nome, categoria, descricao, valor) values
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

insert into compraFornecedor (idCompraFornecedor, nomeProduto, qtProduto, valorProduto)values (
	(1, 'Celular Fotonola - F1', 5, 800.00),
    (5, 'Mouse FracWars', 15, 50.99),
    (2, 'Óculos Oncinha', 20, 49.90),
    (2, 'Calça Urubici', 60, 150.39),
    (3, 'Quadro França na chuva', 5, 20.00),
    (3, 'Imã de geladeira Henry Dotter', 150, 8.59),
    (4, 'Carta Pokémon Charizard', 1, 350000.00),
    (4, 'Moeda PMCE', 15, 60.00)
);

-- estoque
create table estoque(
	idEstoque int auto_increment primary key,
    localizacao varchar(45)
);

-- estoque de produto
create table estoqueProduto(
	idEstProduto int auto_increment primary key,
    idEstEstoque int,
    quantidade int not null,
    constraint fk_produto_em_estoque foreign key (idEstProduto) references produto (idProduto),
	constraint fk_local_estoque foreign key (idEstEstoque) references estoque (idEstoque)
);

-- terceiro-vendedor
create table terceiro_vendedor(
	idTerceiro int auto_increment primary key,
    razaoSocial varchar(45) not null,
    localizacao varchar(30)
);

-- produtos por vendedor
create table qtPorVendedor(
    idQtVendedor int auto_increment primary key,
    idProdutoVendedor int not null,
    idVendedor int not null,
    quantidadePorVendedor int not null,
    constraint fk_vendedor_id foreign key (idVendedor) references terceiro_vendedor(idTerceiro),
    constraint fk_vendedor_produto foreign key (idProdutoVendedor) references produto(idProduto)
);

-- cancelamento
create table cancelamento(
	idCancelamento int auto_increment primary key,
    dataCancelamento date not null,
    descricaoCancelamento varchar(255) not null    
);

-- cliente
create table cliente(
	idCliente int auto_increment primary key,
    primeiroNome varchar(20) not null,
    ultimoNome varchar(20)not null,
    endereco varchar(100) not null,
    CPF char(11) not null,
    CNPJ char(18)
);

-- entrega
create table entrega(
	idEntrega int auto_increment primary key,
    codigoRastreamento int not null,
    entregaRealizada enum('Entregue', 'A caminho', 'Segunda tentativa', 'Não realizada')
);

-- boleto
create table boleto(
	idBoleto int auto_increment primary key,
    numeroBoleto int not null,
    dataEmissao date not null,
    vencimento date not null,
    confirmacaoPagamento enum('Pago', 'A Receber', 'Em atraso')
);

-- cartão de crédito
create table cartao(
	idCartao int auto_increment primary key,
    nomeTitular varchar(60) not null,
    numeroCartao int not null,
    dataVencimento int not null,
    cpfTitular char(11) not null
);

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

-- pedido
create table pedido(
	idPedido int auto_increment primary key,
    idProdutoPedido int,
    statusPedido enum('Confirmado', 'Em separação', 'A caminho', 'Entregue'),
    descricao varchar(255),
    idCancelamentoPedido int,
    idEntregaProduto int,
    idPagamentoPedido int,
    constraint fk_produto_pedido foreign key (idProdutoPedido) references produto (idProduto),
    constraint fk_cancelamento_pedido foreign key (idCancelamentoPedido) references cancelamento(idCancelamento),
    constraint fk_entrega_produto foreign key (idEntregaProduto) references entrega(idEntrega),
    constraint fk_pagamento_pedido foreign key (idPagamentoPedido) references FormaPagamento(idFormaPagamento)
);

-- Entradas



insert into  ();
insert into  ();
insert into  ();
insert into  ();
insert into  ();
insert into  ();
insert into  ();
insert into  ();
insert into  ();
