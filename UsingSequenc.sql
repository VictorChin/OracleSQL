--desc Departments;
insert into Departments( Department_id , Department_name)
values(Departments_Seq.NextVal,'QC');

update employees set department_id = Departments_Seq.CurrVal
Where Employee_id = 178;
commit;
--178 --

select * from employees;


--- 


