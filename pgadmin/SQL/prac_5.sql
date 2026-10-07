/*
4. For each customer, find their longest rental duration (in days) and the film title of that rental.
   If a customer has multiple rentals with the same max duration, return any one of them.
*/

with cust_info as (
    select concat(cc.first_name,' ',cc.last_name) as customer_name,
    cast(return_date as date) - cast(rental_date as date) as rental_diff,
    cc.customer_id as cust_k
    from customer cc left join rental re
    on cc.customer_id=re.customer_id

),
longest_ren as (
    select cc.customer_name,cc.cust_k,
    (cc.rental_diff) as rental_diff,
    max(cc.rental_diff) over (partition by cc.cust_k ) as longest_rental
    from cust_info cc
),
check_rental as (
    select cc.customer_name,cc.longest_rental,cc.cust_k
    from longest_ren cc
    where cc.rental_diff=longest_rental 
    
),
film_info as (
    select cc.customer_name,cc.longest_rental,
    ff.title as film_title
    from check_rental cc left join rental re 
    on cc.cust_k=re.customer_id and
    cast(return_date as date) - cast(rental_date as date) = cc.longest_rental
    left join inventory inv
    on re.inventory_id=inv.inventory_id
    left join film ff
    on inv.film_id=ff.film_id

)

select * from film_info;