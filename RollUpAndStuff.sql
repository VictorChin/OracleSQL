With Machismo as
(Select C.CUST_Gender,c.CUST_Marital_Status, Sum(Amount_sold) As TotalSales,
Grouping(c.CUST_Marital_Status) as IsRollUp
From Sh.Sales s Join Sh.Customers C on S.Cust_ID = C.Cust_id
Group by rollup(C.CUST_Gender,c.CUST_Marital_Status))
Select NVL(Cust_Gender,'Grand'), 
CASE WHEN ( CUST_MARITAL_STATUS IS NULL AND ISROLLUP=0) THEN 'N/A'
     WHEN ( CUST_MARITAL_STATUS IS NULL AND ISROLLUP=1) THEN 'Total'                 
     ELSE CUST_MARITAL_STATUS END Marital_Status,
     TotalSales
From Machismo;




--Reflexive self-join
Select Worker.First_Name || ' works under ' || Boss.First_Name
From 
Employees Worker Join Employees Boss
On Worker.Manager_ID = Boss.Employee_ID;
-- Hierarchical Query
Select RowID, First_Name,
Connect_By_Root First_Name,
Level,
SYS_CONNECT_BY_PATH(First_Name, '/')
From Employees
Start With Employee_ID = 102
Connect By Manager_ID = prior Employee_ID
Order By Level;



