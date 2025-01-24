-- criação do banco de dados para o coneário de ecommerce

create database ecommerce;
use ecommerce;

-- criar tabela client
create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(60),
    constraint unique_cpf_client unique (CPF)
);

-- criar tabela produto
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(25),
    Classification_kids bool default false,
    category enum('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
    avaliação float default 0,
    size varchar(10)
);

-- criar tabela pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
		on update cascade
);

-- termine de implementar a tabela e crie a conexão com as tabelas necessárias
-- reflita as modificações no esquema relacional
create table payments(
	idClient int,
    idPayment int,
    typePayment enum('Boleto', 'Cartão', 'Dois cartões'),
    limitAvailable float,
    primary key (idClient, idPayment),
    constraint fk_client_payment foreign key (idClient) references clients(idClient),
    constraint fk_order_payment foreign key (idPayment) references orders(idOrder)
);
-- criar tabela estoque
create table productStorage (
	idProdStorage int auto_increment primary key,
    storageLocation varchar (255),
    quantity int default 0
);

-- criar tabela fornecedor
create table supplier(
idSupplier int auto_increment primary key,
SocialName varchar(255) not null,
CNPJ char(15) not null,
contact char(11) not null,
constraint unique_supplier unique (CNPJ)
);

-- criar tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15),
    CPF char(11),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

-- criar tabela productSeller
create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_product foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_seller foreign key (idPOorder) references orders(idOrder)
);

create table  storageLocation(
	idLProduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_locatoin_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

show tables;

show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = "ecommerce";
use ecommerce;

insert into clients (Fname, Minit, Lname, CPF, Address)
	values('Maria', 'M', 'Silva', 123456789, 'Rua Silva de Prata 29, Carangola - Cidade das Flores'),
		  ('Matheus', 'O', 'Pimentel', 987654321, 'Rua Alameda 289, Centro - Cidade das Flores'),
          ('Ricardo', 'F', 'Silva', 456789123, 'Avenida Alameda Vinha 1009, Centro - Cidade das Flores'),
          ('Julia', 'S', 'França', 789123456, 'Rua Laranjeiras 861, Centro - Cidade das Flores'),
          ('Roberta', 'G', 'Assis', 987456321, 'Avenida Alameda Vinha 1009, Centro - Cidade das Flores'),
          ('Isabela', 'M', 'Cruz', 654789123, 'Rua Alameda da Flores 28, Centro - Cidade das Flores');

-- idProduct, pName, classification_kids boolean, category enum('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis'), avalização, size
insert into product (Pname, classification_kids, category, avaliação, size) values
						('Fone de ouvido', false, 'Eletrônico', '4', null),
                        ('Barbie Elsa', true, 'Brinquedos', '3', null),
                        ('Body Carters', true, 'Vestimenta', '5', null),
                        ('Microfone Vedo - Youtuber', false, 'Eletrônico', '4', null),
                        ('Sofá retrátil', false, 'Móveis', '3', '3x57x80'),
                        ('Farinha de arroz', false, 'Alimentos', '2', null),
                        ('Fire Stick Amazon', false, 'Eletrônico', '3', null);
                        
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
							(1, default, 'compra via aplicativo', null, 1),
                            (2, default, 'compra via aplicativo', 50, 0),
                            (3, 'Confirmado', null, null, 1),
                            (4, default, 'compra via web site', 150, 0);
                            
-- idPOproduct, idPOorder, poQuantity, poStatus
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
								(1, 1, 2, null),
                                (2, 1, 1, null),
                                (3, 2, 1, null);
                                
-- storageLocation, quantity
insert into productStorage (storageLocation, quantity) values
								('Rio de Janeiro', 1000),
                                ('Rio de Janeiro', 500),
                                ('São Paulo', 10),
                                ('São Paulo', 1000),
                                ('São Paulo', 10),
                                ('Brasília', 60);

-- idLproduct, idLstorage, location
insert into storageLocation (idLproduct, idLstorage, location) values
					(1, 2, 'RJ'),
                    (2 , 6, 'GO');

-- idPsSupplier, SocialName, CNPJ, contact
insert into supplier (SocialName, CNPJ, contact) values
		('Almeida e filhos', 123456789123456, '21985474'),
        ('Eletrônicos Silva', 854519649143457, '21895484'),
        ('Eletrônicos Valma', 934567893934695, '21975474');

-- idPsSupplier, idPsProduct, quantity
insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
				(1 ,1 ,500),
                (1 ,2, 400),
                (2, 4, 633),
                (3, 3, 5),
                (2 ,5 ,10);
                
-- idSeller, SocialName, AbstName, CPF, Location, contact
insert into seller (SocialName, AbstName, CNPJ, CPF, Location, contact) values
			('Tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', 219946287),
            ('Botique Durgas', null, null, 123456783, 'Rio de Janeiro', 219946287),
            ('Kids World', null, 456789123654485, null, 'São Paulo', 1198657484);
 
 -- idPseller, idPproduct, prodQuantity
insert into productSeller (idPseller, idPproduct, prodQuantity) values
							 (1, 6, 80),
                             (2, 7, 10);
				