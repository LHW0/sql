-- subquery
-- 서브쿼리가 먼저 작동하여 그값을 메인쿼리가 받아 작동

select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel'); --서브쿼리로 아벨의 월급을 뽑아낸다.
                
-- 과제] Kochhar 에게 보고하는 사원들의 이름, 직업 조회하라
select last_name, job_id
from employees
where manager_id in (select employee_id
                        from employees
                        where last_name = 'Kochhar');
                
select last_name, job_id, salary
from employees
where job_id = (select job_id
                from employees
                where last_name = 'Ernst')
and salary > (select salary  --언스트와 직업이 같고 돈은 더 많이 받는사람 출력
                from employees
                where last_name = 'Ernst');


-- 과제] IT부서에서 일하는 사원들의 부서번호, 이름, 직업을 구해라
select department_id, last_name, job_id
from employees
where department_id = (select department_id
                        from departments
                        where department_name like 'IT');                 
                 
-- 과제] Abel과 같은 부서에서 일하는 동료들의 이름 입사일을 조회하라.
--      이름순으로 오름차순 정렬한다.
select last_name, hire_date
from employees
where department_id = (select department_id
                        from employees
                        where last_name = 'Abel')
and last_name != 'Abel'
order by 1;

select last_name, salary
from employees
where salary = (select salary
                from employees
                where last_name = 'King'); --error 킹이 두명이라서 에러 
-- =과 같은 비교연산자를 쓰려면 값이 하나여야함

select last_name, job_id, salary
from employees
where salary = (select min(salary)
                from employees);
                
select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                        from employees
                        where department_id = 50);

-- 과제] 회사 평균 월급 이상 버는 사원들의 사번, 이름 월급을 조회하라.
--      월급 오름차순 정렬
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary)
                    from employees)
order by 3 desc;
---------------------------------

select employee_id, last_name
from employees
where salary = (select min(salary)
                from employees
                group by department_id); --error 서브쿼리가 2개이상이여서
                 
select employee_id, last_name
from employees
where salary in (select min(salary)
                    from employees
                    group by department_id); --in, =any, all은 서브쿼리가 2개이상이어도 가능


-- 과제] 이름에 u가 포함된 사원이 있는 부서에서 일하는 사원들의 사번, 이름을 조회하라
select employee_id, last_name
from employees
where department_id in (select department_id
                        from employees
                        where last_name like '%u%')
order by 1;


-- 과제] 1700번 지역에 위치한 부서에서 일하는 사원들의 이름, 직업, 부서번호를 조회하라
select last_name, job_id, department_id
from employees
where department_id in (select department_id
                        from departments
                        where location_id = 1700)
order by 1;

select employee_id, last_name
from employees
where salary =any (select min(salary)
                    from employees
                    group by department_id); 
-- any는 단독으로 쓰이지않고 연산자와 함께쓰인다.

select employee_id, last_name, job_id, salary
from employees
where salary <any (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';
-- 서브쿼리의 결과값 9000,6000,4500 등등 9천보다 작거나 6천보다 작거나 4500보다 작거나

select employee_id, last_name, job_id, salary
from employees
where salary <all (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';
-- all도 any처럼 연산자에 붙어써야하며 서브쿼리의 결과값의 최소값인 4200보다 작아야한다

-- 과제] 60번 부서의 일부 사원보다 급여가 많은 사원들의 이름을 조회하라.
select last_name
from employees
where salary >any (select salary
                from employees
                where department_id = 60)
order by 1;

-- 과제] 모든 프로그래머 그리고 회사 평균 월급보다 월급을 더 받는 사원들의
--      이름, 직업, 월급을 조회하라
select last_name, job_id, salary
from employees
where salary > (select avg(salary)
                from employees)
and salary >all (select salary
                from employees
                where job_id = 'IT_PROG') --like는 와일드 카드와 함께 쓰는것
order by 1;  

select last_name
from employees
where salary = (select salary
                from employees
                where employee_id = 1); --서브쿼리가 리턴값이 없으면 메인쿼리도 없다
                
select last_name
from employees
where salary in (select salary
                from employees
                where job_id = 'IT'); --서브쿼리가 리턴값이 없으면 메인쿼리도 없다
                
--null
select last_name
from employees
where employee_id in (select manager_id
                        from employees);
                        
select last_name
from employees
where employee_id not in (select manager_id
                           from employees);
                           
-- 과제] 위 문장을 all 연산자로 refactoring 하라
select last_name
from employees
where employee_id <>all (select manager_id
                            from employees); --한놈이라도 null이면 리턴값도 모두 null
---------------------------------------

select count(*)
from departments;

select count(*)
from departments d
where exists (select * --exists 존재하다
                from employees e
                where e.department_id = d.department_id); --사원들이 있는 부서들을 뽑아낸다
                
select count(*)
from departments d
where not exists (select * --exists 존재하다
                from employees e
                where e.department_id = d.department_id); --사원들이 없는 부서들을 뽑아낸다.
                
-- 과제] 직업을 바꾼적이 있는 사원들의 사번, 이름, 직업을 조회하라
select *
from job_history;

select employee_id, last_name, job_id
from employees e
where exists ( select *
                from job_history k
                where e.employee_id = k.employee_id);