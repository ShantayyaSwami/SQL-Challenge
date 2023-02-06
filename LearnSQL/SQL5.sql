create database primkeys;
use primkeys;

create table ineuron(course_id int primary key, course_name varchar(30), course_status varchar(20), enrol_count int);
insert into ineuron values(100, 'Data Science', 'Active', 215);
insert into ineuron values(101, 'FullStack', 'Active', 805), (102, 'DSA', 'Active', 1212),(104, 'Big Data', 'Active', 1000)

select * from ineuron;

create table student_ineuron(student_id int, course_id int, foreign key(course_id) references ineuron(course_id), student_email varchar(50), contact varchar(10));
alter table student_ineuron add student_name varchar(30) after student_id;
insert into student_ineuron values(1,'Shantayya', 100, 'shan4@gmail.com', '9168692787'),(2, 'A', 104, 'A@gmail.com', '9168692782')

select * from student_ineuron;

-- in data modelling dash line--represent weak relationship (one-to-many) and line --represnt strong relataionship (one-to-one)
-- droppin parent table wont be poassible if have dependancy 

-- multiple col can be treated as primary key
alter table student_ineuron add constraint test_prim primary key (student_id, contact);

-- on delete cascade / on update cascade -- used to delete or update records from parent if there is an association between parent and child
-- cascade says update child table when you delete records from parent

create table parent(id int primary key);
create table child(id int, parent_id int, foreign key(parent_id) references parent(id) on delete cascade on update cascade);

alter table child add constraint primary key(id);

insert into parent values(1),(2)
insert into child values(1,1),(2,2),(3,2),(4,1)

select * from parent;
select * from child;

delete from parent where id = 1;    -- have deleted records from child which were associated with id 1from parent table
drop table parent

alter table child drop primary key;
update parent set id=3 where id=2
