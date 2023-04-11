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

-- Q.54 Write an SQL query to find the team size of each of the employees.
select * from employee3;
create table employee3 as select * from employee;

select e.employee_id, team_count.size from employee3 e inner join (select team_id,count(*) as size from employee3 group by team_id) team_count on e.team_id = team_count.team_id;
-- or 
select employee_id,count(employee_id) over (partition by team_id) team_size from employee3; 

-- Q.55 A telecommunications company wants to invest in new countries. The company intends to invest in the countries where the average call 
-- duration of the calls in this country is strictly greater than the global average call duration. 
-- Write an SQL query to find the countries where this company can invest.
select * from country;
select * from calls1;
select * from person1;

create table person1(id int primary key ,name varchar(50),phone_number varchar(5));
alter table person1 modify column phone_number varchar(50);
create table country(name varchar(50),country_code varchar(50) primary key);
create table calls1(caller_id int,callee_id int,duration int);
insert into person1 values(3,'Jonathan','051-1234567'),(12,'Elvis','051-7654321'),(1,'Moncef','212-1234567'),(2,'Maroua','212-6523651'),
(7,'Meir','972-1234567'),(9,'Rachel','972-0011100');
insert into country values('Peru','51'),('Israel','972'),('Morocco','212'),('Germany','49'),('Ethiopia','251');
insert into calls1 values(1,9,33),(2,9,4),(1,2,59),(3,12,102),(3,12,330),(12,3,5),(7,9,13),(7,1,3),(9,7,1),(1,7,7);

with dur as (select p.id,left(p.phone_number,3) as pnum, round(avg(c.duration),2) as call_duration from person1 p inner join calls1 c on p.id = c.caller_id group by p.id)
select cn.name from country cn inner join dur d on cn.country_code = trim(leading '0' from d.pnum) where d.call_duration > (select round(avg(duration),2) as global_avg_call from calls1) group by cn.name;

-- or 
select cn.name from country cn inner join
(select id,trim(leading '0' from left(phone_number,3)) as pnum, test1.avg_call_duration from person1 p 
inner join 
(select caller_id, round(avg(duration),2) as avg_call_duration 
from 
(select caller_id, duration from calls1 union select callee_id, duration from calls1) test 
group by caller_id) test1 
on p.id = test1.caller_id) test2 
on cn.country_code = test2.pnum 
where test2.avg_call_duration > (select round(avg(duration),2) as global_avg_call from calls1) group by cn.name;

-- Q.56