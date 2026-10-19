/*
3. Find customers who have rented films from every category that exists in the database.
   Show customer_id, first_name, last_name.
*/

with al_cat as (
   select distinct(cc.name) as unique_cats,
   (cc.category_id) as cat_id
   from category cc
),
cust_who_rent as (
   select cu.customer_id, cu.first_name, cu.last_name,fc.category_id
   from customer cu left join rental re
   on cu.customer_id=re.customer_id
   left join inventory inv 
   on re.inventory_id=inv.inventory_id
   left join film_category fc
   on inv.film_id =fc.film_id
   where re.rental_date is not null 
    group by cu.customer_id, cu.first_name, cu.last_name
    having count(distinct(fc.category_id))=(select distinct count(*) from category))

select * from cust_who_rent;