/*
2. Calculate the month-over-month growth rate of total payment amount.
   Show year_month, total_amount, previous_month_amount, and growth_percentage.
*/
with monthly_total as (
    select sum(amount) as total,
    customer_id as cust_key,
    extract(MONTH FROM payment_date) as pay_month,
    extract(year from payment_date) as year_months
    from payment
    order by month(payment_date)
),
with prev_month as (
    select mt.total,
    mt.pay_month,
    mt.year_months,
    mt.cust_key,
    lag(mt.total) over ( partition by mt.cust_key order by mt.pay_month ) as previous_month_tot
    from monthly_total
)

select total,year_months,cust_key,previous_month_tot,
round((previous_month_tot/count(previous_month_tot)*100),2) as growth_percentage
from prev_month;