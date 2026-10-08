/*
6. Using a recursive CTE (or alternative approach), find the hierarchy of staff → store manager.
   Show staff_id, staff_name, manager_id, manager_name, and level in the hierarchy.
*/

with recursive show_hierar as (
    -- anchor: each staff member
    select
        ss.staff_id,
        concat(ss.first_name, ' ', ss.last_name) as staff_name,
        st.manager_staff_id as manager_id,
        concat(mm.first_name, ' ', mm.last_name) as manager_name,
        1 as level
    from staff ss
    left join store st
        on ss.store_id = st.store_id
    left join staff mm
        on st.manager_staff_id = mm.staff_id

    union all

    -- recursive step
    select
        sh.staff_id,
        sh.staff_name,
        sh.manager_id,
        sh.manager_name,
        sh.level + 1
    from show_hierar sh
    where sh.manager_id is not null
)
select distinct
    staff_id,
    staff_name,
    manager_id,
    manager_name,
    level
from show_hierar;