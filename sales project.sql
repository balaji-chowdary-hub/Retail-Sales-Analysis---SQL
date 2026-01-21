create database sales ;

use sales;

alter table retail_sales 
change column ï»¿transactions_id transaction_id int ;

alter table retail_sales 
change column quantiy quantity int ;

select * from retail_sales;


drop table retail_sales;

select * from retail_sales;

select * from retail_sales where sale_date = '05-11-2022';      		--  1

select * from retail_sales												--  2
where category = 'clothing'
and quantity > 3 
and sale_date between '01-11-2022' and '30-11-2022';

select category,sum(total_sale)											--  3
from retail_sales 
group by category;

select category, avg(age) as average_age  								--  4
from retail_sales
where category = 'beauty';


select * from retail_sales												--  5
where total_sale > 1000;	

select gender, count(transaction_id) as total_transactions_by_each_gender				--  6
from retail_sales 
group by gender;

select
extract(year from str_to_date(sale_date, '%d-%m-%Y')) as sale_year, 					-- 7(1)
extract(month from str_to_date(sale_date, '%d-%m-%Y')) as sale_month,
avg(total_sale) as avg_monthly_sale
from retail_sales
group by extract(year from str_to_date(sale_date, '%d-%m-%Y')), extract(month from str_to_date(sale_date, '%d-%m-%Y'))
order by sale_year, sale_month;


select sale_year, sale_month, total_monthly_sale										--  7(2)
from(
select
extract(year from str_to_date(sale_date, '%d-%m-%y')) as sale_year,
extract(month from str_to_date(sale_date, '%d-%m-%y')) as sale_month,
sum(total_sale) as total_monthly_sale,
rank() over (partition by  extract(year from str_to_date(sale_date, '%d-%m-%y'))
order by SUM(total_sale) desc) as rank_in_year
from retail_sales
group by sale_year, sale_month
) as monthly_sales
where rank_in_year = 1;

select customer_id, sum(total_sale) as total_sales						--  8
from retail_sales
group by customer_id
order by total_sales desc
limit 5;

select category, count(distinct customer_id) as unique_customers  					--  9
from retail_sales
group by category;

select 																				--  10
case
when hour(sale_time) <= 12 then 'Morning'
when hour(sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as shift,
count(transaction_id) as number_of_orders
from retail_sales
group by shift;












