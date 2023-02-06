-- trigger is an even based action. triggers are applicable on 3 statements of insert, update and delete
-- before insert/after insert, before update/after update, before delete/after delete
create database ineuron;
use ineuron;

create table course(
course_id int,
course_desc varchar(50),
course_mentor varchar(50),
course_price int ,
course_discount int,
create_date date)

-- alter table course add create_date date;
alter table course drop column user_info;
select * from course;

create table course_update(
course_mentor_update varchar(50),
course_price_update int,
course_discount_update int)

delimiter &&
create trigger course_before_insert
before insert 
on course for each row
begin
	declare user_var varchar(50);
	select user() into user_var;
    set new.user_info = user_var;
	set new.create_date = sysdate();
end;

insert into course(course_id, course_desc, course_mentor,course_price,course_discount) values(2,'Full Stack','Hitesh Choudhari',12500,20)
select * from course;

drop trigger course_before_insert
alter table course add user_info varchar(50);

create table ref_course(record_insert_date date,record_insert_user varchar(50));

delimiter &&
create trigger course_before_insert
before insert 
on course for each row
begin
	declare user_var varchar(50);
	select user() into user_var;
    set new.user_info = user_var;
	set new.create_date = sysdate();
    insert into ref_course values(sysdate(),user_var);
end; 

select * from ref_course;

create table test1(
c1 varchar(50),
c2 date,
c3 int);


create table test2(
c1 varchar(50),
c2 date,
c3 int );


create table test3(
c1 varchar(50),
c2 date,
c3 int );

show global variables like '%safe%'
set sql_safe_updates=0

insert into test1 values('shre',sysdate(),2);
select * from test1;
select * from test2;
select * from test3;

delimiter &&
create trigger before_insert_test
before insert 
on test1 for each row
begin
		insert into test2 values('Shan',sysdate(),1);
        insert into test3 values('Shan',sysdate(),1);
end;

delimiter &&
create trigger before_insert_test_table
after insert 
on test1 for each row
begin
		update test2 set c1 = 'abc' where c1 = 'Shan';
        delete from test3 where c1 = 'Shan';
end;

---Normalization (1NF, 2NF, 3NF, BCNF, 4NF, 5NF and 6NF)
-- we always use normalization concepts (atleast til 3NF) while designing db to reduce the data redundancy 
-- 1NF : 1. first Normal form: all records(full row) in table should be unique
--		 2. each table cell should contain one value (X contain list,tuple or dict)

-- 2NF: 1. Apply 1NF
	----2. single column primary key does not functionally depend on any subset of candidate key (X have pk with >2 col) 

-- 3NF : 1. Apply 2NF
	-- 	 2. It should not have any kind of transitive functional dependancy between non-key col (example: 2 non-key col should not have any dependancy.
    -- if we are changing any non-key col then there is possibility that we have ti chnage other non-key col due to its dependancy with changed col)
    
-- BCNF: Boyce codd normal form: also called 3.5NF
-- 1. Apply 3NF
-- 2. Db will keep generating anamlies if it have more than one candidate key

-- industry follows till 3NF

--- pivoting : means converting rows to col and vise versa. mysql dont have any pivot function. we need to manually create it. 
-- ms sql server have pivot function

    
    

