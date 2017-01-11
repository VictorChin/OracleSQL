Select Department_Name, Count(Employee_ID) as HeadCount,
ListAgg(First_Name,'|') WITHIN GROUP (Order by First_Name)
From 
Departments D FULL Join Employees E
on D.Department_ID = E.Department_ID
Group By Department_Name;

--Customer Demograph along with Category Sales Data
With Big as
(
  Select C.Cust_Gender GENDER,
  Extract(Year from Sysdate) - C.Cust_Year_Of_Birth Age,
         C.Cust_Marital_Status Marital,C.Cust_Income_Level Income,
         Ntile(5) Over (Order By 
         Extract(Year from Sysdate) - C.Cust_Year_Of_Birth) AgeGroup ,
         P.Prod_SubCategory Subcategory,
         P.Prod_Category Category, S.Amount_Sold
  From Sales S Join Customers C ON s.Cust_ID = c.Cust_ID 
  Join Products P ON S.Prod_ID = P.Prod_ID
)
Select Category,SubCategory,GENDER,AgeGroup,
Sum(Amount_Sold) from Big Group By
Category,SubCategory,GENDER,AgeGroup
Order By 1,2,3,4
;
