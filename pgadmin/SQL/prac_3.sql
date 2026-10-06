/*
2. Calculate the month-over-month growth rate of total payment amount.
   Show year_month, total_amount, previous_month_amount, and growth_percentage.
*/
with monthly_total as (
    select sum(amount) as total,
    extract(MONTH FROM payment_date) as pay_month,
    extract(year from payment_date) as years
    from payment
    group by extract(year from payment_date),extract(MONTH FROM payment_date)
),
 prev_month as (
    select mt.total,
    mt.pay_month,
    concat(mt.years,' ',mt.pay_month) as year_months,
    lag(mt.total) over (order by (mt.years,mt.pay_month) ) as previous_month_tot
    from monthly_total mt
)

select total,year_months,previous_month_tot,
round((total-previous_month_tot/previous_month_tot)*100,2) as growth_percentage
from prev_month;