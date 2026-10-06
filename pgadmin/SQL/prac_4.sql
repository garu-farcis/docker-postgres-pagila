/*
3. Find customers who have rented films from every category that exists in the database.
   Show customer_id, first_name, last_name.
*/
with cust_info as (
    select cc.customer_id as cust_key,
    cc.first_name,
    cc.last_name,
    count(re.rental_id) as rental_count
    from customer cc inner join rental re 
    on cc.customer_id=re.customer_id
    group by cc.customer_id,cc.first_name,cc.last_name

),
 cat_check as (
    select cc.cust_key,
    cc.first_name,
    cc.last_name
    from cust_info cc inner join rental re
    on cc.cust_key=re.customer_id
    inner join inventory inv
    on inv.inventory_id=re.inventory_id
    inner join film_category fc
    on inv.film_id=fc.film_id
    group by cc.cust_key,
    cc.first_name,
    cc.last_name
    having count(distinct fc.category_id)=(select count(*) from category)

)
select * from cat_check;