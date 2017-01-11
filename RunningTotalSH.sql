With Pizza as (Select T.Calendar_Year,t.CALENDAR_QUARTER_NUMBER AS Quarter,
Sum(Amount_Sold) as AmountSold
From 
Sales s join Times t on s.Time_ID = T.Time_ID
Group by  t.Calendar_Year,t.CALENDAR_QUARTER_NUMBER
Order By 1,2)
Select Calendar_Year,Quarter,AmountSold,
Sum(AmountSold) Over( Partition By Calendar_Year Order by Calendar_Year,Quarter)
as RunningTotal,
AmountSold - Lag(AmountSold,1) 
Over ( Order By Calendar_Year,Quarter) as "QoQGrowth",
AmountSold - Lag(AmountSold,4) 
Over ( Order By Calendar_Year,Quarter) as "YoYQGrowth"
From Pizza Order By 1,2
