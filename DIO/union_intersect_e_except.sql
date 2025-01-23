-- union, except e intersect

create database teste;
use teste;

create table R(
	A char(2)
);

create table S(
	A char(2)
);

insert into R(A) values ('a1'), ('a2'), ('a3');

insert into S(A) values ('a1'), ('a2'), ('a3'), ('a4'), ('a5');

select * from R;
select * from S;

-- except -> implementa utilizando o not in
select * from S where A not in (select A from R);

-- Union
(select distinct R.A from R)
	UNION
    (select distinct S.A from S);
    
(select R.A from R)
	UNION
    (select S.A from S);
    
-- intersect
select distinct R.A from R where R.A in (select S.A from S)

