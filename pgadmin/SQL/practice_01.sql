
/*
1. Find the top 5 customers who spent the most money in total (use payment table).
   Show customer_id, first_name, last_name and total_amount spent.
*/

select cu.customer_id, 
cu.first_name,
cu.last_name,
sum(pay.amount) as total_amount
from customer cu left join payment pay
on cu.customer_id=pay.customer_id
group by cu.customer_id,cu.first_name,cu.last_name
order by total_amount DESC limit 5;
