-- we can create table from csv file using csvkit tool --> mysql specific 
--1. goto cmd install csvkit <pip install csvkit>
--2. csvsql --dialect mysql --snifflimit 100000 sales_data_final.csv > output_sales_data.sql
--> 3. load bulk data

create database if not exists sales;
use sales

use sales
CREATE TABLE sales1 (
	order_id VARCHAR(15) NOT NULL, 
	order_date VARCHAR(15) NOT NULL, 
	ship_date VARCHAR(15) NOT NULL, 
	ship_mode VARCHAR(14) NOT NULL, 
	customer_name VARCHAR(22) NOT NULL, 
	segment VARCHAR(11) NOT NULL, 
	state VARCHAR(36) NOT NULL, 
	country VARCHAR(32) NOT NULL, 
	market VARCHAR(6) NOT NULL, 
	region VARCHAR(14) NOT NULL, 
	product_id VARCHAR(16) NOT NULL, 
	category VARCHAR(15) NOT NULL, 
	sub_category VARCHAR(11) NOT NULL, 
	product_name VARCHAR(127) NOT NULL, 
	sales decimal(38, 3) NOT NULL, 
	quantity DECIMAL(38, 0) NOT NULL, 
	discount DECIMAL(38, 3) NOT NULL, 
	profit DECIMAL(38, 8) NOT NULL, 
	shipping_cost DECIMAL(38, 2) NOT NULL, 
	order_priority VARCHAR(8) NOT NULL, 
	`year` DECIMAL(38, 0) NOT NULL
);

show databases;
show tables  -- list the tables 

load data infile 'sales_data_final.csv'
into table sales1
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

drop table sales1
alter table sales1 modify column sales varchar(100) NOT NULL;
select * from sales1


--mysql -> str_to_date(col_name,'%d%m%Y') used to cast col_name (which is varchar) to date formate

select * from sales1 where ship_date between '2011-01-04' and '2011-08-30'
select ship_date, str_to_date(ship_date, '%m/%d/%Y') as new_date from sales1  -- default date format YYYYMMDD

select date_format(new_date,'%D') from (select ship_date, str_to_date(ship_date, '%m/%d/%Y') as new_date from sales1) as test;
select date_format(ship_date, '%m-%d-%Y') from sales1;  -- date_format wil not work here because ship_date is varchar type

select ship_date from sales1;

alter table sales1 add order_date_new date after order_date;
update sales1 set order_date_new = str_to_date(order_date,'%m/%d/%Y');  

show variables like '%safe%'; -- because above update method giving error
set sql_safe_updates = 0

alter table sales1 add column ship_date_new date after ship_date
update sales1 set ship_date_new = str_to_date(ship_date, '%m/%d/%Y')

select date_add(now(),interval -7 day);
select date_add(now(), interval -1 week);

select * from sales1 where ship_date < date_add(now(),interval -7 day)    -- get last week data
-- mysql specific date_sub(now(), interval i week)

select * from sales1 where ship_date_new = '2011-01-05';
select * from sales1 where ship_date_new > '2011-01-05';
select * from sales1 where ship_date_new < '2011-01-05';
select * from sales1 where ship_date_new between '2011-01-05' and '2011-08-30';

select now();     -- > gives current date and time
select curdate()
select curtime()
--date_sub(date,interval value intervalv) substarct value from date intervalv can be min, hr, day, week, month, quarter, yr etc

select * from sales1 where ship_date_new < date_sub(now() , interval 1 week)
select date_sub(now(), interval 1 week);
select date_sub(now(), interval 30 day);
select date_sub(now(), interval 1 month);
select year(now())
select minute(now())
select dayname(now())
select date_sub(curdate(), interval 31 year);


alter table sales1 add flag date after order_date;

update sales1 set flag = now()   -- to update existing col values
select * from sales1


alter table sales1 add `day` tinyint 
update sales1 set year_new = year(order_date_new), `month` = month(order_date_new), `day` = day(order_date_new);

select year_new, `month`, `day` from sales1

select dayofweek(curdate()) -- gives day of week in number


select round(avg(sales),2) as average_sales, `year` from sales1 group by `year` order by `year`

select `year`, sum(sales) as total_sale from sales1 group by `year`

select (sales * discount + shipping_cost) 'discount' from sales1

select order_id,
case when exists(select * from sales1 where discount > 0.0) then 'yes' else 'no'
end as flag
from sales1

select order_id, case when discount > 0.0 then 'Yes' else 'No'
end as discount_flag from sales1

select count(*) from sales1 where discount > 0.0

alter table sales1 add discount_flag varchar(3)

update sales1 set discount_flag = case when discount > 0.0 then 'yes' else 'no' end

select discount_flag, count(discount_flag) from sales1 group by discount_flag

--assignment load data of recods > 500k
create database retail
use retail

select count(*) from retail
drop table retail

create table retail(InvoiceNo varchar(50), StockCode varchar(50), `Description` varchar(50), Quantity varchar(50), InvoiceDate varchar(50), UnitPrice varchar(50), CustomerID varchar(50),  Country varchar(50))

load data infile 'OnlineRetail.csv'
into table retail
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows

select * from retail 
alter table retail add (Invoice int, Qnt tinyint, Invdate date, UnitPrc float, CustID smallint);
alter table retail drop column Invoice, drop column Qnt, drop column Invdate, drop column Unitprc, drop column CustID;