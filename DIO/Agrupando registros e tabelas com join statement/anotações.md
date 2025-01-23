# CASE statement

Troca de um valor
Condição para troca
Mapeamento de valores e correspondência

CASE | When |
| Then | END

Exemplo

UPDATE EMPLOYEE
SET Salary =
CASE WHEN Dno=5 Then Salary + 2000
WHEN Dno=4 Then Salary + 1500
WHEN Dno=1 Then Salary + 3000
ELSE Salary + 0;

## Agrupamento com CASE

## O caso zero null/trick

Query sem case statement

<!-- Tornado precipitation -->

Select year, month
sum(precipitation) as tornado_precipitation
from station_data
where tornado = 1
groupa by year, month

<!-- Non-Tornado precipitation -->

Select year, month
sum(precipitation) as non_tornado_precipitation
from station_data
where tornado = 0
groupa by year, month

---

Query com case statement

select year, month,
sum (CASE when tornado = 1 Then precipitation else 0 end) as tornado_precipitation
sum (CASE when tornado = 0 Then precipitation else 0 end) as non_tornado_precipitation
from station_data
group by year, month

## Entendendo queries de múltiplas tabelas com JOIN's

JOIN - junção de tabelas

CROSS JOIN - junção de tabelas com base na multiplicação de matrizes

ON - condição de junção

## Queries com INNER JOIN

INNER JOIN - cria um resultado de busca com os dados que coincidem nas duas tabelas,
ou seja, linhas não correspondentes são excluídas

USING - serve para utilizar ON quando os atributos em ambas as tabelas tem o mesmo nome

## Aplicando JOIN statement ao cenário Employee

## agrupamento com mais de duas tabelas e JOIN

SELECT a.account_id, c.fed_id, e.fname, e.lname
FROM account a INNER JOIN customer c
ON a.cust_id = c.cust_id
INNER JOIN employee e
ON a.open_emp_id = e.emp_id
WHERE c.cust_type_cd = 'B';

3 tabelas
2 JOIN

## criando uma query SQL com JOIN entre três tabelas

## a ordem das queries importa?

## Não, porque o SGBD interpreta e escolhe a sequência de comandos

## Posso forçar uma ordem?

no MySQL usa STRAIGHT_JOIN

SELECT STRAIGHT_JOIN a.account_id, c.fed_id, e.fname, e.lname
FROM account a INNER JOIN customer c
ON a.cust_id = c.cust_id
INNER JOIN employee e
ON a.open_emp_id = e.emp_id
WHERE c.cust_type_cd = 'B';

---

NO sql server usa FORCE ORDER

## Nested com JOIN statement

SELECT a.account_id, a.cust_id, a.open_date, a.product_cd
FROM account a INNER JOIN
(SELECT emp_id, assigned_branch_id
FROM employee
WHERE start_date <'2007-01-01' AND (title = 'Teller' OR title =
'Head Teller')) e
ON a.open_emp_id = e.emp_id
INNER JOIN
(SELECT branch_id
FROM branch
WHERE name = 'Woburn Branch')b
ON e.assigned_branch_id = b.branch_id

## self JOIN: mesma tabela em QUERY JOIN

Quando precisamos disso?

Ssn - identificação do empregado
Superssn - identificação dos supervisores

Para referenciar empregados com seus supervisores seria necessário fazer um JOIN dela com ela mesma

SELECT a. account_id, e.emp_id,
b_a.name open_branch, b_e.name emp_branch
FROM account a INNER JOIN branch b_a
ON a.open_branch_id= b_a.branch_id
INNER JOIN employee e
ON a.open_emp_id = e.emp_id
INNER JOIN branch b_e
ON e.assigned_branch_id = b_e.branch_id
WHERE a.product_cd = 'CHK';

## comparando condições de junção e filtros

## como utilizar o outer join statement

SELECT c.cust_id, b.name
FROM customer c LEFT OUTER JOIN business b
ON c.cust_id = b.cust_id;

LEFT JOIN: Quando você quer garantir que todos os dados de uma tabela específica sejam mantidos no resultado, mesmo sem correspondências.
RIGHT JOIN: Similar ao LEFT JOIN, mas priorizando a outra tabela.
FULL JOIN: Quando deseja consolidar todos os dados de ambas as tabelas, mostrando correspondências e discrepâncias.

AGLUTINAR DUAS OU MAIS QUERIES

CASE WHEN THEN ELSE

INNER E OUTER

Pode ser utilizado em qualquer tipo de join
