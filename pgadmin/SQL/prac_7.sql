/*
6. Using a recursive CTE (or alternative approach), find the hierarchy of staff → store manager.
   Show staff_id, staff_name, manager_id, manager_name, and level in the hierarchy.
*/

with recursive show_hierar as (
    select ss.staff_id as ids,
    concat(ss.first_name,' ',ss.last_name) as full_name,
    st.manager_id
    from staff ss left join store st
    on ss.store_id=st.store_id
)