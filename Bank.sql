-- explorando os comandos DDL

select now() as Timestamp;

create database manipulation;
use manipulation;

drop table bankAccounts;

create table bankAccounts (
	id_account int auto_increment primary key,
    ag_num int not null,
    ac_num int not null,
    saldo float,
    constraint identification_account_constraint unique (ag_num, ac_num)
);

create table bankClient(
	id_client int auto_increment,
    clientAccount int,
    cpf char(11) not null,
    rg char(9) not null,
    nome varchar(50) not null,
    endereco varchar (100) not null,
	rendaMensal float,
	primary key (id_client, clientAccount),
	constraint fk_account_client foreign key (clientAccount) references bankAccounts(id_account)
	on update cascade
);

create table bankTransaction (
	id_transaction int auto_increment primary key,
    ocorrencia datetime,
    status_transaction varchar(20),
    valor_transferido float,
    source_accounts int,
    destination_account int,
    constraint fk_source_transaction foreign key(source_accounts) references bankAccounts(id_account),
    constraint fk_destination_transaction foreign key (destination_account) references bankAccounts(id_account)
);

-- adicionar uma variável
alter table bankAccounts add limite_credito float not null default 500.00;
desc bankAccounts;

-- adicionar e remover uma variável
alter table bankAccounts add email varchar(60);
alter table bankAccounts drop email; -- poderia ser necessário utilizar drop column em vez de apenas drop

-- alter table nome_tabela modify column nome_atributo tipo_dados condição;
-- alter table nome_tabela add constraint nome_constraint condições;

-- modificar um atributo que já existe

insert into bankAccounts (ag_num, ac_num, saldo) values (1234,123456,0);

insert into bankClient (clientAccount, cpf, rg , nome , endereco, rendaMensal) values(1, 12345678912, 123456789, 'Fulano', 'Rua de Lá', 6500.6);

alter table bankClient add UFF char(2) not null default 'RJ';
update bankClient set UFF='RJ' where nome='Fulano';

select * from bankClient;

-- Elaborando queries SQL com Expressões

