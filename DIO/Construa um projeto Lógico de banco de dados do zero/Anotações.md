## Desafio de projeto

- Mapeamento do esquema ER para relacional
- Definição do script SQL para criação do esquema de banco de dados
- Persistência de dados para testes
- Recuperando de informações com queries SQL

Venda de artistas

## BD's

create database agencia;

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
porcentagem_comissao decimal(5, 2)
);

create table casas(
id_casa int primary key auto_increment,
cnpj_casa varchar(18) not null,
nome_casa varchar(80) not null,
endereco_casa int not null,
responsavel_casa int not null,
capacidade int not null,
tipo enum ('Teatro', 'Casa de show', 'Boate', 'Bar/Restaurante', 'Arena')
);

create table produtoras(
id_produtora int primary key auto_increment,
nome_produtora varchar(80) not null,
cnpj_produtora varchar(18) not null,
endereco_produtora int not null,
responsavel_produtora int not null
);

create table vendas(
id_venda int primary key auto_increment,
artista int not null,
casa int not null,
formato enum ('Acústico', 'Banda', 'Playback', 'DJ'),
valor_venda decimal(10, 2) not null,
desconto decimal(5, 2) not null,
porcentagem_comissão decimal(5, 2) not null,
comissao decimal(10,2) GENERATED ALWAYS AS ((valor_venda - desconto) \* (porcentagem_comissão / 100)) STORED
);

### Dados

## Artistas

- Bandão Azul
- Munição Floral
- Neili e Neilerei
- Ruan Castro e banda
- Kay
- Breno

## Casas

- Arena Music
- Palácio das Artes
- Espaço das Américas
- Vibra Hall
- Teatro Municipal
- Auditório Nacional
- Casa de Eventos Prime
- Music Hall", "Mega Show Arena
- Espaço Cultural
- Teatro Ópera
- Pavilhão de Eventos
- Centro Musical
- Anfiteatro Nacional

## Vendas

-

## Produtoras

- J10 Produção de eventos
- Zion Produções
- Tiãozin Eventos
- EV Produções
- João do caminhão eventos e produção
- Marina eventos
- Carmina Eventos
- USHUI Produções
- Ateliê Calle 7
- Nova Geração Gospel
- INOVA SOUND Produções
