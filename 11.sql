--view
--hr user
--★query 에 붙인 별명이 view //view는 데이터를 갖고있지 않다.

drop view empvu80; --view 가상테이블로 부르기도 한다.

create view empvu80 as -- 80번부서에서 일하는 사람들
    select employee_id, last_name, department_id
    from employees
    where department_id = 80; --empvu80이라는 별명으로 생성
    
desc empvu80 --셀렉트절의 칼럼이 view의 구조가된다.

select * from empvu80;
--아래 위가 같다// 원래는 아래같이 써야할 거를 별명붙여서 위처럼 씀
select * from (
    select employee_id, last_name, department_id
    from employees
    where department_id = 80);

create or replace view empvu80 as --원래 있으면 리플레이스 없으면 크리에이트
    select employee_id, job_id
    from employees
    where department_id = 80; --위에 원래 생성한게 있었으므로 내용 수정됨.
    
desc empvu80; 

--과제 50번 부서원들의 사번, 이름, 부서번호로 만든 DEPT50 view를 만들어라
--    view 구조는 EMPNO, EMPLOYEE, DEPTNO 이다.
--    view를 통해서 50번 부서 사원들이 다른 부서로 배치되지 않도록 한다.
create or replace view dept50(empno, employee, deptno) as
    select employee_id, last_name, department_id
    from employees
    where department_id = 50
    with check option constraint dept50_ck;

--과제 DEPT50 view의 구조를 조회하라.
desc dept50

--과제 DEPT50 view의 data를 조회하라.
select * from dept50;
---------------------------
drop table teams;
drop view team50;

create table teams as
    select department_id team_id, department_name team_name
    from departments; -- 테이블 생성
    
create view team50 as
    select *
    from teams
    where team_id = 50; --50번 팀아이디만 뷰되도록 생성
    
select * from team50; 
    
select count(*) from teams;
insert into team50
values(300, 'Marketing');
select count(*) from teams; --teams 테이블에 인서트 한것이다

create or replace view team50 as
    select *
    from teams
    where team_id = 50
    with check option; --뷰에다 붙이는 제약조건

insert into team50 values(50, 'IT Support'); --추가
select count(*) from teams;
insert into team50 values(301, 'IT support'); --error ,view WITH CHECK OPTION where-clause violation
-- 위의 팀아디는 50인데 지금 바로위는 301이기때문에 달라서 에러

create or replace view empvu10(employee_num, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    with read only; --읽기전용으로 만드는 제약조건

insert into empvu10 values(501, 'able', 'Sales'); --error ,cannot perform a DML 읽기전용이라 인서트x
---------------
--view는 query의 별명

drop sequence team_teamid_seq;

create sequence team_teamid_seq;

select team_teamid_seq.nextval from dual;
select team_teamid_seq.nextval from dual;
select team_teamid_seq.currval from dual;

insert into teams
values(team_teamid_seq.nextval, 'Marketing');

select * from teams
where team_id = 3;

create sequence X_xid_seq
    start with 10
    increment by 5
    maxvalue 20
    nocache
    nocycle;

select x_xid_seq.nextval from dual; --nocycle 효과를 경험한다.

--과제 dept 테이블의 deptid 칼럼의 field value로 사용할 sequence를 만들어라
--      sequence는 400이상, 1000이하로 생성한ㄷ. 10씩 증가한다.
create sequence dept_deptid_seq
    start with 400
    increment by 10
    maxvalue 1000;
    
--과제 위 sequence 로, DEPT 테이블에서, Education 부서를 insert하라.
insert into dept(deparment_id, department_name)
values(dept_deptid_seq.nextval, 'Education');

commit;
---------------------------

drop index emp_lastname_idx;

create index emp_lastname_idx
on employees(last_name);

select last_name, rowid
from employees
where rowid = 'AAAEAbAAEAAAADNABK';

select index_name, index_type, table_owner, table_name
from user_indexes;

-- 과제] DEPT 테이블의 DEPARTMENT_NAME 에 대해 index를 만들어라.
drop index dept_departname_idx;

create index dept_departname_idx
on departments(department_name);
--------------------------------

drop synonym team;

create synonym team
for departments;

select * from team;

--과제 EMPLOYEES 테이블에 EMPS synonym 을 만들어라.
create synonym emps
for employees;

drop synonym emps;