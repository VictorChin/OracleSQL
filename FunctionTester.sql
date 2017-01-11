CREATE OR REPLACE FUNCTION GETSALARYDIFFBYDEPT 
( p_input IN NUMBER,p_sal in number)  RETURN NUMBER AS 
v_dept_avg_salary number:=0;
BEGIN

select round(avg(salary)) into v_dept_avg_salary 
 from Employees where
          department_id IN (Select Department_ID from Employees
          where Employee_ID = p_input);
          


 RETURN (p_sal - v_dept_avg_salary);
END GETSALARYDIFFBYDEPT;