/*
6. Using a recursive CTE (or alternative approach), find the hierarchy of staff → store manager.
   Show staff_id, staff_name, manager_id, manager_name, and level in the hierarchy.
*/
with recursive staff_hierarchy as (
    select
        s.staff_id,
        s.staff_name,
        s.manager_id,