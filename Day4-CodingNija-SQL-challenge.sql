use sqlchallenge;
Create table Person (PersonId int primary key, FirstName varchar(255), LastName varchar(255));
Create table Address (AddressId int primary key, PersonId int, City varchar(255), State varchar(255));

insert into Person (PersonId, LastName, FirstName) values ('1', 'Wang', 'Allen');
insert into Address (AddressId, PersonId, City, State) values ('1', '2', 'New York City', 'New York');
-- Q7. Write a sql query for a report that provides the following
-- information for each person in the person table, regardless if there is an adress for each of those people,
-- First Name, Last Name, city, state

select p.firstname,p.lastname,a.city,a.state from person p left join address a on p.personid = a.personid;

-- Q8. Write a sql query to get the second highest salary from employeee table.
Create table If Not Exists Employeee (Id int, Salary int);

insert into Employeee (Id, Salary) values ('1', '100');
insert into Employeee (Id, Salary) values ('2', '200');
insert into Employeee (Id, Salary) values ('3', '300');

select coalesce((select salary  from employeee order by salary desc limit 1 offset 1),null) as  SecondHighestSalary;




