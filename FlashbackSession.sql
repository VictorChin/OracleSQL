create synonym VicBadWord for badword@chin;
select * from badword@chin;
delete from badword where wordid=1;

select * from VicBadWord;

create view VicCleanedProducts
AS 
 Select prod_Desc,
 Regexp_replace(P.Prod_Desc,B.Badword,'[removed]') 
 as Cleaned
 from Products@chin P LEFT JOIN
 BadWord@chin B On Regexp_InStr(P.Prod_Desc,B.Badword)>0
 ;
 
 select * from VicCleanedProducts;