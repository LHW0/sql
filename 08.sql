-- set
select employee_id, job_id
from employees
union -- 두개를 합함, 중복된것(과거의 직업을 현재에도 갖고있는사람) 제거됨 --양쪽의 칼럼개수가 동일해야함
select employee_id, job_id
from job_history;

select employee_id, job_id
from employees
union all --두개를 모두 합함
select employee_id, job_id
from job_history;

-- 과제] 과거 직업을 현재 갖고있는 사원들의 사번, 이름, 직업을 조회하라.
select employee_id, last_name, job_id
from employees e
where job_id in (select job_id
                from job_history k
                where e.employee_id = k.employee_id);
                
select e.employee_id, e.last_name, e.job_id
from employees e, job_history j
where e.employee_id = j.employee_id
and e.job_id = j.job_id;

select employee_id, job_id
from employees
intersect -- 교집합을 구한다
select employee_id, job_id
from job_history;

select employee_id, job_id
from employees
minus -- 빼기
select employee_id, job_id
from job_history;

select location_id, department_name
from departments
union
select location_id, state_province
from locations; --주명과 부서명이 뒤죽박죽 섞여있다.

-- 과제] 위 문장을, service 관점에서 고쳐라.
--      union 사용한다.
select location_id, department_name, null state
from departments
union
select location_id, null, state_province
from locations;

select employee_id, job_id, salary
from employees
union
select employee_id, job_id
from job_history;
-- 과제] 위 문장을 고쳐라.
select employee_id, job_id, salary
from employees
union
select employee_id, job_id, 0
from job_history
order by salary;