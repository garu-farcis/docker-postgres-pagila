/*
5. Identify "power customers": customers who have spent more than the average
     spending of customers in their city,
   and who have also rented more than 20 films.
   Show customer_id, full name, city, total_spent, and rental_count.
*/
with high_spenders as (
    select concat(cc.first_name,' ',cc.last_name) as full_name,
    cc.customer_id as customer_key,
    sum(pay.amount) as total_spent,
    avg(pay.amount) as avg_spent,
    cc.address_id as add_k
    from customer cc left join payment pay
    on cc.customer_id=pay.customer_id
    group by cc.customer_id
),
spending_in_city as (
    select cc.*,ci.city
    from high_spenders cc left join address aa
    on cc.add_k=aa.address_id
    left join city ci
    on ci.city_id=aa.city_id
    where cc.total_spent>cc.avg_spent

),
count_rentals as (
    select 
)