use sqlchallenge;
CREATE TABLE IF NOT EXISTS students (
  id numeric ,
  name text NOT NULL,
  gender text NOT NULL,
  PRIMARY KEY(id)
);
-- Q3. insert below data in table and print all data
-- insert some values
INSERT INTO students VALUES (1, 'Ryan', 'M');
INSERT INTO students VALUES (2, 'Joanna', 'F');

select * from students;
insert into students values(3,'Molina','F'),(4,'Dev','M'),(5,'Reva','F');
select * from students;

-- Q.4 Country is big if area is more than 3 million or population is more than 25 million. write sql query to output big countries.
-- create a table
Create table If Not Exists World (name varchar(255), continent varchar(255), area numeric, population numeric, gdp numeric(20));

-- insert some values
insert into World (name, continent, area, population, gdp) values ('Afghanistan', 'Asia', '652230', '25500100', '20343000000');
insert into World (name, continent, area, population, gdp) values ('Albania', 'Europe', '28748', '2831741', '12960000000');
insert into World (name, continent, area, population, gdp) values ('Algeria', 'Africa', '2381741', '37100000', '188681000000');
insert into World (name, continent, area, population, gdp) values ('Andorra', 'Europe', '468', '78115', '3712000000');
insert into World (name, continent, area, population, gdp) values ('Angola', 'Africa', '1246700', '20609294', '100990000000');

select * from world;
select name, population, area from world where area > 3000000 or population > 25000000;