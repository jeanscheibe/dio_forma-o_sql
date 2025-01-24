use company;

-- JOIN statement

desc employee;
desc works_on;

select * from employee JOIN works_on;

select * from employee JOIN works_on;

show tables;
desc dept_locations; -- Dnumber

select * from employee JOIN works_on on Ssn = Essn;
select * from employee JOIN department on SSn = Mgr_ssn;

select Fname, Lname, Address
	from (employee join department on Dno=Dnumber)
    where Dname = 'Research';
    
select * from dept_locations; -- address e Dnumber
select * from department;     -- Dname, Dept_create_date

select Dname, Dept_create_date as start_date, Dlocation as Location
	from department INNER JOIN dept_locations using(Dnumber)
    order by Dept_create_date;
    
select * from employee cross join dependent;

-- JOIN com três tabelas

-- project, works_on e employee
select concat(Fname, ' ', Lname) as Complete_name, Dno as DeptNumber, Pname as ProjectName,
	Pno as Project_NUmber, Plocation as Location from employee
    inner join works_on on Ssn = Essn
    inner join project on Pno = Pnumber
    where Pname like 'Product%'
    order by Pnumber;

select Dnumber, Dname, concat(Fname, ' ', Lname) as Manager, Salary, round(Salary*0.05,2) as Bonus from department
	Inner join dept_locations using(Dnumber)
    inner join employee on Ssn = Mgr_ssn
    group by Dnumber
    having count(*)>1;