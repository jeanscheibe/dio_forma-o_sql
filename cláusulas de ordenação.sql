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
    
    
    