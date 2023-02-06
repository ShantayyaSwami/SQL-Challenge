-- stored procedure
use Scaler
select count(*) from bank_details

DELIMITER && --(delimiter sign can be anything like //, - etc)
create procedure name()
begin
--	<sql command>;
end &&
call name()   -- executing a procedure

delimiter &&
create procedure get_bankdetails()
begin
	select * from bank_details;
end &&
call get_bankdetails()

delimiter &  
create procedure get_count()
begin
	select count(*) from bank_details;
end &
call get_count()

-- parameterized procedure
DELIMITER &&
create procedure <name(IN var1 datatype, IN var2 datatype)>
begin
--	<sql command> where col = var1 and col = var2; 
end &&
call name(var1, var2)   -- executing a procedure

select * from bank_details;
delimiter &&
create procedure get_admin2(in adm varchar(30), in ln varchar(5))  --> parameters can be in, out, inout
begin
	select * from bank_details where job = adm and loan = ln;
end &&
call get_admin3('Admin.', 'no')
drop procedure get_admin2

show procedure status like '%get%';
-- there is no alter procedure syntax..to alter procedue drop procedure first and then create new one with updated query.


-- view  mysql has same syntax (end with ;)
create view bank_view as select age, job, marital, education, bal from bank_details;
select * from bank_view


--bulk insertion of data

create database if not exists dress_data;   -- my sql syntax create database fress_data if not exists
use dress_data;

create table dress (Dress_ID varchar(30),Style	varchar(30), Price	varchar(30), Rating	varchar(30), Size	varchar(30), Season	varchar(30),	
NeckLine	varchar(30), SleeveLength varchar(30),	 waiseline	varchar(30), Material	varchar(30), FabricType	varchar(30), Decoration	varchar(30),	
PatternType varchar(30), Recommendation varchar(30))

--mysql syntax
 --error if mysql running wth secure-file-priiv then remove path from secure-file-priv="" in my file at c drive-> programdata-> mysql --> update my.ini file with "secure_file_priv="" + restart service.msc mysql server
SHOW VARIABLES LIKE "secure_file_priv";

load data infile 'AttributeDataSet.csv' 
into table dress
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;


select * from dress;

--constraints auto_increament, check, not null, default, unique 
SET GLOBAL auto_increment_offset=1;  --starting valu
SET GLOBAL auto_increment_increment=2;   -- jump

create table test(test_id int auto_increment primary key, test_name varchar(30), test_mail varchar(100), test_address varchar(30)) auto_increment=100;
alter table test auto_increment=100;
insert into test(test_name,test_mail,test_address) values('Shantayya', 'shan@gmail.com', 'Pune'),('Shankar', 'shankar@gmail.com', 'banglore'),
('Somnath', 'omnath9820@gmail.com', 'Mumbai')

drop table test
select * from test;

create table test1(test_id int auto_increment not null primary key, test_name varchar(30), test_mail varchar(100), test_address varchar(30))
insert into test1 (test_name, test_mail, test_address) values('Shantayya', 'shan@gmail.com', 'Pune'),('Shankar', 'shankar@gmail.com', 'banglore'),
('Somnath', 'omnath9820@gmail.com', 'Mumbai')

create table test2(test_id int auto_increment primary key, test_name varchar(30), test_mail varchar(100), test_address varchar(30), test_salary decimal(10,2) check(test_salary > 10000.00))
insert into test3(test_name, aadhar,test_mail, test_address, test_salary) values('Shantu', '123456789143','shan2@gmail.com','Nagpur',12000),('Shankar','213212121212','shankar@gmail.com', 'banglore', 13000),
('Somnath','321231123123','omnath9820@gmail.com', 'Mumbai', 50000)

select * from test3

create table test3(test_id int auto_increment primary key, test_name varchar(30), aadhar varchar(12) unique, test_mail varchar(100), test_address varchar(30) not null default('Pune'), test_salary decimal(10,2) check(test_salary > 10000.00))
alter table test3 drop column test_id  --because we can alter existing colum to add identity so drop it and then add it with identity contraint
alter table test3 add  test_id int auto_increment primary key;
alter table test3 modify column test_id tinyint


select * from test3

alter table test3 drop column test_id;
drop table test3



