-- inserção de dados no bd company

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
employee as e ()