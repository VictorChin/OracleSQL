Select * from
Employees;
Select First_Name,Last_Name from
Employees;

Select 
First_Name || ' ' ||
Last_Name "Full Name",
To_Char(Hire_Date, 'fmDay, Rm Ddspth Yyyy ') ,
To_Char(Salary,'999,999,999')
from
Employees Order By Last_Name DESC;

Select lower(chr(6)), SubStr(First_Name,1,1) 
|| '. '  || Last_Name as Name
from
Employees;

select acos(0.1) from dual;
select asin(0.45) from dual;
select round(0.45,1) from dual;
select round(123456,-1) from dual;
select round(123456,-2) from dual;

Select First_name, Last_Name from Employees
Where SubStr(First_name,1,1) = 'A';
Select Extract(Year from Sysdate) from dual;
Select Extract(Month from Sysdate) from dual;
Select Extract(Day from Sysdate) from dual;
select to_char(sysdate,'Month') from dual;
Select Extract(Hour from Sysdate) from dual;
Select Extract(Minute from Systimestamp) from dual;
Select Extract(Second from Systimestamp) from dual;

select first_name,Last_name from employees
where Extract(Month from Hire_Date) IN ( 1,2,3) ;
-- Extract(Month from Hire_Date)  = 1 or 
-- Extract(Month from Hire_Date) = 2 or
--Extract(Month from Hire_Date) =3

select first_name,Last_name from employees
where Extract(Month from Hire_Date) between 1 AND 6  ;
select first_name,Last_name,to_char(Hire_date,'Month') 
from employees
where to_char(Hire_date,'fmMonth') = 'January';
select first_name,Last_name,to_char(Hire_date,'Month') 
from employees
where to_char(Hire_date,'fmMonth') like '%r';

select first_name,Last_name,to_char(Hire_date,'Month') 
from employees
where upper(Last_Name) like 'MC%';

select first_name,Last_name,to_char(Hire_date,'Month YYYY') 
from employees
where Hire_Date Between To_Date('01-Jan-2006')  --12:00AM 
                AND To_Date('01-Jan-2006');

select * from employees where
Salary >10000 AND COMMISSION_PCT IS NOT null
order by Salary DESC ;
select distinct commission_pct from employees;
select avg(distinct commission_pct) from employees;
select Min(salary) from employees;
select Max(salary) from employees;
select * from employees where salary > 
(select Avg(salary) from employees)
;
Select Job_ID,Department_ID, count(*)
from employees
group by Job_ID,Department_ID
Order by 3 DESC
;
Select To_Char(Hire_date,'Month'),Count(*) as NumOfHires
From Employees 
Group By To_Char(Hire_date,'Month') 
Order by 2 DESC
;
Select count(*) HeadCount,
--round((count(*)/107)*100,2) || '%' as Percentile,
'Total' as Whole,
To_Char(Hire_date, 'Month') MonthName,
Extract(Month from Hire_date) MonthNumber
from employees
Group By To_Char(Hire_date, 'Month'),Extract(Month from Hire_date)
Order by 4
;

Select First_Name || ' ' || Last_Name,
round((Sysdate - Hire_Date)/365.25) as Years_Served
From Employees Order by 2 DESC;

Select sysdate +  
INTERVAL '15-6' Year To Month AS BarMitzvah
from dual;

Select sysdate +  
INTERVAL '+30 12:30:45.123' Day To Second
from dual;


With Cheese AS
(Select First_Name, 
Hire_Date + interval '10' Year as TenAnni,
CASE
  WHEN  Sysdate < (Hire_Date + interval '10' Year)  THEN 'Less Than 10 Years'
  WHEN  Sysdate < (Hire_Date + interval '12' Year)  THEN 'Between 10 AND 12 Years'
  ELSE 'More Than 12 Years'
          END AS PERIOD
from Employees)
Select Period, Count(*) from Cheese Group By Period;

Select Department_ID, Sum(Salary), 
LISTAGG(FIRST_NAME || ' ' || Last_Name, ',') WITHIN GROUP (ORDER BY SALARY) AS EmpList
From Employees
Group by Department_ID;

-- Aggregate Example
SELECT RANK(5000) WITHIN GROUP
(ORDER BY salary DESC) "Rank",Department_ID
FROM employees Group By Department_ID
;
-- Analytic Example
SELECT SUM(Salary) OVER
(Order By Salary DESC,First_Name ) "RunningTotal",First_Name , Salary
FROM employees 
;
SELECT SUM(Salary) OVER
(Order By Salary DESC,First_Name ) "RunningTotal",First_Name , Salary
FROM employees 
;
Select Round(AVG(Salary) Over (Partition By Department_ID
Order By Department_ID,First_Name)) as "RunningTotal",
Department_ID,First_name, Salary
From Employees Order By Department_ID,First_Name;



