/*
5. Identify "power customers": customers who have spent more than the average
     spending of customers in their city,
   and who have also rented more than 20 films.
   Show customer_id, full name, city, total_spent, and rental_count.
*/
with high_spenders as (
    select concat(cc.first_name,' ',cc.last_name) as full_name,
    cc.customer_id as customer_key,
    sum(pay.amount) as total_spent
    
)