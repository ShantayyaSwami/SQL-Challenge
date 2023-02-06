set global max_allowed_packet = 209715200
use sales;
select * from sales1;

delimiter && 
create function add_to_col(a int) 
returns int
deterministic
begin
	declare b int ;
    set b = a + 10 ;
    return b ;
end &&

select add_to_col(10)   -- calling a function 

select quantity, add_to_col(quantity) from sales1;

delimiter && 
create function final_profits(profit float, dis float)
returns float
deterministic
begin
	declare final_profit float;
    set final_profit = profit - ((profit*dis)/100);
    return final_profit;
end &&

select profit, discount, final_profits(profit, discount) as final_profit from sales1;
drop function final_profits;

---writing a finction to accept int input and return varchar
delimiter %%
create function int_to_var(profit int)
returns varchar(30)
deterministic
begin
	declare prft varchar(30);
    set prft = profit;
    return prft;
end %%

select int_to_var(profit) as prft from sales1;

select sales,
case when sales between 1 and 100 then "Super affordable product"
	 when sales between 101 and 300 then "Affordable"
     when sales between 301 and 600 then "Moderate price"
     else "Expensive"
end as pricing
from sales1;

--creating UDF (user defined functions) 
--function --> perform action on given data
--procedure --> executes reusable select sql statements

delimiter &&
create function mark_sales1(sales varchar(20))
returns varchar(100)
deterministic
begin
	declare pricng varchar(100);
	if sales < 100 then
		set pricng = "affordable product";
	elseif sales > 100 and sales < 300 then
		set pricng = "Affordable";
	elseif sales > 300 and sales < 600 then
		set pricng = "Moderate price";
	else
		set pricng = "Dear";
	end if ;
	return pricng ;
end &&

select mark_sales1(sales) from sales1;

alter table sales1 modify pricing varchar(100)

show global variables like "%safe%"
set sql_safe_updates = 0

update sales1 set pricing = mark_sales1(sales)

create table loop_table(val int);

-- creating procedure to insert data in table using loop
delimiter &&
create procedure loop_proc()
begin
set @var = 10;
loop_data : loop
insert into loop_table values (@var);
set @var = @var + 1;
if @var = 100 then
	leave loop_data;
end if;
end loop loop_data;
end &&

call loop_proc()
select * from loop_table;

-- Create a loop for a table to insert a record into a table for two columns in first coumn you have to inset a data ranging from 1 to 100 and in second column you hvae to inset a square of the first column 
create table task1_SQL5(num int, sqr int);
select * from task1_SQL5;

delimiter &&
create procedure add_num()
begin
set @var = 1;
set @sqr = 1;
num_loop: loop
insert into task1_SQL5 values (@var, @sqr);
set @var = @var + 1;
set @sqr = @var * @var ;
if @var = 101 then
	leave num_loop;
end if;
end loop num_loop;
end &&

call add_num();
delete from task1_SQL5;
select * from task1_SQL5;

--task2 create a user defined function to find out a date differences in number of days 

select order_date_new, ship_date_new from sales1;
select datediff(ship_date_new,order_date_new) as diff from sales1;

--task3 create a UDF to find out a log base 10 of any given number 

delimiter &&
create function cal_log(num float)
returns float
deterministic
begin
	declare logg float;
    set logg = log2(num);
    return logg;
end &&

select cal_log(20)


