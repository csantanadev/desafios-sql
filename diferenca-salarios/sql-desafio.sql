with 
mx_mkt as (
            select max(e.salary) maior
            from db_employee e
            join db_dept d on (e.department_id = d.id)
            where
            d.id = 4),
mx_eng as (
            select max(e.salary) maior
            from db_employee e
            join db_dept d on (e.department_id = d.id)
            where
            d.id = 1)
select m.maior - e.maior diferenca 
from mx_mkt m
cross join mx_eng e