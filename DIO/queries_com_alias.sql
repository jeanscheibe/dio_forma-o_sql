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


