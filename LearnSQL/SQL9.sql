-- Date function
select curdate();   -- select current date
select curtime();	-- current time

select now();		-- gives current date and time

select date(now());	-- extract the date,time,day,week, month,quarter,year part of date and time expresson from table

select day('1996-09-26 16:44:15.581');
select extract(day from '1996-09-26 16:44:15.581') as `day`;	-- extract second, minute, hour, day, week, month, quarter, year from date

select extract(month from '1996-09-26 16:44:15.581') as `month`;
select extract(week from '1996-09-26 16:44:15.581') as `week`;
select extract(quarter from '1996-09-26 16:44:15.581') as `quarter`;

select dayofweek(now());	-- gives day of week in number

select date_add('1991-11-04 16:44:15.581', interval 31 year) as birthdate;	-- number of interval when want to add to date

select date_sub('2022-11-04', interval 1 year);			-- when want to substract number of interval from date or time

select date_format(now(), '%a'); -- gives date and time in diff format
select date_format(now(), '%W');	-- %a -- gives abbrevated weekday name %W gives fullname
select dayname(now());

select date_format(now(), '%b');	-- %b abbrevated month name
select date_format(now(), '%M');	-- %M full month name
select date_format(now(), '%m');	-- get ,month in numeric(1-12)

select date_format(now(), '%D');	-- day of month in english suffix
select date_format(now(), '%d');	-- day in number
select date_format(now(), '%j');	-- get day of year (out of 365 days)

select date_format(now(), '%H');	-- get hour in 24 hrs format
select date_format(now(), '%h');    -- get hours in 12 hrs format

select date_format(now(), '%r');	-- get time in 12 hrs
select date_format(now(), '%T');	-- get time in 24 hrs

select date_format(now(), '%i');	-- get minute

select date_format(now(), '%Y');	-- get year in 4 digit format
select date_format(now(), '%y');    -- get year in 2 digit format

select from_days(738908);			-- return date from number 
select last_day('2023-01-23');	-- returns last day of month

select makedate(2023,23);		-- makes the date from given year and number of days
select to_days(now());			-- gives number from date




