-- window function has 2 segments 1. aggregated window function(sum, min, max) 2. analytic window function (rank, rownum etc)
create database win_fun;
use win_fun;

create table ineuron_student( 
student_id int,
student_batch varchar(40),
student_name varchar(40),
student_stream varchar(40),
student_marks int,
student_mail_id varchar(50));

insert into ineuron_student values(119,'fsbc' ,'Shantayya','ECE',65,'shantayya4@gmail.com');
select * from ineuron_student order by student_id desc;

show global variables like '%safe%';
set sql_safe_updates = 0
delete from ineuron_student where student_name = "Shantayya";

insert into ineuron_student values(120 ,'fsbc' , 'saurabh1','cs',65,'saurabh1@gmail.com'),
(102 ,'fsda' , 'sanket','cs',81,'sanket@gmail.com'),
(103 ,'fsda' , 'shyam','cs',80,'shyam@gmail.com'),
(104 ,'fsda' , 'sanket','cs',82,'sanket@gmail.com'),
(105 ,'fsda' , 'shyam','ME',67,'shyam@gmail.com'),
(106 ,'fsds' , 'ajay','ME',45,'ajay@gmail.com'),
(106 ,'fsds' , 'ajay','ME',78,'ajay@gmail.com'),
(108 ,'fsds' , 'snehal','CI',89,'snehal@gmail.com'),
(109 ,'fsds' , 'manisha','CI',34,'manisha@gmail.com'),
(110 ,'fsds' , 'rakesh','CI',45,'rakesh@gmail.com'),
(111 ,'fsde' , 'anuj','CI',43,'anuj@gmail.com'),
(112 ,'fsde' , 'mohit','EE',67,'mohit@gmail.com'),
(113 ,'fsde' , 'vivek','EE',23,'vivek@gmail.com'),
(114 ,'fsde' , 'gaurav','EE',45,'gaurav@gmail.com'),
(115 ,'fsde' , 'prateek','EE',89,'prateek@gmail.com'),
(116 ,'fsde' , 'mithun','ECE',23,'mithun@gmail.com'),
(117 ,'fsbc' , 'chaitra','ECE',23,'chaitra@gmail.com'),
(118 ,'fsbc' , 'pranay','ECE',45,'pranay@gmail.com'),
(119 ,'fsbc' , 'sandeep','ECE',65,'sandeep@gmail.com')

select avg(student_marks), student_batch from ineuron_student group by student_batch;
select max(student_marks), student_batch from ineuron_student group by student_batch;
select min(student_marks), student_batch from ineuron_student group by student_batch;
select sum(student_marks), student_batch from ineuron_student group by student_batch;

select count(distinct student_batch) from ineuron_student;
select student_batch, count(*) from ineuron_student group by student_batch;

select * from ineuron_student where student_batch = 'fsda' order by student_marks desc;
select * from ineuron_student where student_batch = 'fsda' order by student_marks desc limit 1,1  --limit starting index, from starting index no. of records to fetch
-- above query will fail if we want 3rd highest marks records bcz there are multiple records with 3rd highest marks.
-- analytic window function (rownum, rank, denserank etc)
select student_id, student_name, student_batch, student_marks, row_number() over (order by student_marks desc) as 'row_number' from ineuron_student;  -- query will create a window

-- window can be partioned based on condition 
select *, row_number() over (partition by student_batch order by student_marks) as 'row_num' from ineuron_student;

-- fetch records of topper from every batch
select * from (select *, row_number() over (partition by student_batch order by student_marks desc) as 'row_num' from ineuron_student) as test where row_num = 1;
-- above query will also fail when multiple students have same max marks

select *, rank() over (partition by student_batch order by student_marks desc) as 'row_rank' from ineuron_student;
-- issue with rank() is when conseqative same rank then it skips next rank and takes row number as next rank 

select * from (select *, rank() over (partition by student_batch order by student_marks desc) as 'row_rank' from ineuron_student) as test where row_rank = 1;

-- dense rank will fetch records according to rank 
select *, row_number() over (partition by student_batch order by student_marks desc) as 'row_num', 
rank() over (partition by student_batch order by student_marks desc) as 'row_rank',
dense_rank() over (partition by student_batch order by student_marks desc) as 'dense_rank' from ineuron_student;

-- 2nd highest 
select * from (select *, row_number() over (partition by student_batch order by student_marks desc) as 'row_num', 
rank() over (partition by student_batch order by student_marks desc) as 'row_rank',
dense_rank() over (partition by student_batch order by student_marks desc) as 'dense_rank' from ineuron_student) as test where `dense_rank` = 2;

--- partition : to optimize query 
create database ineuron_partition;
use ineuron_partition;

create table ineuron_course(
course_name varchar(50) ,
course_id int(10) , 
course_title varchar(60),
corse_desc varchar(60),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_lauch_year int)

select * from ineuron_course;
insert into ineuron_course2 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('aiops' , 101 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) 

select * from ineuron_course;
select * from ineuron_course where course_lauch_year = 2019;  -- to get the results sql has to traverse full table to compare each row course_launch_year
-- which takes much time so we use partition for query optimization. In pertition by clause when we create table, internally multiple tables are
-- partioned according to course_launch_year or any other given condition   

create table ineuron_course1(
course_name varchar(50) ,
course_id int(10) , 
course_title varchar(60),
corse_desc varchar(60),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_lauch_year int)
partition by range (course_lauch_year)(
partition p1 values less than (2019),
partition p2 values less than (2020),
partition p3 values less than (2021),
partition p4 values less than (2022),
partition p5 values less than (2023));

drop table ineuron_course1;

select * from ineuron_course1;

select partition_name, table_name, table_rows from information_schema.partitions where table_name = 'ineuron_course1'

-- partition by hash
create table ineuron_course2(
course_name varchar(50) ,
course_id int(10) , 
course_title varchar(60),
corse_desc varchar(60),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_lauch_year int)
partition by hash (course_lauch_year)    -- partition by hash so records are inserted into partitioins based on hash generated by (course_launch_year/5)
partitions 5;

select partition_name, table_name, table_rows from information_schema.partitions where table_name = 'ineuron_course2'

-- partition by key()  --> used in built hashing MD5 algorithm for inserting values in paritition
create table ineuron_course3(
course_name varchar(50) ,
course_id int(10) primary key , 
course_title varchar(60),
corse_desc varchar(60),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_lauch_year int)
partition by key() partitions 10;

select partition_name, table_name, table_rows from information_schema.partitions where table_name = 'ineuron_course3'
insert into ineuron_course3 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('aiops' , 102 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 103 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 104 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 105, 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 106 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 107 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 108 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 109 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 110 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 1011 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 1012 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 1013 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 1014 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 1015 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019)

-- partiton by list : same as partition by range but for list 
create table ineuron_course4(
course_name varchar(50) ,
course_id int(10), 
course_title varchar(60),
corse_desc varchar(60),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_lauch_year int)
partition by list(course_lauch_year) (
partition p0 values in (2019, 2020),
partition p1 values in (2021, 2022)); 

insert into ineuron_course4 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('aiops' , 102 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 103 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 104 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 105, 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 106 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 107 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 108 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 109 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 110 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 1011 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 1012 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 1013 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 1014 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 1015 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019)

select partition_name, table_name, table_rows from information_schema.partitions where table_name = 'ineuron_course4'

-- partition by range column -- if have to consider multiple coumns for range partition
create table ineuron_course5(
course_name varchar(50) ,
course_id int(10) ,
course_title varchar(60),
course_desc varchar(80),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_lauch_year int)
partition by range columns(course_name ,course_lauch_year )(
partition p0 values less than ('aiops',2019),
partition p1 values less than ('fsds',2021),
partition p2 values less than ('MERN',2023)
)

insert ignore into ineuron_course5 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('aiops' , 102 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 103 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 104 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 105, 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 106 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 107 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 108 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 109 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 110 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 1011 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 1012 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 1013 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 1014 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 1015 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019)

-- use insert ignore if gets table has no partition for value from column_list
select partition_name, table_name, table_rows from information_schema.partitions where table_name = 'ineuron_course5'

create table ineuron_course6(
course_name varchar(50) ,
course_id int(10) ,
course_title varchar(60),
course_desc varchar(80),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_lauch_year int)
partition by list columns(course_name)(
partition p0 values  in('aiops','data analytics','Dl','RL'),
partition p1 values  in('fsds' ,'big data','blockchain'),
partition p2 values  in('MERN','java','interview prep','fsda')
)

-- partition inside partition 
create table ineuron_course7(
course_name varchar(50) ,
course_id int(10), 
course_title varchar(60),
corse_desc varchar(60),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_lauch_year int)
partition by range(course_lauch_year)
subpartition by hash(course_lauch_year)
subpartitions 5(
partition p0 values less than (2019),
partition p1 values less than (2020),
partition p2 values less than (2021),
partition p4 values less than (2022));

insert ignore into ineuron_course7 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('aiops' , 102 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 103 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 104 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 105, 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 106 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 107 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 108 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 109 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 110 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 1011 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 1012 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 1013 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 1014 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 1015 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019)

select partition_name, table_name, table_rows from information_schema.partitions where table_name = 'ineuron_course7'
