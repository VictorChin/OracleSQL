-- Boss Says: Month Sales with 3 Month Moving Average 
-- Avg(...) Over (Order By ...)

-- Year Mon  Sales  ThreeMonthMA
-- 2004 Jan  100    100
-- 2004 Feb  200    150
-- 2004 Mar  300    200
-- 2004 Apr  400    300
WITH ABC AS(
Select T.Calendar_Year as Year,
       T.Calendar_Month_Name as Month,
       T.Calendar_Month_Number as MonthNum,
       Sum(Amount_Sold) as Sales
From Sh.Sales S Join Times T
ON T.Time_ID = S.Time_ID
Group By T.Calendar_Year,T.Calendar_Month_Name,
T.Calendar_Month_Number
Order By Year, T.Calendar_Month_Number),
DEF AS (
Select Year,Month,Sales,
round(Avg(Sales) Over
(Order by Year,MonthNum Rows Between 2 Preceding AND Current Row))
ThreeMonthMA
from ABC)
Select Year,Month,Sales,ThreeMonthMA,
To_Char((Sales/Sum(Sales) Over (Partition By Year)*100),'999.99') || '%'  
As PctOfYear
from DEF;

-- Subcategory Sales as Percentage of Category Sales
-- ex.
--Category         SubCategory           
--Electronics      Camera    3%            
--Electronics      Stereo    9%            
  Electronics      nuull     25%
--Sporting Goods   Baseball  32%           25%  
--Sporting Goods   Football  12%           25%
With CategorySales AS(
Select P.Prod_Category Category,P.Prod_SubCategory Subcategory
, Sum(Amount_Sold) as Sales
From Sales S join Products P
on S.PROD_ID = P.Prod_ID Group by P.Prod_Category,P.Prod_SubCategory
Order By 1,2)
Select  Category, Subcategory, To_Percent(Sales/
(Sum(Sales) Over (Partition By Category))) as PctSubToCat,
To_Percent(Sum(Sales) Over (Partition By Category) / Sum(Sales) Over ())
as PctCatOverall, Sales
from CategorySales;

With CategorySales AS(
Select P.Prod_Category Category,P.Prod_SubCategory Subcategory
,Sum(Amount_Sold) as Sales
From Sales S join Products P
on S.PROD_ID = P.Prod_ID Group by P.Prod_Category,P.Prod_SubCategory
Order By 1,2),
CatAgg AS ( 
Select Category,Sum(Sales) as Sales From CategorySales group by Category
)
Select  Category, Subcategory, To_Percent(Sales/
(Sum(Sales) Over (Partition By Category))) as Pct
from CategorySales 
UNION 
Select Category , Null ,To_Percent(Sales/Sum(sales) over ()) from CatAgg;




-- Top 3 Selling Product Per Category --

With ProdSales AS (
 select Prod_Category Category ,Prod_Name Product, Sum(Amount_Sold) Sales
 From Sales S Join Products P on S.Prod_ID = P.Prod_ID 
 Group By Prod_Category,Prod_Name 
 Order By 1,3 DESC), RankedSales AS (
 Select Category,Product, Sales, 
 Rank() Over (Partition By Category Order By Sales DESC) Ranking
 From ProdSales)
 Select * from RankedSales Where Ranking <=3;
-- Hint use Rank() Over (partition by .... order by ...)

CREATE OR REPLACE Function To_Percent(p_input number)
return varchar AS 
Begin
return (To_Char(P_input*100,'999.00') || '%');
End;
/
^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$

select Regexp_Substr('My Company Email is li@xyz.com, please contact me any time.',
'\w+\.?\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}') from dual;


Create Table BadWord
(WordID number(2) primary key,
 BadWord varchar(30) not null);
 insert into BadWord values(3,'\d{2,3}MB');
 commit;
 insert into BadWord values(2,'[C|DV]D-?(ROM)?');
 update badword set Badword ='(C|DV)+D-?(ROM)?'
 where wordid = 2;
 commit;
 select * from BadWord;
 
 Select prod_Desc,
 Regexp_replace(P.Prod_Desc,B.Badword,'[removed]')
 from Products P LEFT JOIN
 BadWord B On Regexp_InStr(P.Prod_Desc,B.Badword)>0
 ;
update customers
set cust_gender='F' where Cust_LAST_NAME='Colter' AND Cust_First_Name='Tobin';
commit;
