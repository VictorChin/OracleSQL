select sum(Amount_Sold)
From SH.Sales;

select Prod_ID,sum(Amount_Sold)
From SH.Sales 
Group by Prod_ID ;

Select NVL(Prod_Category,'GrandTotal'),Prod_SubCategory,
To_Char(Sum(Amount_Sold),'999,999,999.00') as TotalAmount
From 
Sales S JOIN Products P
        ON S.Prod_ID = P.Prod_ID
Group by Rollup(Prod_Category,Prod_SubCategory);

