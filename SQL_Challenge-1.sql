use sqlchallenge;
show tables;

create table city(id int,name varchar(17), countrycode varchar(10), district varchar(30), population bigint null);
select * from city;
describe city;

load data infile 'CityTable.csv'
into table city
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows 

-- Q1. Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.
select * from city where countrycode = 'USA' and population > 100000;

-- Q2. Query the NAME field for all American cities in the CITY table with populations larger than 120000.
select name from city where countrycode = 'USA' and population > 120000;

-- Q3. Query all columns (attributes) for every row in the CITY table
select * from city;

-- Q4. Query all columns for a city in CITY with the ID 1661.
select * from city where id like 1661;
-- or 
select * from city where id = 1661;

-- Q5. Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
select * from city where countrycode like 'JPN';

-- Q6. Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.
select name from city where countrycode = 'JPN';

create table station(id int, city varchar(30), state char(2), lat_n int, long_w varchar(20));
drop table station;

load data infile 'stationdata.csv'
into table station
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 2 rows
 
 select * from station;
 
 -- Q7. Query a list of CITY and STATE from the STATION table.
 select city, state from station;
 
 -- Q8. Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
select distinct city from station where (id % 2) = 0;

-- Q9. Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
select (count(city) - count(distinct city)) as diff from station; 

-- Q10. Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths 
-- (i.e.: number of characters in the name). 
-- If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.

select city,length(city) as 'length' from station where length(city) = (select min(length(city)) from station) order by city limit 1;
-- or 
select city,length(city) as len from station order by length(city),city limit 1;

select city,length(city) as 'length' from station where length(city) = (select max(length(city)) from station);
-- or
select city,length(city) as len from station order by length(city) desc,city limit 1;

-- Q11. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
select count(distinct city) from station where city like "E%" or city like "I%" or city like "O%" or city like "U%" or city like "A%";

select distinct city from station where city like "A%" or city like "I%" or city like "O%" or city like "U%" or city like "E%";
select distinct city from station where left(city,1) in ('a','e','i','o','u');
select distinct city from station where substr(city,1,1) in ('a','e','i','o','u');
select distinct city from station where city rlike '^[aeiou].*';

-- Q12. Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
select distinct city from station where city like "%a" or city like "%e" or city like "%i" or city like "%o" or city like "%u";
select distinct city from station where right(city,1) in ('a','e','i','o','u');
select distinct city from station where substr(city,-1,1) in ('a','e','i','o','u');
select distinct city from station where city rlike '^*.[aeiou]$';

-- Q13. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
select count(distinct city) from station where city rlike '^[^aeiou].*.[^aeiou]$';
-- or
select count(distinct city) from station where left(city,1) not in ('a','e','i','o','u') and right(city,1) not in ('a','e','i','o','u');

-- Q14. Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
select distinct city from station where city not in (select distinct city from station where city like "%a" or city like "%e" or city like "%i" or city like "%o" or city like "%u");
-- or 
select distinct city from station where city rlike '^*.[^aeiou]$';


-- Q15. Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
select distinct city from station where city not in (select distinct city from station where city like "A%" or city like "I%" or city like "O%" or city like "U%" or city like "E%")
union 
select distinct city from station where city not in (select distinct city from station where city like "%a" or city like "%e" or city like "%i" or city like "%o" or city like "%u");
-- or
select distinct city from station where city rlike '^[^aeiou].*'
union 
select distinct city from station where city rlike '^*.[^aeiou]$';

-- Q16. Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
select city from station where city not in (select distinct city from station where city like "A%" or city like "I%" or city like "O%" or city like "U%" or city like "E%")
intersect
select city from station where city not in (select distinct city from station where city like "%a" or city like "%e" or city like "%i" or city like "%o" or city like "%u");


create table product(product_id int primary key, product_name varchar(50), unit_price int);
create table sales(seller_id int, product_id int, buyer_id int, sale_date date, quantity int, price int, foreign key(product_id) references product(product_id)); 

insert into product values (1,"S8",1000),(2,"G4",800),(3,"iPhone",1400);
insert into sales values(1,1,1,'2019-01-21',2,2000);
insert into sales values(1,2,2,'2019-02-17',1,800),(2,2,3,'2019-06-02',1,800),(3,3,4,'2019-05-13',2,2800);

select * from product;
select * from sales;

-- Q17 Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is, between 2019-01-01 and 2019-03-31 inclusive.
select p.product_id, product_name from product as p inner join sales as s on p.product_id = s.product_id group by product_id,product_name having max(s.sale_date) <= '2019-03-31';

create table views(article_id int,author_id int,viewer_id int,view_date date);
insert into views values(1,3,5,'2019-08-01'),(1,3,6,'2019-08-02'),(2,7,7,'2019-08-01'),(2,7,6,'2019-08-02'),(4,7,1,'2019-07-22'),
(3,4,4,'2019-07-21'),(3,4,4,'2019-07-21');

select * from views;

-- Q18. Write an SQL query to find all the authors that viewed at least one of their own articles. Return the result table sorted by id in ascending order.
select distinct author_id from views where author_id = viewer_id order by author_id;

create table delivery(delivery_id int primary key, customer_id int, order_date date, customer_pref_delivery_date date);
insert into delivery values(1,1,'2019-08-01','2019-08-02'),(2,5,'2019-08-02','2019-08-02'),(3,1,'2019-08-11','2019-08-11'),
(4,3,'2019-08-24','2019-08-26'),(5,4,'2019-08-21','2019-08-22'),(6,2,'2019-08-11','2019-08-13');

select * from delivery;

-- Q19. If the customer's preferred delivery date is the same as the order date, then the order is called immediately; otherwise, it is called scheduled. 
-- Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal places
alter table delivery add order_status varchar(50);
show variables like "%safe%";
set sql_safe_updates = 0;
alter table delivery drop column order_status;
update delivery set order_status = case when order_date = customer_pref_delivery_date then "immediately" else "scheduled" end;

select round((select count(*) from delivery where order_status = 'immediately')/(select count(*) from delivery)*100,2) as percentage from delivery limit 1;
-- or
select round(immediate_total/total*100,2) as immediate_percentage from(
select count(case when order_date = customer_pref_delivery_date then customer_id end)as immediate_total, count(customer_id) as total from delivery) as test;


-- Q20. Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points. Return the result table ordered by ctr in descending order 
-- and by ad_id in ascending order in case of a tie.

create table ads(ad_id int,user_id int, `action` enum('Clicked','Viewed','Ignored'), primary key(ad_id,user_id));
insert into ads values(1,1,'Clicked'),(2,2,'Clicked'),(3,3,'Viewed'),(5,5,'Ignored'),(1,7,'Ignored'),(2,7,'Viewed'),
(3,5,'Clicked'),(1,4,'Viewed'),(2,11,'Viewed'),(1,2,'Clicked');
select * from ads;

select ad_id,case when (total_clicks*100)/(total_clicks+total_views) is null then 0 else round((total_clicks*100)/(total_clicks+total_views),2) end as CTR from(
select ad_id,count(case when `action`='Clicked' then ad_id end) as total_clicks,count(case when `action`='Viewed' then ad_id end) as total_views from ads group by ad_id) as test order by CTR desc, ad_id asc;

select coalesce(0,null,null);

-- using coalesce function in Q20.
select ad_id,coalesce(round((total_clicks*100)/(total_clicks+total_views),2),0) CTR from(
select ad_id,count(case when `action`='Clicked' then ad_id end) as total_clicks,count(case when `action`='Viewed' then ad_id end) as total_views from ads group by ad_id) as test order by CTR desc, ad_id asc;

-- Q21. Write an SQL query to find the team size of each of the employees.
create table employee(employee_id int primary key, team_id int);
insert into employee values(1,8),(2,8),(3,8),(4,7),(5,9),(6,9);
select * from employee;

select employee_id,count(employee_id) over (partition by team_id) as team_size from employee order by employee_id;

-- Q22. Write an SQL query to find the type of weather in each country for November 2019. The type of weather is: 
-- ● Cold if the average weather_state is less than or equal 15, 
-- ● Hot if the average weather_state is greater than or equal to 25, and 
-- ● Warm otherwise

create table countries(country_id int primary key, country_name varchar(50));
create table weather(country_id int, weather_state int, `day` date, foreign key(country_id) references countries(country_id));

insert into countries values(2,'USA'),(3,'Australia'),(7,'Peru'),(5,'China'),(8,'Morocco'),(9,'Spain');
insert into weather values(2,15,'2019-11-01'),(2,12,'2019-10-28'),(2,12,'2019-10-27'),(3,-2,'2019-11-10'),(3,0,'2019-11-11'),
(3,3,'2019-11-12'),(5,16,'2019-11-07'),(5,18,'2019-11-09'),(5,21,'2019-11-23'),(7,25,'2019-11-28'),(7,22,'2019-12-01'),(7,20,'2019-12-02'),
(8,25,'2019-11-05'),(8,27,'2019-11-15'),(8,31,'2019-11-25'),(9,7,'2019-10-23'),(9,3,'2019-12-23');

select * from countries;
select `day` from weather where `day` between '2019-11-01' and '2019-11-30';

select country_name,
case when avg_weather <= 15 then 'Cold'
	 when avg_weather >= 25 then 'Hot'
     else 'Warm'
end as weather_type 
from countries inner join
(select country_id, avg(weather_state) as avg_weather from weather where `day` between '2019-11-01' and '2019-11-30' group by country_id) as test on countries.country_id = test.country_id; -- having `day` between '2019-11-01' and '2019-11-30';

-- or 
select country_name,
case when avg(weather_state) <= 15 then 'Cold'
	 when avg(weather_state) >= 25 then 'Hot'
     else 'Warm'
	end as 'Weather_Type'
from countries as c inner join weather as w on c.country_id = w.country_id where `day` between '2019-11-01' and '2019-11-30' group by c.country_id;

-- Q23. Write an SQL query to find the average selling price for each product. average_price should be rounded to 2 decimal places.
create table Prices(product_id int,start_date date,end_date date, price int, primary key(product_id,start_date,end_date));
create table UnitSold(product_id int, purchase_date date, units int);

insert into prices values(1,'2019-02-17','2019-02-28',5),(1,'2019-03-01','2019-03-22',20),(2,'2019-02-01','2019-02-20',15),(2,'2019-02-21','2019-03-31',30);
insert into unitsold values(1,'2019-02-25',100),(1,'2019-03-01',15),(2,'2019-02-10',200),(2,'2019-03-22',30);

select * from prices;
select * from unitsold;

select p.product_id, round(sum(p.price*u.units)/sum(u.units),2) as avg_price from prices as p inner join unitsold as u on p.product_id = u.product_id where 
u.purchase_date between p.start_date and p.end_date group by p.product_id;

-- Q24. Write an SQL query to report the first login date for each player. Return the result table in any order.
create table activity(player_id int,device_id int, event_date date, games_played int,primary key(player_id,event_date));
insert into activity values(1,2,'2016-03-01',5),(1,2,'2016-05-02',6),(2,3,'2017-06-25',1),(3,1,'2016-03-02',0),(3,4,'2018-07-03',5);

select * from activity;
select player_id,event_date as first_login from
(select player_id,event_date,row_number() over (partition by player_id order by event_date) as login_date from activity) as test where login_date=1;


 -- Q25. Write an SQL query to report the device that is first logged in for each player
select player_id,device_id from(
select player_id,device_id, row_number() over (partition by player_id) as first_logon from activity) as test where first_logon = 1;


-- Q26. Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount.
create table products(product_id int primary key,product_name varchar(50), product_category varchar(50)); 
create table orders(product_id int,order_date date, units int);

select * from products;
select * from orders;

insert into products values(1,'Leetcode Solutions','Book'),(2,'Jewels of Stringology','Book'),(3,'HP','Laptop'),(4,'Lenovo','Laptop'),
(5,'Leetcode Kit','T-shirt');

insert into orders values(1,'2020-02-05',60),(2,'2020-01-18',30),(2,'2020-02-11',80),(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);
insert into orders values(1,'2020-02-10',70);

select p.product_id,p.product_name from products as p inner join (
select product_id,sum(units) as total_units from orders where order_date between '2020-02-01' and '2020-02-28' group by product_id) as orderr on p.product_id = orderr.product_id where orderr.total_units >= 100;

-- Q27. Write an SQL query to find the users who have valid emails. A valid e-mail has a prefix name and a domain where: 
-- ● The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', and/or dash '-'. 
-- The prefix name must start with a letter.
-- ● The domain is '@leetcode.com'.
create table users(user_id int primary key, name varchar(50),mail varchar(100));
insert into users values(1,'Winston','winston@leetcode.com'),(2,'Jonathan','jonathanisgreat'),(3,'Annabelle','bella-@leetcode.com'),
(4,'Sally','sally.come@leetcode.com'),(5,'Marwan','quarz#2020@leetcode.com'),(6,'David','david69@gmail.com'),(7,'Shapiro','.shapo@leetcode.com');

select * from users;
select * from users where mail like '%@leetcode.com' and mail regexp '^[a-zA-Z0-9][a-zA-Z0-9/._-]*@';


-- Q28. Write an SQL query to report the customer_id and customer_name of customers who have spent at least $100 in each month of June and July 2020.
create table customers1(customer_id int primary key,name varchar(50), country varchar(50));
create table product1(product_id int primary key,`description` varchar(50),price int);
create table orders1(order_id int primary key,customer_id int,product_id int,order_date date, quantity int,foreign key(customer_id) references customers1(customer_id),foreign key(product_id) references product1(product_id));

insert into customers1 values(1,'Winston','USA'),(2,'Jonathan','Peru'),(3,'Moustafa','Egypt');
insert into product1 values(10,'LC Phone',300),(20,'LC T-Shirt',10),(30,'LC Book',45),(40,'LC Keychain',2);
insert into orders1 values(1,1,10,'2020-06-10',1),(2,1,20,'2020-07-01',1),(3,1,30,'2020-07-08',2),(4,2,10,'2020-06-15',2),
(5,2,40,'2020-07-01',10),(6,3,20,'2020-06-24',2),(7,3,30,'2020-06-25',2),(9,3,30,'2020-05-08',3);

select * from customers1;
select * from product1;
select * from orders1;

with money_spent as (select customer_id,
case when sum(price*quantity) >= 100 between '2020-06-01' and '2020-06-30' then customer_id
	 when sum(price*quantity) >= 100 between '2020-07-01' and '2020-07-31' then customer_id
     end as spent 
from product1 as p inner join orders1 as o on p.product_id = o.product_id group by o.customer_id)
select c.customer_id,c.`name` from money_spent as m inner join customers1 as c on m.customer_id = c.customer_id;

select 
case when sum(price*quantity) >= 100 between '2020-06-01' and '2020-06-30' and sum(price*quantity) >= 100 between '2020-07-01' and '2020-07-31' then customer_id
     end as cust
from product1 as p inner join orders1 as o on p.product_id = o.product_id group by o.customer_id;

-- Q29. Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020. Return the result table in any order.
create table TVProgram(program_date date, content_id int, `channel` varchar(50), primary key(program_date,content_id));
create table content(content_id int primary key, title varchar(50), kids_content enum('Y','N'),content_type varchar(50));

insert into TVProgram values('2020-06-10 08:00',1,'LC-Channel'),('2020-05-11 12:00',2,'LC-Channel'),('2020-05-12 12:00',3,'LC-Channel'),
('2020-05-13 14:00',4,'Disney Ch'),('2020-06-18 14:00',4,'Disney Ch'),('2020-07-15 16:00',5,'Disney Ch');

insert into content values(1,'Leetcode Movie','N','Movies'),(2,'Alg. for Kids','Y','Series'),(3,'Database Sols','N','Series'),
(4,'Aladdin','Y','Movies'),(5,'Cinderella','Y','Movies');
select * from Tvprogram;
select * from content;

with content as (select content_id,title from content where kids_content= 'Y' and content_type = 'Movies')
select distinct c.title from tvprogram as t inner join content as c on t.content_id = c.content_id where t.program_date between '2020-06-01' and '2020-06-30';

-- Q.30 Write an SQL query to find the npv of each query of the Queries table. Return the result table in any order.
create table NPV(id int, `year` int, npv int, primary key(id,`year`));
create table queries(id int,`year` int, primary key(id,`year`));
insert into NPV values(1,2018,100),(7,2020,30),(13,2019,40),(1,2019,113),(2,2008,121),(3,2009,12),(11,2020,99),(7,2019,0);

insert into queries values(1,2019),(2,2008),(3,2009),(7,2018),(7,2019),(7,2020),(13,2019);
select * from npv;
select * from queries;

select n.id,n.`year`,n.npv from queries q inner join npv n on n.`year`= q.`year` and n.id=q.id;

-- 31. same questin as above
select n.id,n.`year`,n.npv from queries q inner join npv n on n.`year`= q.`year` and n.id=q.id;

-- Q32. Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just show null.
create table employees (id int primary key, name varchar(50));
create table employeeuni(id int, unique_id int,primary key(id,unique_id));

insert into employees values(1,'Alice'),(7,'Bob'),(11,'Meir'),(90,'Winston'),(3,'Jonathan');
insert into employeeuni values(3,1),(11,2),(90,3);

select * from employees;
select * from employeeuni;

select ee.unique_id, e.name from employees e left join employeeuni ee on e.id = ee.id order by e.name;

-- Q33. Write an SQL query to report the distance travelled by each user. 
-- Return the result table ordered by travelled_distance in descending order, 
-- if two or more users travelled the same distance, order them by their name in ascending order.

create table users1(id int primary key, name varchar(50));
create table rides(id int primary key, user_id int, foreign key(user_id) references users1(id), distance int);

insert into users1 values(1,'Alice'),(2,'Bob'),(3,'Alex'),(4,'Donald'),(7,'Lee'),(13,'Jonathan'),(19,'Elvis');
insert into rides values(1,1,120),(2,2,317),(3,3,222),(4,7,100),(5,13,312),(6,19,50),(7,7,120),(8,19,400),(9,7,230);

select * from users1;
select * from rides;
select user_id, sum(distance) as distance from rides group by user_id order by distance desc;

with test as (select user_id, sum(distance) as distance from rides group by user_id order by distance desc)
select u.name, coalesce(t.distance,0) as Distance from users1 u left join test t on u.id = t.user_id order by t.distance desc,u.name;

-- Q34. Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount.
-- repeated question Q.26

-- Q35. Write an SQL query to: 
-- ● Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name. 
-- ● Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.
create table movies(movie_id int primary key,title varchar(50));
create table users2(user_id int primary key, name varchar(50));
create table movierating(movie_id int, user_id int, rating int, created_at date,primary key(movie_id,user_id));

insert into movies values(1,'Avengers'),(2,'Frozen'),(3,'Joker');
insert into users2 values(1,'Daniel'),(2,'Monica'),(3,'Maria'),(4,'James');
insert into movierating values(1,1,3,'2020-01-12'),(1,2,4,'2020-02-11'),
(1,3,2,'2020-02-12'),(1,4,1,'2020-01-01'),(2,1,5,'2020-02-17'),(2,2,2,'2020-02-01'),(2,3,2,'2020-03-01'),(3,1,3,'2020-02-22'),(3,2,4,'2020-02-25');

select * from movies;
select * from users2;
select * from movierating;
select user_id,count(user_id) as rated_movie_count from movierating group by user_id;

with test as (select user_id,count(user_id) as rated_movie_count from movierating group by user_id)
select u.name from test t inner join users2 u on t.user_id = u.user_id order by u.name limit 1;

select movie_id,round(avg(rating),1) as avg_rating from movierating where created_at between '2020-02-01' and '2020-02-28' group by movie_id order by avg_rating desc limit 1;

with test1 as (select movie_id,round(avg(rating),1) as avg_rating from movierating where created_at between '2020-02-01' and '2020-02-28' group by movie_id order by avg_rating desc limit 1)
select m.title from movies m inner join  test1 t on m.movie_id = t.movie_id;


-- Q36. Write an SQL query to report the distance travelled by each user. 
-- Return the result table ordered by travelled_distance in descending order, if two or more users travelled the same distance, order them by their name in ascending order.
-- repeated question Q.33

-- Q.37 same as Q.32

-- Q.38 Write an SQL query to find the id and the name of all students who are enrolled in departments that no longer exist. 
-- Return the result table in any order.
create table departments(id int primary key, name varchar(50));
create table studentsd(id int primary key, name varchar(50), department_id int);
insert into departments values(1,'Electrical Engineering'),(7,'Computer Engineering'),(13,'Business Administration');
insert into studentsd values(23,'Alice',1),(1,'Bob',7),(5,'Jennifer',13),(2,'John',14),(4,'Jasmine',77),
(3,'Steve',74),(6,'Luis',1),(8,'Jonathan',7),(7,'Daiana',33),(11,'Madelynn',1);

select * from departments;
select * from studentsd;

select id, name from studentsd where name not in (select distinct s.name from departments d inner join studentsd s on d.id = s.department_id);

-- Q39. Write an SQL query to report the number of calls and the total call duration between each pair of distinct persons 
-- (person1, person2) where person1 < person2.
create table calls (from_id int, to_id int, duration int);
insert into calls values(1,2,59),(2,1,11),(1,3,20),(3,4,100),(3,4,200),(3,4,200),(4,3,499);
select 
	case when from_id < to_id then from_id else to_id end as person1,
    case when from_id < to_id then to_id else from_id end as person2,
    count(*) as call_count,sum(duration) as total_duration from calls group by person1,person2;
-- or 
select least(from_id,to_id) as person1,greatest(from_id,to_id) as person2,count(*) as call_count,sum(duration) as total_duration from calls group by person2,person1;

-- Q.40 Write an SQL query to find the average selling price for each product. average_price should be rounded to 2 decimal places.
create table prices1(product_id int, start_date date, end_date date, price int);
create table unitssold(product_id int, purchase_date date, units int);

insert into prices1 values(1,'019-02-17','2019-02-28',5),(1,'2019-03-01','2019-03-22',20),(2,'2019-02-01','2019-02-20',15),(2,'2019-02-21','2019-03-31',30);
insert into unitssold values(1,'2019-02-25',100),(1,'2019-03-01',15),(2,'2019-02-10',200),(2,'2019-03-22',30);

select * from prices1;
select * from unitssold;
select p.product_id,round(sum(p.price*u.units)/sum(u.units),2) as avg_price from prices1 p inner join unitssold u on p.product_id = u.product_id
where u.purchase_date between p.start_date and p.end_date group by p.product_id;

-- Q41.Write an SQL query to report the number of cubic feet of volume the inventory occupies in each warehouse.
create table warehouse(name varchar(50), product_id int, units int);
create table products1(product_id int primary key, product_name varchar(50), Width int, Length int, Height int);
insert into warehouse values('LCHouse1',1,1),('LCHouse1',2,10),('LCHouse1',3,5),('LCHouse2',1,2),('LCHouse2',2,2),('LCHouse3',4,1);
insert into products1 values(1,'LC-TV',5,50,40),(2,'LC-KeyChain',5,5,5),(3,'LC-Phone',2,10,10),(4,'LC-T-Shirt',4,10,20);

select * from warehouse;
select * from products1;

select w.name as warehouse_name, sum(w.units*(p.width*p.length*p.height)) as volume from warehouse w inner join products1 p on
w.product_id=p.product_id group by w.name; 

-- Q42. Write an SQL query to report the difference between the number of apples and oranges sold each day. 
-- Return the result table ordered by sale_date. 
create table sales1(sale_date date, fruit enum('apples','oranges'), sold_num int);
insert into sales1 values('2020-05-01','apples',10),('2020-05-01','oranges',8),('2020-05-02','apples',15),
('2020-05-02','oranges',15),('2020-05-03','apples',20),('2020-05-03','oranges',0),('2020-05-04','apples',15),('2020-05-04','oranges',16);

select * from sales1;
with apple as (select sale_date,sold_num as apple_sold from sales1 where fruit = 'apples')
select apple_sold - sold_num as diff from sales1 s inner join apple a on s.sale_date=a.sale_date where s.fruit = 'oranges';

-- if question is of diff between oranges and apples diff
with apple as (select sale_date,sold_num as apple_sold from sales1 where fruit = 'apples')
select case when apple_sold >=  sold_num then apple_sold-sold_num
	   else sold_num - apple_sold end as diff
       from sales1 s inner join apple a on s.sale_date=a.sale_date where s.fruit = 'oranges';
 
 -- Q43. Write an SQL query to report the fraction of players that logged in again on the day after the day they first logged in, 
 -- rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days 
 -- starting from their first login date, then divide that number by the total number of players.
 create table activity(player_id int,device_id int, event_date date, games_played int);
 insert into activity values(1,2,'2016-03-01',5),(1,2,'2016-03-02',6),(2,3,'2017-06-25',1),(3,1,'2016-03-02',0),(3,4,'2018-07-03',5);
 select * from activity;
 with act as (select player_id,event_date from activity)
 
 select round(count(a.player_id)/(select count(distinct player_id) from act),2) as fraction from activity a inner join activity aa on a.player_id=aa.player_id where datediff(a.event_date,aa.event_date) >= 1 and month(a.event_date) = month(aa.event_date);
 
-- Q44. Write an SQL query to report the managers with at least five direct reports. Return the result table in any order.
create table employee2(id int, name varchar(50), department varchar(50), managerId int);
insert into employee2(id,name,department) values(101,'John','A');
insert into employee2 values(102,'Dan','A',101),(103,'James','A',101),(104,'Amy','A',101),(105,'Anne','A',101),(106,'Ron','B',101);

select * from employee2;
with manager as (select case when count(managerid) >= 5 then managerid end as manager from employee2 group by managerid having manager >= 5)
select e.name from employee2 e inner join manager m on e.id = m.manager;

-- Q45. Write an SQL query to report the respective department name and number of students majoring in each department for 
-- all departments in the Department table (even ones with no current students). Return the result table ordered by student_number in descending order.
--  In case of a tie, order them by dept_name alphabetically.
create table student(student_id int primary key, student_name varchar(50), gender varchar(1), dept_id int,foreign key(dept_id) references department(dept_id));
create table department(dept_id int primary key, dept_name varchar(50));

insert into department values(1,'Engineering'),(2,'Science'),(3,'Law');
insert into department values(4,'History');
insert into student values(1,'Jack','M',1),(2,'Jane','F',1),(3,'Mark','M',2);

select * from department;
select * from student;

with student_count as(select dept_id,count(*) as std_count from student group by dept_id)
select d.dept_name,coalesce(s.std_count,0) as studentnumber from department d left join student_count s on d.dept_id = s.dept_id order by studentnumber desc,dept_name;

-- Q46. Write an SQL query to report the customer ids from the Customer table that bought all the products in the Product table. 
-- Return the result table in any order.
create table customer(customer_id int, product_key int);
create table product3(product_key int primary key);

insert into customer values(1,5),(2,6),(3,5),(3,6),(1,6);
insert into product3 values(5),(6);
select * from customer;
select * from product3;

select customer_id from customer group by customer_id having count(distinct product_key) = (select count(product_key) from product3);

-- Q47. Write an SQL query that reports the most experienced employees in each project. 
-- In case of a tie, report all employees with the maximum number of experience years. Return the result table in any order.
create table project(project_id int, employee_id int,primary key(project_id,employee_id));
create table employee1(employee_id int primary key,name varchar(50), experience_years int);
insert into project values(1,1),(1,2),(1,3),(2,1),(2,4);
insert into employee1 values(1,'Khaled',3),(2,'Ali',2),(3,'John',3),(4,'Doe',2);

select * from project;
select * from employee1;

select p.project_id,e.employee_id from project p inner join employee1 e on p.employee_id=e.employee_id where e.experience_years = (select max(experience_years) from employee1);
-- or 

select project_id,employee_id from (
select p.project_id,e.employee_id,dense_rank() over (partition by p.project_id order by e.experience_years desc) as ranking from project p inner join
employee1 e on e.employee_id = p.employee_id) test where ranking = 1;


-- Q48. Write an SQL query that reports the books that have sold less than 10 copies in the last year, 
-- excluding books that have been available for less than one month from today. Assume today is 2019-06-23. Return the result table in any order
create table books(book_id int primary key, name varchar(50), available_from date);
create table orders3(order_id int, book_id int, quantity int, dispatch_date date, foreign key(book_id) references books(book_id));
insert into books values(1,"Kalila And Demna",'2010-01-01'),(2, "28 Letters",'2012-05-12'),(3,"The Hobbit",'2019-06-10'),(4,"13 Reasons Why",'2019-06-01'),
(5,"The Hunger Games",'2008-09-21');
insert into orders3 values(1,1,2,'2018-07-26'),(2,1,1,'2018-11-05'),(3,3,8,'2019-06-11'),(4,4,6,'2019-06-05'),(5,4,5,'2019-06-20'),
(6,5,9,'2009-02-02'),(7,5,8,'2010-04-13');

select * from Books;
select * from orders3;
select b.name,b.book_id from books b inner join orders3 o on b.book_id = o.book_id where b.available_from < '2019-05-23'  and (o.dispatch_date between '2018-06-23' and '2019-06-23') group by b.book_id having sum(o.quantity) < 10;

-- Q49. Write a SQL query to find the highest grade with its corresponding course for each student. In case of a tie, 
-- you should find the course with the smallest course_id. Return the result table ordered by student_id in ascending order.
create table enrollments(student_id int, course_id int, grade int);
insert into enrollments values(2,2,95),(2,3,95),(1,1,90),(1,2,99),(3,1,80),(3,2,75),(3,3,82);
select * from enrollments;
select student_id,course_id,grade,row_number() over (partition by course_id order by grade desc) as rrank from enrollments;
with highest_grade as (select student_id,course_id,grade,row_number() over (partition by course_id order by grade desc) as rrank from enrollments)
select student_id,course_id,grade from highest_grade where rrank = 1;

-- Q50. The winner in each group is the player who scored the maximum total points within the group. 
-- In the case of a tie, the lowest player_id wins. Write an SQL query to find the winner in each group. Return the result table in any order.
create table player(player_id int primary key,group_id int);
create table matches(match_id int primary key, first_player int, second_player int, first_score int, second_score int);
insert into player values(15,1),(25,1),(30,1),(45,1),(10,2),(35,2),(50,2), (20,3),(40,3);
insert into matches values(1,15,45,3,0),(2,30,25,1,2),(3,30,15,2,0),(4,40,20,5,2),(5,35,50,1,1);
select * from player;
select * from matches;

select player_id,group_id,score from (
select player_id,group_id,score,dense_rank() over (partition by group_id order by score desc,player_id) as r from(
select p.*,case when p.player_id = m.first_player then m.first_score
				when p.player_id = m.second_player then m.second_score end as score from player p, matches m where p.player_id in (m.first_player,m.second_player)) test) test1
                where r = 1;
                
                select player_id,group_id,score,dense_rank() over (partition by group_id order by score desc,player_id) as r from(
select p.*,case when p.player_id = m.first_player then m.first_score
				when p.player_id = m.second_player then m.second_score end as score from player p, matches m where p.player_id in (m.first_player,m.second_player)) test;

