
-- cria a o BD first_example
create database first_example;

-- set o uso do BD first_example
use first_example;

-- cria a tabela person
create table person(
person_id smallint unsigned,
fname varchar(20),
lname varchar(20),
gender enum('M', 'F', 'Others'),
birthday date,
street varchar(20),
city varchar(20),
state varchar(20),
country varchar(20),
postal_code varchar(20),
primary key (person_id)
);

-- descreve a tabela person 
desc person;

/*
cria a tabela favorite_food
seta a chave estrangeira fk_favorite_food_person_id
*/
create table favorite_food(
	person_id smallint unsigned,
    food varchar(20),
    constraint pk_favorite_food primary key (person_id, food),
    constraint fk_favorite_food_person_id foreign key (person_id)
    references person(person_id)
);

-- descreve a tabela favorite_food
desc favorite_food;

-- recupera as constraints que foram setadas para o nosso banco de dados
/*
select * from information_schema.table_constraints
where constraint_schema = 'first_example';
*/

desc information_schema.table_constraints;
select constraint_name from information_schema.table_constraints
where constraint_schema = 'first_example';

insert into person values 	('0', 'Carolina', 'Silva', 'F', '1979-08-21',
							'Rua 1', 'Petrópolis', 'RJ', 'Brazil', '26054-89'),
							('1', 'Juliana', 'Barros', 'F', '1992-05-15',
							'Rua 2', 'Araranguá', 'SC', 'Brazil', '88900-000'),
                            ('2', 'Aneliese', 'Feliciano', 'F', '1993-10-02',
							'Estrada Geral do Fundo Grande', 'Araranguá', 'SC', 'Brazil', '88900-000');
                            
-- seleciona todas as entradas da tabela person                            
select * from person;

-- delete a entrada onde o id é 1 ou 2 - pode usar para deletar vários ids ao mesmo tempo
delete from person where person_id=1
					or id=2;

insert into favorite_food values(0, 'Lasanha'),
								(1, 'Ovo Frito'),
                                (2, 'Batata Frita');
                                
select * from favorite_food; 