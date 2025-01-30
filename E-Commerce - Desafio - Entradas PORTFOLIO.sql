use ecommerce_desafio;

insert into fornecedor (razaoSocial, cnpj)
values
	('Eletrônicos Filosofais', '00.000.000/000-00'),
    ('Moda Secreta', '11.111.111/111-11'),
    ('Azkaban Deco', '22.222.222/222-22'),
    ('Colecionáveis Cálice', '33.333.333/33-33'),
    ('Fênix Produtos Eletrônicos', '44.444.444/444-44');

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
    
insert into estoque (rua, numero, bairro, cidade, estado, pais)
values
	('Rua José Silva', '38', 'Divineia', '88888-888', 'São Paulo', 'SP'),
    ('Rua João Souza', '83', 'São Luis', '88999-999', 'Criciúma', 'SC'),
    ('Rua Tião Mezanquin', '833', 'Santo Antônio', '88111-111', 'Recife', 'PE');
    
-- terceiroVendedor
insert into terceiroVendedor(razaoSocial, rua, numero, bairro, cidade, estado, cep)
values 
    ('Peralta Distribuidora', 'Rua Harmonia', '251', 'Distrito Hercílio Luz', 'Araranguá', 'SC', '88900000'),
    ('Santiago Comércio LTDA', 'Avenida Jacó', '456', 'Brooklyn', 'Rio de Janeiro', 'RJ', '22000000'),
    ('Fashion Boyle', 'Travessa Ane Feliz', '789', 'Vila Rosa', 'São Paulo', 'SP', '01000000'),
    ('Rosa Jogos e quadrinhos', 'Estrada das Rosas', '321', 'Jardim Central', 'Curitiba', 'PR', '80000000'),
    ('Terry Super Suplementos', 'Alameda Jeferson', '654', 'Boa Forma', 'Fortaleza', 'CE', '60000000');

-- produtoTerceiroVendedor
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

-- qtPorVendedor
insert into qtPorVendedor(idVendedor, idProdutoVendedor, quantidadePorVendedor)
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
insert into cancelamento (dataCancelamento, descricaoCancelamento)
values 
    ('2025-01-25', 'Pedido duplicado pelo sistema');

-- cliente
INSERT INTO cliente (primeiroNome, ultimoNome, endereco, CPF, CNPJ)
VALUES 
    ('João', 'Silva', 'Rua das Flores, 100, Centro, São Paulo - SP', '12345678901', NULL),
    ('Maria', 'Oliveira', 'Avenida Brasil, 500, Jardim das Palmeiras, Recife - PE', '98765432100', NULL),
    ('José', 'Santos', 'Estrada Velha, 10, Santo Antônio, Belo Horizonte - MG', '11223344556', '99.999.999/0001-99'),
    ('Ana', 'Souza', 'Rua da Paz, 75, Boa Vista, Porto Alegre - RS', '22334455667', NULL),
    ('Pedro', 'Almeida', 'Avenida Principal, 900, Fortaleza - CE', '33445566778', '88.888.888/0001-88');

-- pedido
insert into pedido (idProdutoPedido, quantidade, statusPedido, idCancelamentoPedido, idEntregaProduto, idPagamentoPedido)
values 
    (1, 1, 'Entregue', null, 1, 1),
    (2, 2, 'Confirmado', null, 2, 2),
    (3, 4, 'A caminho', null, 3, 3),
    (4, 2, 'Cancelado', 1, null, null),
    (5, 2, 'Confirmado', null, 4, 4);

-- estoqueProduto
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
INSERT INTO entrega (idEntregaPedido, codigoRastreamento, entregaRealizada)
VALUES 
    (1, 1001, 'Entregue'),
    (2, 1002, 'A caminho'),
    (3, 1003, 'Segunda tentativa'),
    (4, 1004, 'Não realizada'),
    (5, 1005, 'A caminho');

-- boleto
insert into boleto (idBoletoPedido, numeroBoleto, dataEmissao, vencimento, confirmacaoPagamento)
values 
    (1, 1010101, '2025-01-01', '2025-01-15', 'Pago'),
    (2, 1010102, '2025-01-05', '2025-01-20', 'A Receber');

-- cartao
insert into cartao (nomeTitular, numeroCartao, dataVencimento, cpfTitular)
values 
    ('João Silva', 1111222233334444, 0125, '12345678901'),
    ('Maria Oliveira', 5555666677778888, 0325, '98765432100'),
    ('José Santos', 9999000011112222, 0425, '11223344556'),
    ('Ana Souza', 3333444455556666, 0525, '22334455667'),
    ('Pedro Almeida', 7777888899990000, 0625, '33445566778');

-- formaPagamento
insert into formaPagamento (idPagCliente, idPagCartao, idPagBoleto)
values 
    (1, null, 1),
    (2, null, 2),
    (3, 3, null),
    (4, 4, null),
    (5, 5, null);