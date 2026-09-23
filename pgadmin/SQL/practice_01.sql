
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

/*
2. List all films that have never been rented.
   Show film_id and title.
*/

select ff.film_id,
ff.title,
re.rental_date
from film ff left join inventory inv
on ff.film_id=inv.film_id
left join rental re
on inv.inventory_id=re.inventory_id
where re.rental_date is null;

/*
3. For each film category, calculate:
   - number of films
   - average rental rate
   - average length
   Order by average rental rate descending.
*/
select cc.category_id,
    cc.name AS category,
count(ff.film_id) as no_of_films,
avg(ff.rental_rate) as avg_rentalrate,
avg(ff.length) as avg_len
from film ff left join film_category fc
on ff.film_id=fc.film_id
left join category cc
on fc.category_id=cc.category_id
group by cc.category_id,cc.name
order by avg_rentalrate desc;


/*
4. Find actors who have appeared in more than 20 films.
   Show actor_id, first_name, last_name and the number of films.
*/

select ac.actor_id,
ac.first_name,
ac.last_name,
count(ff.film_id) as no_of_films
from actor ac left join film_actor fa
on ac.actor_id=fa.actor_id
left join film ff
on fa.film_id=ff.film_id
group by ac.actor_id,
ac.first_name,
ac.last_name
having COUNT(ff.film_id)>20 
order by COUNT(ff.film_id) desc; 

/*
5. Using a CTE or subquery, find customers who have rented more films
   than the average number of rentals per customer.
   Show customer_id, first_name, last_name and their rental_count.
*/

with avg_info as (
    select count(re.rental_id) as count_rentals,
    cu.customer_id as customer_key
    from customer cu left join rental re
    on cu.customer_id=re.customer_id
    group by cu.customer_id
)
select cc.customer_id,
cc.first_name,
cc.last_name,
ai.count_rentals
from avg_info ai inner join customer cc
on ai.customer_key=cc.customer_id
group by cc.customer_id
having ai.count_rentals > (select avg(ai.count_rentals) from avg_info ai)
order by ai.count_rentals desc;

/*
6. Find the most popular film category in each store
   (based on number of rentals).
   Show store_id, category name and rental_count.
*/
with cat_rentals as (
select ss.store_id,
cc.name as category_name,
count(re.rental_id) as rental_count
from film_category fc left join category cc
on fc.category_id=cc.category_id
left join inventory inv
on fc.film_id =inv.film_id
left join rental re
on inv.inventory_id =re.inventory_id
left join store ss
on inv.store_id=ss.store_id
group by ss.store_id,cc.name
)
SELECT
    store_id,
    category_name,
    rental_count
FROM (
    SELECT
        store_id,
        category_name,
        rental_count,
        RANK() OVER (
            PARTITION BY store_id
            ORDER BY rental_count DESC
        ) AS category_rank
    FROM cat_rentals
) x
WHERE category_rank = 1;

/*
7. Calculate the running total of payments for each customer
   ordered by payment_date (use a window function).
   Show customer_id, payment_id, amount, payment_date and running_total.
*/
select cc.customer_id,
pp.payment_id, pp.amount, pp.payment_date,
sum(pp.amount) over (partition by cc.customer_id order by pp.payment_date desc rows between unbounded preceding and current row ) as running_total
from customer cc left join payment pp
on cc.customer_id=pp.customer_id
;


/*
8. Find films that have the same length as at least one other film,
   but different titles.
   Show title and length, ordered by length.
*/
with film_info as (
    select ff.length as film_length,
    ff.film_id as film_key,
    ff.title as film_title
    from film ff
)
select ff.film_key,fl.length,ff.film_title
from film fl left join film_info ff
on fl.film_id<>ff.film_key and fl.length=ff.film_length
order by fl.length desc;
/*
9. List staff members and the total amount of payments they processed.
   Include staff who have processed $0 as well (use LEFT JOIN).
   Show staff_id, first_name, last_name and total_processed.
*/

/*
10. Using a window function, rank films within each category by rental_rate
    (highest rate = rank 1).
    Show category name, film title, rental_rate and rank.
*/