create schema if not exists company;
use company;

create table employee(
	Fname varchar(15) not null,
	Minit char,
	Lname varchar(15) not null,
	Ssn char(9) not null,
	Bdate date,
	Address varchar(30),
	sex char,
	Salary decimal(10,2),
	Super_ssn char(9),
	Dno int not null,
    constraint chk_salary check (Salary > 2000.0),
	constraint pk_employee primary key (Ssn)
);

create table department(
	Dname varchar(15) not null,
    Dnumber int not null,
    Mgr_ssn char(9),
    Mgr_start_date date,
    Dept_create_date date,
    constraint chk_date_dept check (Dept_create_date < Mgr_start_date),
    constraint pk_dept primary key (Dnumber),
    constraint unique_name_dept unique (Dname),
    foreign key (Mgr_ssn) references employee(Ssn)
);

create table dept_locations(
	Dnumber int not null,
    Dlocation varchar(15) not null,
    constraint pk_dept_locations primary key (Dnumber, Dlocation),
    constraint fk_dept_locations foreign key (Dnumber) references department(Dnumber)
);

create  table project(
	Pname varchar(15) not null,
    Pnumber int not null,
    Plocation varchar(15),
    Dnum int not null,
    primary key (Pnumber),
    constraint unique_project unique (Pname),
    constraint fk_project_dnum foreign key (Pnumber) references department(Dnumber)
);

create table works_on(
	Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,
    primary key (Essn, Pno),
    constraint fk_works_on_employee foreign key (Essn) references employee(Ssn),
    constraint fk_works_on_project foreign key (Pno) references project(Pnumber)
);

create table dependent(
	Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex char,
    Bdate date,
    Relationship varchar(8),
    Age int not null,
    constraint chk_age_dependent check (Age < 22),
    primary key (Essn, Dependent_name),
    constraint fk_dependent_employee foreign key (Essn) references employee(Ssn)
);

show tables;
desc department;

-- visualiza as constraints de uma tabela
select * from information_schema.table_constraints
	where constraint_schema = 'company';

-- visualiza as foreign key's
select * from information_schema.referential_constraints
	where constraint_schema = 'company';
    
-- usando o alter

-- insere uma constraint em uma tabela já criada
alter table employee
	add constraint fk_employee
    foreign key(Super_ssn) references employee(Ssn)
    on delete set null
    on update cascade;
    
alter table department drop constraint department_ibfk_1;
alter table department
	add constraint fk_dept foreign key(Mgr_ssn) references employee(Ssn)
    on update cascade;
    
desc dept_locations;

alter table dept_locations drop constraint fk_dept_locations;

alter table dept_locations
	add constraint fk_dept_locations foreign key (Dnumber) references department(Dnumber)
    on delete cascade
    on update cascade;

-- recuperando todos os gerentes que trabalham em Stafford
select Dname as Department_Name, concat(Fname, ' ', Lname) as Manager from department d, dept_locations l, employee e
    where d.Dnumber = l.Dnumber and Dlocation='Stafford' and Mgr_ssn = e.Ssn;

-- recuperando todos os gerentes que trabalham, departamentos e seus nomes
select Dname as Department_Name, concat(Fname, ' ', Lname) as Manager, Dlocation from department d, dept_locations l, employee e
    where d.Dnumber = l.Dnumber and Mgr_ssn = e.Ssn;
    
-- fazendo update do nome do empregado porque li 1984 recentemente
update employee set Fname='Winston' where Fname='John';

-- like e between
select * from employee;

select concat(Fname, ' ', Lname) Complete_name, Address as department_name from employee, department
	where (Dno=Dnumber and Address like '%Houston%');
    
select concat(Fname, ' ', Lname) Complete_name, Address from employee
	where (Address like '%Houston%');

select Fname, Lname from employee where (Salary > 30000 and Salary < 40000);

select concat(Fname, ' ', Lname) as complete_name from employee where (Salary between 20000 and 40000);

-- mais operadores lógicos

-- and
select Bdate, Address from employee where Fname='Winston' and Minit='B' and Lname='Smith';

-- or
select * from department where Dname='Research' or Dname ='Administration';


select concat(Fname, ' ',Lname) as complete_name from employee, department where Dname='Research' and Dnumber=Dno;

-- subqueries

select distinct Pnumber from project
	where Pnumber in
		(
		select Pnumber
		from project, department, employee
		where Mgr_ssn = Ssn and Lname='Smith' and Dnum=Dnumber
		)
    
    or
    
		(
		select distinct Pno
        from works_on, employee
        where (Essn=Ssn and Lname='Smith'
		)
	);

select distinct * from works_on
	where (Pno, Hours) IN (select PNO, Hours
							from works_on
                            where Essn=123456789);


-- Cláusulas com exists e unique

-- quais employees possuem dependentes
select Fname, Lname from employee as e
	where exists (select * from dependent as d
					where e.Ssn = d.Essn);
                    
-- quais employees possuem filhas
select Fname, Lname from employee as e
	where exists (select * from dependent as d
					where e.Ssn = d.Essn and Relationship = 'Daughter');
                    
-- quais employees não possuem dependentes
select Fname, Lname from employee as e
	where not exists (select * from dependent as d
					where e.Ssn = d.Essn);

-- quais employees não possuem dependentes
select e.Fname, e.Lname from employee as e, department d
	where (e.Ssn = d.Essn) and exists (select * from dependent as d where e.Ssn = d.Essn); -- não funcionou

-- quem tem menos de, ou, dois filhos
select Fname, Lname from employee
	where (select count(*) from dependent where Ssn=Essn) <=2;
    
select distinct Essn from works_on where Pno in (1, 2, 5);