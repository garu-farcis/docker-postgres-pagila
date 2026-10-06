/*
1. Find the top 3 most rented films in each category.
   Show category name, film title, and rental_count.
   (Hint: use RANK() or DENSE_RANK() with PARTITION BY)
*/

with ren_count as (
    select count(re.rental_id) as rental_count,
    ff.title as film_title,
    ff.film_id as ids
    from rental re left join inventory inv
    on re.inventory_id=inv.inventory_id
    left join film ff
    on inv.film_id=ff.film_id
    group by ff.film_id
),
cat_info as (
    select cat.name as category_name,
    rc.rental_count as rental_count,
    rc.film_title,
    dense_rank() over(partition by cat.category_id order by rc.rental_count desc ) as ranking
    from ren_count rc left join film_category fc
    on rc.ids=fc.film_id
    left join category cat
    on fc.category_id=cat.category_id
)

select category_name,rental_count,film_title from cat_info
where ranking<=3 
ORDER BY category_name, rental_count DESC;

