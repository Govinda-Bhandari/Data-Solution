with solution as (select *, rank() over (partition by month order by total_amount desc) as highest_total
from
(select month(invoicedate) as month ,
round(sum(unitprice*quantity),2) as total_amount,description
from Retail_Store
group by month(invoicedate),description ) subquery)

select month, description,total_amount
from solution
where
highest_total = 1
order by month;
