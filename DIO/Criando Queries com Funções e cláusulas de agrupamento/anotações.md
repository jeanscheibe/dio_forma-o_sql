## ORDER BY

ordenação por coluna
expressões baseadas em dados

mais de um valor

select <attribute_list> from <table_list> where <condition> order by <attribute_list> desc <!-- desc significa descendente-->

desc - descendente

limit - limita a quantidade de registros que aparecerão no retorno

## ordenação com SQL utilizando expressões

## Funções de agregação com SQL

count
sum
min
max
average

Exemplos

SELECT year, COUNT(\*) AS record_count FROM station_data WHERE tornado=1 GROUP BY year;

SELECT year, month, COUNT(\*) AS record_count FROM station_data WHERE tornado=1 GROUP BY year, month;

SELECT COUNT(\*) AS record_count FROM station_data;

## GROUP BY: Cláusulas de agrupamento com SQL

## explorando cláusulas de agrupamento com SQL

## entendendo o HAVING statement

condição de agrupamento

HAVING - filtragem dos registros dentro dos grupos criados

Exemplo

Select Pnumber, Pname, COUNT(_)
FROM PROJECT, WORKS_ON
WHERE Pnumber = Pno
GROUP BY Pnumber, Pname
HAVING COUNT(_)>2;

    no exemplo acima só acontecerá a busca caso o número de registros seja maior do que 2.

Preferência de execução das cláusulas:
Utilizar parênteses para que a ordem desejada seja mantida
