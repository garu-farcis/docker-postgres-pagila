/*
6. Using a recursive CTE (or alternative approach), find the hierarchy of staff → store manager.
   Show staff_id, staff_name, manager_id, manager_name, and level in the hierarchy.
*/
with recursive staff_hierarchy as (
    select
        s.staff_id,
        s.staff_name,
        s.manager_id,
        m.staff_name as manager_name,
        1 as level
    from staff s
    left join staff m
    on s.manager_id = m.staff_id

    union all
    select
        sh.staff_id,
        sh.staff_name,
        m.manager_id,
        sm.staff_name as manager_name,
        sh.level + 1
    from staff_hierarchy sh
    join staff m
        on sh.manager_id = m.staff_id
    left join staff sm
        on m.manager_id = sm.staff_id
        )
select
    staff_id,
    staff_name,
    manager_id,
    manager_name,
    level
from staff_hierarchy
order by staff_id, level;