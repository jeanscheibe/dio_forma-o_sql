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
    
-- like e between
select * from employee;

update employee set Fname='Winston' where Fname='John';


