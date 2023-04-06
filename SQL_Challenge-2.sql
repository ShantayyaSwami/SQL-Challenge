use sqlchallenge;

-- Q51. Write an SQL query to report the name, population, and area of the big countries. Return the result table in any order.
-- A country is big if: ● it has an area of at least three million (i.e., 3000000 km2), 
-- or ● it has a population of at least twenty-five million (i.e., 25000000).

create table world1(name varchar(50) primary key, continent varchar(50), area int, population decimal(15,0), gdp decimal(15,0));
insert into world1 values('Afghanistan','Asia',652230,25500100,20343000000),('Albania','Europe',28748,2831741,12960000000),
('Algeria','Africa',2381741,37100000,188681000000),('Andorra','Europe',468,78115,3712000000),
('Angola','Africa',1246700,20609294,100990000000);

select * from world1;
select name,population,area from world1 where area >= 25000000 or population >= 3000000;

-- Q52. Write an SQL query to report the names of the customer that are not referred by the customer with id = 2.
create table customer1(cust_id int, name varchar(50), referee_id int null);
insert into customer1 values(1,'Will',null),(2,'Jane',null),(3,'Alex',2),(4,'Bill',null),(5,'Zack',1),(6,'Mark',2);
select * from customer1;

select name from customer1 where referee_id <> 2 or referee_id is null;

-- Q53. Write an SQL query to report all customers who never order anything. Return the result table in any order.
create table customers2(id int primary key, name varchar(50));
create table orders4(id int, cust_id int, foreign key(cust_id) references customers2(id));
insert into customers2 values(1,'Joe'),(2,'Henry'),(3,'Sam'),(4,'Max');
insert into orders4 values(1,3),(2,1);
select * from orders4;
select * from customers2;

select id,name from customers2 where name not in (select c.name from customers2 c inner join orders4 o on c.id = o.cust_id);
-- or 
select id,name from customers2 where id not in (select cust_id from orders4);