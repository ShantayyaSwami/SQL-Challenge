use sqlchallenge;
show tables;
drop table city;

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
select city,length(city) as 'length' from station where length(city) = (select max(length(city)) from station);

-- Q11. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
select count(distinct city) from station where city like "E%" or city like "I%" or city like "O%" or city like "U%" or city like "A%";

select distinct city from station where city like "A%" or city like "I%" or city like "O%" or city like "U%" or city like "E%";

-- Q12. Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
select distinct city from station where city like "%a" or city like "%e" or city like "%i" or city like "%o" or city like "%u";

-- Q13. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
select count(distinct city) from station where city not in (select distinct city from station where city like "A%" or city like "I%" or city like "O%" or city like "U%" or city like "E%");

select distinct city from station where city not in (select distinct city from station where city like "A%" or city like "I%" or city like "O%" or city like "U%" or city like "E%");

-- Q14. Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
select city from station where city not in (select distinct city from station where city like "%a" or city like "%e" or city like "%i" or city like "%o" or city like "%u");

-- Q15. Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
select distinct city from station where city not in (select distinct city from station where city like "A%" or city like "I%" or city like "O%" or city like "U%" or city like "E%")
union 
select distinct city from station where city not in (select distinct city from station where city like "%a" or city like "%e" or city like "%i" or city like "%o" or city like "%u");

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
-- ● The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', and/or dash '-'. The prefix name must start with a letter.
-- ● The domain is '@leetcode.com'.
create table users(user_id int primary key, name varchar(50),mail varchar(100));
insert into users values(1,'Winston','winston@leetcode.com'),(2,'Jonathan','jonathanisgreat'),(3,'Annabelle','bella-@leetcode.com'),
(4,'Sally','sally.come@leetcode.com'),(5,'Marwan','quarz#2020@leetcode.com'),(6,'David','david69@gmail.com'),(7,'Shapiro','.shapo@leetcode.com');

select * from users;


