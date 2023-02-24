use sqlchallenge;
Create table If Not Exists salesperson (sales_id numeric, name varchar(255), salary int,commission_rate int, hire_date varchar(255));
Create table If Not Exists company (com_id numeric, name varchar(255), city varchar(255));
Create table If Not Exists `order` (order_id numeric, order_date varchar(255), com_id int, sales_id int, amount int);

insert into salesperson (sales_id, name, salary, commission_rate, hire_date) values ('1', 'John', '100000', '6', '4/1/2006');
insert into salesperson (sales_id, name, salary, commission_rate, hire_date) values ('2', 'Amy', '12000', '5', '5/1/2010');
insert into salesperson (sales_id, name, salary, commission_rate, hire_date) values ('3', 'Mark', '65000', '12', '12/25/2008');
insert into salesperson (sales_id, name, salary, commission_rate, hire_date) values ('4', 'Pam', '25000', '25', '1/1/2005');
insert into salesperson (sales_id, name, salary, commission_rate, hire_date) values ('5', 'Alex', '5000', '10', '2/3/2007');


insert into company (com_id, name, city) values ('1', 'RED', 'Boston');
insert into company (com_id, name, city) values ('2', 'ORANGE', 'New York');
insert into company (com_id, name, city) values ('3', 'YELLOW', 'Boston');
insert into company (com_id, name, city) values ('4', 'GREEN', 'Austin');

insert into `order` (order_id, order_date, com_id, sales_id, amount) values ('1', '1/1/2014', '3', '4', '10000');
insert into `order` (order_id, order_date, com_id, sales_id, amount) values ('2', '2/1/2014', '4', '5', '5000');
insert into `order` (order_id, order_date, com_id, sales_id, amount) values ('3', '3/1/2014', '1', '1', '50000');
insert into `order` (order_id, order_date, com_id, sales_id, amount) values ('4', '4/1/2014', '1', '4', '25000');

-- Q5. Output all the names from salesperson table, who didn't have sales to company RED.
select * from salesperson;
select * from company;
select * from `order`;

select name from salesperson where sales_id not in (select sales_id from `order` where com_id = (select com_id from company where name = 'RED'));

-- Q6. Write a SQL query for a report that provides pair(actor_id,dirctor_id) where actor has worked with director atleast 3 times.
Create table If Not Exists ActorDirector (actor_id int, director_id int, timestamp int primary key);
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '1', '0');
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '1', '1');
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '1', '2');
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '2', '3');
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '2', '4');
insert into ActorDirector (actor_id, director_id, timestamp) values ('2', '1', '5');
insert into ActorDirector (actor_id, director_id, timestamp) values ('2', '1', '6');


with test as (select actor_id,director_id,row_number() over (partition by actor_id,director_id) as rownum from actordirector)
select actor_id,director_id from test where rownum >= 3;


