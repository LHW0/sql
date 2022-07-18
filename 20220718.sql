select job_id, sum(salaly) "payroll"
from emplyees
where job_id not like '%REP%'
group by job_id
having sum(salary) > 13000
order by payroll;

select manager_id, min(salary)
from employees
where manager_id not like 'null'
group by manager_id
having min(salary) > 6000
order by 2 desc;

select max(avg(salary))
from employees
group by department_id;

select department_id, round(avg(salary))
from employees
group by department_id;

select sum(decode(to_char(hire_date, 'yyyy'), '2001', 1, 0)) "2001",
    sum(decode(to_char(hire_date, 'yyyy'), '2002', 1, 0)) "2002",
    sum(decode(to_char(hire_date, 'yyyy'), '2003', 1, 0)) "2003"
from employees;

select count(case when hire_date like '2001%' then 1 else null end) "2001",
        count(case when hire_date like '2002%' then 1 else null end) "2002",
        count(case when hire_date like '2003%' then 1 else null end) "2003"
from employees;

select job_id, sum(decode(department_id, 20, salary)) "20",
        sum(decode(department_id, 50, salary)) "50",
        sum(decode(department_id, 80, salary)) "80"
from employees
group by job_id;