-- AVISO IMPORTANTE: Este projeto está em andamento <última atualização em 30/01/2025>

/*
Para resolver:
		
	- É necessário integrar compras e vendas com os estoques - Parcialmente resolvido. Fiz o trigger que integra pedido com estoque, agora falta fazer o trigger para compra.
    
    - o nome da tbl compra foi alterado, é necessário checar as chaves estrangeiras.
    
	- Ter terceiros vendendo pelo site implica em regras rígidas para o seu comportamento, já que sua falhas e infrações podem implicar em danos para a plataforma
	
    - Talvez fosse mais interessante criar os bancos de vendedores terceirizados como outro projeto, já que representam outro tipo de atividade para a plataforma
onde ela é mais uma mediadora, do que uma vendedora em si
    
    - Criar uma tabela endereco, na qual todos os endereços serão salvos e os tabelas que precisarem dessa informação buscarão nela através de FK.
    
    - Para pensar: se os terceiros criam um estoque próprio e manipulam ele. Onde em pedido eu posso acrescentar que a compra foi feita através de um terceiro?
*/

-- Fornecedor
CREATE TABLE fornecedor (
    idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    razaoSocial VARCHAR(45) NOT NULL,
    cnpj VARCHAR(18) NOT NULL UNIQUE
);

-- Produto (Combined for internal and third-party products)
CREATE TABLE produto (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    categoria ENUM('Eletrônico', 'Vestuário', 'Decoração', 'Coleção') NOT NULL,
    descricao VARCHAR(255),
    valor FLOAT NOT NULL CHECK (valor >= 0),
    tipo ENUM('Interno', 'Terceiro') NOT NULL DEFAULT 'Interno'
);

-- Compra (Normalized)
CREATE TABLE compra (
    idNotaCompra INT AUTO_INCREMENT PRIMARY KEY,
    idFornecedor INT NOT NULL,
    idProduto INT NOT NULL,
    qtProduto INT NOT NULL CHECK (qtProduto > 0),
    valorProduto FLOAT NOT NULL CHECK (valorProduto >= 0),
    CONSTRAINT fk_fornecedor FOREIGN KEY (idFornecedor) REFERENCES fornecedor(idFornecedor),
    CONSTRAINT fk_produto FOREIGN KEY (idProduto) REFERENCES produto(idProduto)
);

-- Estoque
CREATE TABLE estoque (
    idEstoque INT AUTO_INCREMENT PRIMARY KEY,
    rua VARCHAR(60) NOT NULL,
    numero VARCHAR(6) NOT NULL,
    bairro VARCHAR(30) NOT NULL,
    cep CHAR(9) NOT NULL,
    cidade VARCHAR(30) NOT NULL,
    estado ENUM(
        'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
    ) NOT NULL
);

-- TerceiroVendedor
CREATE TABLE terceiroVendedor (
    idTerceiro INT AUTO_INCREMENT PRIMARY KEY,
    razaoSocial VARCHAR(45) NOT NULL,
    rua VARCHAR(60) NOT NULL,
    numero VARCHAR(6) NOT NULL,
    bairro VARCHAR(30) NOT NULL,
    cep CHAR(9) NOT NULL,
    cidade VARCHAR(30) NOT NULL,
    estado ENUM(
        'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
    ) NOT NULL
);

-- Quantidade de Produtos por Vendedor
CREATE TABLE qtPorVendedor (
    idVendedor INT NOT NULL,
    idProduto INT NOT NULL,
    quantidadePorVendedor INT NOT NULL CHECK (quantidadePorVendedor >= 0),
    CONSTRAINT fk_vendedor FOREIGN KEY (idVendedor) REFERENCES terceiroVendedor(idTerceiro),
    CONSTRAINT fk_produto_vendedor FOREIGN KEY (idProduto) REFERENCES produto(idProduto),
    PRIMARY KEY (idVendedor, idProduto)
);

-- Cancelamento
CREATE TABLE cancelamento (
    idCancelamento INT AUTO_INCREMENT PRIMARY KEY,
    dataCancelamento DATE NOT NULL,
    descricaoCancelamento VARCHAR(255) NOT NULL
);

-- Cliente
CREATE TABLE cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    primeiroNome VARCHAR(20) NOT NULL,
    ultimoNome VARCHAR(20) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    CPF CHAR(11) UNIQUE,
    CNPJ CHAR(18) UNIQUE,
    CHECK (CPF IS NOT NULL OR CNPJ IS NOT NULL) -- Ensure either CPF or CNPJ is provided
);

-- Pedido
CREATE TABLE pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idProduto INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    statusPedido ENUM('Confirmado', 'Em separação', 'A caminho', 'Entregue') NOT NULL,
    idCancelamento INT,
    idEntrega INT,
    idPagamento INT,
    CONSTRAINT fk_produto_pedido FOREIGN KEY (idProduto) REFERENCES produto(idProduto),
    CONSTRAINT fk_cancelamento FOREIGN KEY (idCancelamento) REFERENCES cancelamento(idCancelamento),
    CONSTRAINT fk_entrega FOREIGN KEY (idEntrega) REFERENCES entrega(idEntrega),
    CONSTRAINT fk_pagamento FOREIGN KEY (idPagamento) REFERENCES formaPagamento(idFormaPagamento)
);

-- EstoqueProduto
CREATE TABLE estoqueProduto (
    idProduto INT NOT NULL,
    idEstoque INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade >= 0),
    CONSTRAINT fk_produto_estoque FOREIGN KEY (idProduto) REFERENCES produto(idProduto),
    CONSTRAINT fk_estoque FOREIGN KEY (idEstoque) REFERENCES estoque(idEstoque),
    PRIMARY KEY (idProduto, idEstoque)
);

-- Entrega
CREATE TABLE entrega (
    idEntrega INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL,
    codigoRastreamento INT NOT NULL UNIQUE,
    entregaRealizada ENUM('Entregue', 'A caminho', 'Segunda tentativa', 'Não realizada') NOT NULL,
    CONSTRAINT fk_pedido_entrega FOREIGN KEY (idPedido) REFERENCES pedido(idPedido)
);

-- Boleto
CREATE TABLE boleto (
    idBoleto INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL,
    numeroBoleto INT NOT NULL UNIQUE,
    dataEmissao DATE NOT NULL,
    vencimento DATE NOT NULL,
    confirmacaoPagamento ENUM('Pago', 'A Receber', 'Em atraso') NOT NULL,
    CONSTRAINT fk_pedido_boleto FOREIGN KEY (idPedido) REFERENCES pedido(idPedido)
);

-- Cartão de Crédito
CREATE TABLE cartao (
    idCartao INT AUTO_INCREMENT PRIMARY KEY,
    nomeTitular VARCHAR(60) NOT NULL,
    numeroCartao BIGINT NOT NULL UNIQUE,
    dataVencimento CHAR(7) NOT NULL,
    cpfTitular CHAR(11) NOT NULL
);

-- Forma de Pagamento
CREATE TABLE formaPagamento (
    idFormaPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    idCartao INT,
    idBoleto INT,
    CONSTRAINT fk_cliente_pagamento FOREIGN KEY (idCliente) REFERENCES cliente(idCliente),
    CONSTRAINT fk_cartao FOREIGN KEY (idCartao) REFERENCES cartao(idCartao),
    CONSTRAINT fk_boleto FOREIGN KEY (idBoleto) REFERENCES boleto(idBoleto)
);

-- Trigger que atualiza o estoque quando um pedido é feito
DELIMITER $$

CREATE TRIGGER after_pedido_insert
AFTER INSERT ON pedido
FOR EACH ROW
BEGIN
    DECLARE current_quantidade INT;

    -- Get current stock quantity
    SELECT quantidade INTO current_quantidade
    FROM estoqueProduto
    WHERE idProduto = NEW.idProduto;

    -- Check if product exists in stock
    IF current_quantidade IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Product not found in stock';
    END IF;

    -- Check if there is sufficient stock
    IF current_quantidade < NEW.quantidade THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock';
    END IF;

    -- Update stock
    UPDATE estoqueProduto
    SET quantidade = quantidade - NEW.quantidade
    WHERE idProduto = NEW.idProduto;
END$$

DELIMITER ;

-- Trigger que atualiza o estoque quando um pedido é feito
DELIMITER $$

CREATE TRIGGER after_compra_insert
AFTER INSERT ON pedido
FOR EACH ROW
BEGIN
    DECLARE current_quantidade INT;

    -- Get current stock quantity
    SELECT quantidade INTO current_quantidade
    FROM estoqueProduto
    WHERE idProduto = NEW.idProduto;

    -- Check if product exists in stock
    IF current_quantidade IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Product not found in stock';
    END IF;

    -- Check if there is sufficient stock
    IF current_quantidade < NEW.quantidade THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock';
    END IF;

    -- Update stock
    UPDATE estoqueProduto
    SET quantidade = quantidade - NEW.quantidade
    WHERE idProduto = NEW.idProduto;
END$$

DELIMITER ;