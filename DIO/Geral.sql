-- case statement

use company;

update employee set Salary = 
	case
		when Dno = 5 then Salary + 2000
        when Dno = 4 then Salary + 1500
        when Dno = 1 then Salary + 3000
        else Salary + 0
	end;

select Fname, Salary, Dno from employee;

-- union, except e intersect ---------------------------------------------------

create database teste;
use teste;

create table R(
	A char(2)
);

create table S(
	A char(2)
);

insert into R(A) values ('a1'), ('a2'), ('a3');

insert into S(A) values ('a1'), ('a2'), ('a3'), ('a4'), ('a5');

select * from R;
select * from S;

-- except -> implementa utilizando o not in
select * from S where A not in (select A from R);

-- Union
(select distinct R.A from R)
	UNION
    (select distinct S.A from S);
    
(select R.A from R)
	UNION
    (select S.A from S);
    
-- intersect
select distinct R.A from R where R.A in (select S.A from S)

-- queries com alias -------------------------------------------------------------

use company;

show tables;

-- Dnumber: department
desc department;

desc department;
desc dept_locations;

select * from department;
select * from dept_locations;

-- linha com ambiguidade
select * from department, dept_locations where Dnumber = Dnumber;

-- linha sem ambiguidade através do alias ou as statment
select Dname, l.Dlocation as Department_name
	from department as d, dept_locations as l
    where d.Dnumber = l.Dnumber;

-- expressões regulares
select concat(Fname, ' ', Lname) from employee;

-- inserção de dados no bd company --------------------------------------------------------------------------

use company;
show tables;

select * from employee;
insert into employee values ('John', 'B', 'Smith',123456789, '1965-01-09', '731-Fondren-Houston-TX', 'M', 30000, null, 5);

insert into dependent values (123456789, 'Alice', 'F', '1986-04-05', 'Daughter', 12);

desc dependent;

select * from department;

drop table dependent;

insert into department values ('Research', 5, 123456789, '1988-05-22', '1986-05-22');

insert into dept_locations values (5, 'Houston');

insert into works_on values (123456789, 5, 32.5);

insert into project values ('ProductX', 5, 'Bellaire', 5);

-- possibilidade de uso
load data infile 'path' into table employee
	fields terminated by ','
    lines terminated by ','
    ;

-- Recuperando dados

select * from employee;
select Ssn, Fname, Dname from employee e, department d where (e.Ssn = d.Essn);


select Fname, dependent_name, Relationship from employee, dependent where Essn = Ssn;

select Bdate, Address from employee
	where Fname = 'John' and minit='B' and Lname='Smith';
    
select * from department where Dname = 'Research';

select Fname, Lname, Address from employee, department
	where Dname= 'Research' and Dnumber=Dno;
    
-- nomes, aliasing e variação de tuplas

select Fname, Lname, Address from employee where department.Dnumber = employee.Dno;

-- renomeando
select E.Fname, E.Lname, S.Fname, S.Lname from employee as e, employee as s where E.Super_ssn=S.Ssn;

-- renomeando atributos
-- employee as e ()

-- JOIN statement -----------------------------------------------------------

desc employee;
desc works_on;

select * from employee JOIN works_on;

-- JOIN
select * from employee JOIN works_on;

-- JOIN ON

-- JOIN ON -> INNER JOIN

show tables;
desc dept_locations; -- Dnumber

select * from employee JOIN works_on on Ssn = Essn;
select * from employee JOIN department on SSn = Mgr_ssn;

select Fname, Lname, Address
	from (employee join department on Dno=Dnumber)
    where Dname = 'Research';
    
select * from dept_locations; -- address e Dnumber
select * from department;     -- Dname, Dept_create_date

select Dname, Dept_create_date, Dlocation
	from department JOIN dept_locations using(Dnumber)
    order by Dept_create_date;
    
-- cláusulas de ordenação

use company;

select * from employee order by Fname;

select * from employee order by Fname, Lname; -- coloca dois atributos para ordenação, casa haja dois primeiros nomes iguais, irá ordenar pelo sobrenome

-- nome do departamento, nome do gerente
select distinct d.Dname, concat(e.Fname, ' ', e.Lname) as Manager
	from department as d, employee as e, works_on as w, project p
	where (d.Dnumber = e.Dno and E.Ssn = d.Mgr_ssn and w.Pno = p.Pnumber)
    order by d.Dname, e.Fname, e.Lname;
    
    /* ↑↑↑↑↑↑↑
    No vídeo houve um problema de redundância no retorno
    Retornou várias vezes a mesma entrada
    Por isso foi acrescentado o distinct
    */
    
    -- recupera todos os empreegadoes e seus projetos em andamento
    
    select d.Dname as department, concat(e.Fname, ' ', e.Lname) as Employee, p.Pname as Project_name, Address
		from department as d, employee e, works_on w, project p
        where (d.Dnumber = e.Dno and e.Ssn = w.Essn and w.Pno = p.Pnumber)
		order by d.Dname, e.Fname, e.Lname asc;
    
-- funções e cláusulas de agrupamento

use company;

select * from employee;

-- recuperando o número total de pessoas trabalhando em research
select count(*) from employee, department
	where Dno=Dnumber and Dname = 'Research';
    
-- Ver a média salarial e o número de funcionários de cada departamento
select Dno, count(*) as Number_of_employment, round(avg(Salary), 2) as salary_avg from employee
	group by Dno;


select Pnumber, Pname, count(*)
	from project, works_on
    where Pnumber = Pno
    group by Pnumber, Pname;

    
select count(distinct salary) from employee;

select round(sum(Salary), 2) as total_sal, round(max(Salary), 2) as higher_sal, round(min(Salary), 2) as min_sal, round(avg(Salary), 2) as med_sal from employee;

select sum(Salary), max(Salary), min(Salary), avg(Salary)
	from(employee join department on Dno = Dnumber)
    where Dname = 'Research';
    
select Lname, Fname
	from employee
    where ( select count(*)
            from dependent
			where Ssn = Essn) >= 2;

-- group by

select Pnumber, Pname, count(*)
	from project, works_on
    where Pnumber = Pno
    group by Pnumber, Pname;

-- HAVING - cria uma condição para realizar ou não o retorno da querie

-- Traz os números e nomes de projetos desde que apareçam mais que dois resultados
select Pnumber, Pname, count(*)
    from PROJECT, WORKS_ON
    where Pnumber = Pno
    group by Pnumber, Pname
    having count(*)>2;
    
select Dno, count(*)
	from employee
    where salary > 30000
    group by Dno
    having count(*)>=2;
    
select Dno as department, count(*) as number_of_employees from employee
	where Salary>20000
		and Dno in (select Dno
					from employee
                    having count(*)>=2)
	group by Dno;
    