select
    return_date::date - rental_date::date as rental_diff
from rental
limit 5;