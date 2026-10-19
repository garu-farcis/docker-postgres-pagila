/*
3. Find customers who have rented films from every category that exists in the database.
   Show customer_id, first_name, last_name.
*/

with al_cat as (
   select distinct cc.name as unique_cats,
   distinct category_id as cat_id
   from category cc
),
cust_who_rent as (
   select cu.customer_id, cu.first_name, cu.last_name,cc.unique_cats
   from 
)