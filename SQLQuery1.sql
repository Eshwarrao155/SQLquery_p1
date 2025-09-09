use SQL_Project_1
go 
select count (*) as totalcolumns
from dbo.RetailSales;

select distinct customer_id as totalcustomer_count from dbo.RetailSales;
select distinct category as totalcustomer_count from dbo.RetailSales;


--Data analysis & Business key problems & answers
--1. Select a sql query to retrieve all columns for sales mode on '2022-11-05'

Select * from dbo.RetailSales
where sale_date = '2022-11-05';

--2. Select a sql query to retrieve all transactions where the category is 'clothing' and the quantity sold is more then 10 in the month of Nov-2022.

Select * from dbo.RetailSales
where category = 'Clothing'
and
quantiy >= 4 
and 
sale_date between '2022-11-01' and '2022-11-30';

--3. Write a SQL query to calculate the total sales (total_sales) for each category.

Select category,  count(total_sale) as categorywise, sum(total_sale) as netSale from dbo.RetailSales
Group by category;

--4. Write a sql query to find the average age of customers who purchased items from 'beauty' category. 

select AVG(age) as  average_age from dbo.RetailSales
where category = 'Beauty';

--5. Write a sql query to find all transactions where the total_sale is greater than 1000.

select * from dbo.RetailSales
where total_sale>1000;



--6. Write a sql query to find the total number of transactions (transaction_id) made by each gender in each category.

select count(total_sale) as total_transaction , category, gender from dbo.RetailSales
group by category, 
 gender; 

 --Write a SQL query to calculate the average sales for each month. Find out best selling month in each year.

select year_, month_,avg_sales 
from
(
SELECT 
    YEAR(sale_date)  AS year_,
    MONTH(sale_date) AS month_,
    AVG(CAST(total_sale AS DECIMAL(10,2))) AS avg_sales,
    RANK() OVER (
        PARTITION BY YEAR(sale_date) 
        ORDER BY AVG(CAST(total_sale AS DECIMAL(10,2))) DESC
    ) AS month_rank
FROM dbo.RetailSales
GROUP BY YEAR(sale_date), MONTH(sale_date)
) as t1
where month_rank = 1;


-- 8. Write a sql query to find top 5 cuatomers based on the highest total sales.

select top(5)customer_ID, sum(total_sale)as totalSale from dbo.RetailSales
group by customer_ID
order by totalSale DESC;

--9. Write a sql query to find the number of unique customers who purchased items from each category.

select category, count(distinct customer_id ) as totalorder from dbo.RetailSales
group by category;

--10. write a sql query to create  each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

select * from dbo.RetailSales;

Select
   case 
     when datepart(hour, sale_time) <12  then 'morning'
     when datepart(hour,sale_time) between 12 and 17 then 'Afternoon'
     else 'evening'
End as Shift,
Count (*) as OrderCount
from dbo.RetailSales
group by 
  case 
     when datepart(hour, sale_time) <12  then 'morning'
     when datepart(hour,sale_time) between 12 and 17 then 'Afternoon'
     else 'evening'
End;

--10. write a sql query to create  each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)


Select
   Case
       when Datepart(hour, sale_time) <12 then 'Morning'
       when Datepart(hour, sale_time) between 12 and 17 then 'Afternoon'
       else 'evening'
  End as Shift,
  count(*) as Number_of_orders
from dbo.RetailSales
group by 
  Case
       when Datepart(hour, sale_time) <12 then 'Morning'
       when Datepart(hour, sale_time) between 12 and 17 then 'Afternoon'
       else 'evening'
  End;


--  End of project 1