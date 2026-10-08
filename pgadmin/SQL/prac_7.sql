/*
6. Using a recursive CTE (or alternative approach), find the hierarchy of staff → store manager.
   Show staff_id, staff_name, manager_id, manager_name, and level in the hierarchy.
*/

with recursive show_hierar as (
    select ss.staff_id as ids,
    concat(ss.first_name,' ',ss.last_name) as full_name,
    'staff' as hierarchy_
    from staff ss

    union all 

    select sh.ids as manager_id,
    sh.full_name as manager_name,
    'manager' as hierarchy_
    from show_hierar sh left join store st
    on sh.ids=st.manager_staff_id
)
select * from show_hierar;