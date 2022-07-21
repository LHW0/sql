-- DML(Data Manipulation Language)

--table을 없애는 명령어 drop
drop table emp; --emp 테이블을 없애겠다.
drop table dept;

--table 생성하는 명령어 create
create table emp ( 
employee_id number(6),
first_name varchar2(20), --varchar2 글자의 자리수 지정
last_name varchar2(25),
email varchar2(25),
phone_number varchar2(20),
hire_date date,
job_id varchar2(10),
salary number(8),
commission_pct number(2, 2),
manager_id number(6),
department_id number(4)); --괄호안에 테이블의 구조를 집어넣는다

create table dept (
department_id number(4),
department_name varchar2(30),
manager_id number(4),
location_id number(4)); --테이블 생성

insert into dept(department_id, department_name, manager_id, location_id) --dept안에 있는 필드를 지정한것 
-- 순서변경 가능
values (300, 'Public Relation', 100, 1700);

insert into dept(department_id, department_name)
values (310, 'Purchasing');

-- 과제] row 2건이 insert 성공했는 지, 확인하라.
select * from dept; --인서트할때 필드값 입력안하면 null값 입력, 로우하나가 데이터하나

commit; --★★메모리에 있던 데이터들이 디스크에 저장된다. !!!무조건 마지막에 커밋해야함
--transaction 테이블생성부터, 추가, 커밋까지의 과정을 통틀어 말한다. DML업무의 시작부터 끝까지의 과정이 트랜스액션
-------------------
insert into emp(employee_id, first_name, last_name, email, phone_number,
                hire_date, job_id, salary, commission_pct, manager_id, department_id)
values (300, 'Louis', 'Pop', 'Pop@gmail.com', '010-378-1278',
        sysdate, 'AC_ACCOUNT', 6900, null, 205, 110);

insert into emp --필드개수와 
values (310, 'Jark', 'Klein', 'Klein@gmail.com', '010-753-4635',
        to_date('2022/06/15', 'YYYY/MM/DD'), 'IT_PROG', 8000, null, 120, 190);

insert into emp
values (320, 'Terry', 'Benard', 'Benard@gmail.com', '010-632-0972',
        '2022/07/20', 'AD_PRES', 5000, .2, 100, 30);

commit;

------------------
drop table sa_reps;--error

create table sa_reps(
id number(6),
name varchar2(25),
salary number(8, 2),
commission_pct number(2, 2));

insert into sa_reps(id, name, salary, commission_pct)
    select employee_id, last_name, salary, commission_pct
    from employees
    where job_id like '%REP%'; --레코드 값이 동일하다면 다른 테이블의 로우(row)를 가져올 수 있다.
commit;

select *
from sa_reps;

declare
    base number(6) := 400;-- 넘버타입의 변수선언 후 초기값 400을 둠
begin
    for i in 1..10 loop
        insert into sa_reps(id, name, salary, commission_pct)
        values(base + i, 'n' || (base + i), base * i, i * 0.01);
    end loop;
end;
/

select * from sa_reps;

--과제] procedure 로 insert 한 row들을 조회하라.
select * 
from sa_reps
where id > 400;
-----------------------------------

select employee_id, salary, job_id
from emp
where employee_id = 300;

update emp --기존의 필드값을 변경하는것
set salary = 9000, job_id = null
where employee_id = 300;

commit;

update emp
set job_id = (select job_id
                from employees
                where employee_id = 205),
    salary = (select salary
                from employees
                where employee_id = 205)
where employee_id = 300;

select job_id, salary
from emp
where employee_id = 300;

rollback; --트랜스액션 취소(복구)

select job_id, salary
from emp
where employee_id = 300;

update emp
set (job_id, salary) = (
    select job_id, salary
    from employees
    where employee_id = 205)
where employee_id = 300; --서브쿼리 이렇게도 쓸 수 있다.
commit;
-----------------------------------

delete dept
where department_id = 300;

select *
from dept;

rollback; -- 현재 메모리상에서 지우고 바꾸고있기때문에 가능한거다.

select *
from dept;

delete emp
where department_id = (
    select department_id
    from departments
    where department_name = 'Contracting');
    
select *
from emp;

rollback;

select *
from emp;

delete emp
where department_id = (
    select department_id
    from departments
    where department_name = 'Contracting');

select *
from emp;
commit;