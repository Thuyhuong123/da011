--ex1--
select a.continent,floor(avg(b.population)) as avg_population from country as a
left join city as b
on a.code=b.countrycode
group by a.continent
having  floor(avg(b.population)) is not null
--ex2--
with unconfirmed as (SELECT count(b.signup_action) as not_confirmed FROM emails as a    
left join texts as b   
on a.email_id=b.email_id	
and b.signup_action='Confirmed')
select round(cast(not_confirmed as decimal)/(select count(*) from texts),2) as activation_rate
 from unconfirmed
--ex3--
SELECT b.age_bucket,
round(100.0*sum(a.time_spent) filter (where a.activity_type='send')/sum(a.time_spent),2) as send_perc,
round(100.0*sum(a.time_spent) filter (where a.activity_type='open')/sum(a.time_spent),2) as open_perc
FROM activities as a
left join age_breakdown as b  
on a.user_id=b.user_id
where a.activity_type IN ('send', 'open') 
group by b.age_bucket
--ex4--
  with supercloud as(
SELECT a.customer_id, count( distinct b.product_category) as unique_catergory FROM customer_contracts as a
left join products as b   
on a.product_id=b.product_id
group by a.customer_id)
select customer_id
from supercloud
where unique_catergory=(select count(distinct product_category) from products)
order by customer_id
--ex5--
select emp.employee_id,emp.name,count(mng.reports_to) as reports_count,round(avg(mng.age),0) as average_age  from Employees as emp
inner join Employees as mng
on emp.employee_id =mng.reports_to 
group by employee_id
--ex6--
select a.product_name, sum(b.unit) as unit
from Products as a
left join Orders as b
on a.product_id =b.product_id  
and b.order_date between '2020-02-01' and '2020-02-29'
group by product_name       
having sum(b.unit)>=100
--ex7--
SELECT a.page_id  as page_id FROM pages as a
left join page_likes as b
on a.page_id=b.page_id
where b.user_id is null
order by page_id asc
