use company;

-- JOIN statement

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