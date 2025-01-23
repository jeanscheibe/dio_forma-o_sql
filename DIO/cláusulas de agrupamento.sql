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