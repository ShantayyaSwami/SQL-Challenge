create database operations;
use operations;

create table if not exists course(
course_id int,
course_name varchar(50),
course_desc varchar(60),
course_tag varchar(50));

create table if not exists student(
student_id int,
student_name varchar(50),
student_mobile varchar(10),
student_course_enroll varchar(50),
student_course_id int);

insert into course values(101 , 'fsda' , 'full stack data analytics' , 'Analytics'),
(102 , 'fsds' , 'full stack data analytics' , 'Analytics'),
(103 , 'fsds' , 'full stack data science' , 'DS'),
(104 , 'big data' , 'full stack big data' , 'BD'),
(105 , 'mern' , 'web dev' , 'mern'),
(106 , 'blockchain' , 'full stack blockchain' , 'BC'),
(101 , 'java' , 'full stack java' , 'java'),
(102 , 'testing' , 'full testing ' , 'testing '),
(105 , 'cybersecurity' , 'full stack cybersecurity' , 'cybersecurity'),
(109 , 'c' , 'c language' , 'c'),
(108 , 'c++' , 'C++ language' , 'language')


insert into student values(301 , "sudhanshu", 3543453,'yes', 101),
(302 , "sudhanshu", 3543453,'yes', 102),
(301 , "sudhanshu", 3543453,'yes', 105),
(302 , "sudhanshu", 3543453,'yes', 106),
(303 , "sudhanshu", 3543453,'yes', 101),
(304 , "sudhanshu", 3543453,'yes', 103),
(305 , "sudhanshu", 3543453,'yes', 105),
(306 , "sudhanshu", 3543453,'yes', 107),
(306 , "sudhanshu", 3543453,'yes', 103)

select * from course;
select * from student;

select course_name, course_desc, student_id, student_name from course as c inner join student as s on c.course_id = s.student_course_id;

select course_name, course_desc, student_id, student_name from course as c left join student as s on c.course_id = s.student_course_id;
select course_name, course_desc, student_id, student_name from course as c left join student as s on c.course_id = s.student_course_id where student_id is null

select course_name, course_desc, student_id, student_name from course as c right join student as s on c.course_id = s.student_course_id;

--cross join : gives data from both tables with record mapping with all records of right table (but act as inner join if you put condition with cross join)
select course_name, course_desc, student_id, student_name from course as c cross join student as s  on c.course_id = s.student_course_id;
 
-- indexing: when we create table with indexing , we dont find any diff from user perspective but sql stores data in optimized format.

create table if not exists course1(
course_id int,
course_name varchar(50),
course_desc varchar(60),
course_tag varchar(50),
index(course_id));

insert into course1 values(101 , 'fsda' , 'full stack data analytics' , 'Analytics'),
(102 , 'fsds' , 'full stack data analytics' , 'Analytics'),
(103 , 'fsds' , 'full stack data science' , 'DS'),
(104 , 'big data' , 'full stack big data' , 'BD'),
(105 , 'mern' , 'web dev' , 'mern'),
(106 , 'blockchain' , 'full stack blockchain' , 'BC'),
(101 , 'java' , 'full stack java' , 'java'),
(102 , 'testing' , 'full testing ' , 'testing '),
(105 , 'cybersecurity' , 'full stack cybersecurity' , 'cybersecurity'),
(109 , 'c' , 'c language' , 'c'),
(108 , 'c++' , 'C++ language' , 'language')

 describe course1;  -- gives col datatypes from table
 
 -- uniue index : only allow distinct records
 -- union : combine records from both tables but col number should be same: union gives vertical join + remove duplicates 
 -- if you want duplicates then use "union all"
 
 select course_id, course_name from course union  select student_id, student_name from student;
  select course_id, course_name from course union all  select student_id, student_name from student;
  
-- CTE: common table expression: always use with claus
-- when we want to execute query on table which is outcome of other qeury then we use CTE

select * from course where course_id in (102,103,102);
with student_table as (select * from course where course_id in (102,103,106)) 
select * from student_table where course_tag = 'DS';

select * from (select * from course where course_id in (102,103,106)) as test where course_tag = 'DS';

-- recursive cte
with recursive cte(n) as 
(select 1 union all select n+1 from cte where n<5)
select * from cte

select 1 as p, 2 as q, 3 as r
union all -- append record verticlaly

with recursive cte as (
select 1 as p, 2 as q, 3 as r union all select p+1, q+1, r+1 from cte where p < 10)
select * from cte