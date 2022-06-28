#select all the columns in table employee
use company_db;

select * from employee;

#select all the columns in table department
select * from department;

#fname, lname in employee   
select fname, lname from employee;

#aliases - 1
select fname as first_name, lname as last_name
from employee;

#aliases - 2
select fname first_name, lname last_name
from employee;

#select distinct
select distinct dno, sex from employee;

#info of all employee who belong to dno 5
select * from employee
where dno = 5;

#info of all emp who gets sal of atleast 30k
select * from employee
where salary >= 30000;

#get info of dep = houston & dnp is 1
select * from dept_locations
where dlocation = 'Houston' and dnumber = 1;

#get all info of male emp who are getting sal > 35000 and belongs to dept 5
select * from employee
where sex = 'M' and 
salary >= 35000 and 
dno = 5;

#get project info where plocation is houston or stafford
select * from project
where plocation = 'houston' or
plocation = 'Stafford';

select * from employee
where salary > 25000 and not 
sex = 'F' and not
dno = 1;

#fname starts with j
select * from employee
where fname like 'j%';

#in operator( replacement for multiple OR)
select *  from employee
where dno in (5,1);

#not in 
select * from employee
where dno not in (5,1);

#info of emp who sal is between 30 to 45k
select * from employee
where salary between 30000 and 45000;

#info of emp whose working hours is between 10 and 30 & belongs to pno 2 in works on table
select * from works_on
where pno = 2 and
hours between 10 and 30;

#orderby - sorting
select * from employee
where sex = 'F'
order by salary desc;

select * from works_on
order by hours desc;

#aggregation(MIN() & Max())
#select min salary of an employee
select min(salary) as min_salary, max(salary) as max_salary
from employee;

select count(super_ssn) as total, count(distinct super_ssn) as uniq
from employee;

select sum(salary), round(avg(salary),0) as total
from employee;

#date functions in aggr
#retrieve year, month from bdate of employee
select year(bdate) as 'year', month(bdate) as 'month', date(bdate) as 'date'
from employee;

select concat(fname, ' ', lname) as fullname from employee;

#substring
select substr(concat(fname, ' ', lname),2,5) as substring from employee;

#groupby
#total salary of all emp per dep
select dno, sum(salary) as total, min(salary), max(salary)
from employee
where sex = 'F'
group by dno
order by total;

#what is the total hours worked by each employee
select distinct(essn), sum(hours) as total
from works_on
group by essn
order by total;

#what is the count of people in each dept & how many male & female
select dno, sex, count(ssn)
from employee
group by dno, sex;

#limit should come always at the end
#USed select first n rows in result table
select dno, sex, count(ssn)
from employee
group by dno, sex
limit 2;

#list of top 3 employee by salary
select ssn, concat(fname, ' ', lname) as fullname, salary
from employee
order by salary desc
limit 3;


-- Having clause applied on aggregated values
-- where is used in a table whereas Having is used in a result set



-- Display the DNO of those departments that has 4 employees
select dno, count(ssn) as total
from employee
group by dno
having total = 4;

-- display the sum of salary in each dept that has salary as 55000
select sum(salary) as total, dno
from employee
group by dno
having total = 55000;

#display all the duplicate records(IDs) in the table
select super_ssn, count(super_ssn) from employee
group by super_ssn
having count(super_ssn)>1 ;

#JOINS
select concat(e.fname, ' ', e.lname) as fullname
,e.ssn
,e.dno
,e.sex
,d.*
,l.*
from employee as e
inner join department as d
on e.dno = d.dnumber
left join dept_locations as l
on d.dnumber = l.dnumber;

#subquery
#display the fname & salary of emp whose salary > avg salary of all employees

select concat(fname, ' ', lname) as fullname
,salary
from employee
where salary > (select avg(salary) from employee);

#Window functions (Ranking functions)
#rank each employee based on salary
select 
row_number() over(
		order by salary desc
        )sno,
fname,
sex,
salary,
rank() over(
		order by salary desc
        )rank1
from employee;

#partition rank by dno
select 
fname,
sex,
salary,
dno,
rank() over(
		partition by dno
        order by salary desc
        )sal_rank_bydno
from employee;

#rank working hours of each employee in works on table
select 
w.essn,
w.hours,
w.pno,
concat(e.fname, ' ', e.lname) as fullname,
rank() over(
		partition by w.pno
		order by hours desc
        )wrk_rank
from works_on as w
left join employee as e
on w.essn = e.ssn;

#LEAD (Mostly used for datediff in Ad industry / discount coupons)
select
fname,
ssn,
salary,
lead(salary,1) over(
				order by salary desc
) next_salary
from employee;

#Lag (opp of lead)
select
fname,
ssn,
salary,
lag(salary,1) over(
		order by salary desc
) next_salary
from employee;

#Case statement
select sex,fname,
case
	when sex = 'M' then 0
    else 1
end as encode
from employee;

#null value treatment
-- nvl()
-- coelsce()








