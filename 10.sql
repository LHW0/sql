--DDL(Data Definition Language)
drop table hire_dates;

create table hire_dates(
id number(8),
hire_date date default sysdate); -- 기본값(default)을 내가 지정가능

select tname
from tab; --data dictionary 오라클이 관리하고 있느 테이블 조회

-- 과제] drop table 후, 위 문장 실행 결과에서, 쓰레기는 제하고, 조회하라.
select tname
from tab
where tname not like 'BIN%';

insert into hire_dates values(1, to_date('2025/12/31'));
insert into hire_dates values(2, null);
insert into hire_dates(id) values(3); --기본값이 들어간다

commit;

select * from hire_dates;
---------------------------------------


--system로 작업해야함
-- DCL(Date Control Language) -- 시스템 유저가 실행할 수 있는 권한이 있음. 오른쪽 상단부 시스템으로 변환
-- system connection 으로 변경한다.
create user you identified by you;
grant connect, resource to you;

--you user로 작업해야함 you커넥션으로 바꾸고 생성하는 테이블은 you에 저장
select tname
from tab;

create table depts(
department_id number(3) constraint depts_deptid_pk primary key, -- depts의 디파트먼트아이디의 프라이머리키
department_name varchar2(20));

desc user_constraints

select constraint_name, constraint_type, table_name
from user_constraints;

create table emps(
employee_id number(3) primary key,
emp_name varchar2(10) constraint emps_empname_nn not null,
email varchar2(20),
salary number(6) constraint emps_sal_ck check(salary > 1000), --셀러리 1000이하면 버그
department_id number(3),
constraint emps_email_uk unique(email), --칼렴 옆에 제약조건을 설정할수도 있고 마지막에 설정도 가능
constraint emps_deptid_fk foreign key(department_id)
    references depts(department_id));
--DML은 자동으로 커밋이 안되지만 DDL은 실행시키면 자동으로 커밋

select constraint_name, constraint_type, table_name
from user_constraints;

insert into depts values(100, 'Development');
insert into emps values(500, 'musk', 'musk@gmail.com', 5000, 100);
commit;
delete depts; --error 부모테이블을 지우면 자식테이블의 값이 거짓이되기때문에 삭제 불가
--integrity 무결성 / violate위배되다

insert into depts values(100, 'Marketing'); --error, (YOU.DEPTS_DEPTID_PK) violated
insert into depts values(null, 'Marketing'); --error, cannot insert NULL
insert into emps values(501, null, 'good@gmail.com', 6000, 100); --error, cannot insert NULL
insert into emps values(501, 'label', 'musk@gmail.com', 6000, 100); --error, (YOU.EMPS_EMAIL_UK) violated
insert into emps values(501, 'able', 'good@gmail.com', 6000, 200); --error, parent key not found
-- 부모테이블인 depts에 200번 부서가 없어서 에러, 제약조건은 무결성을 확보하기위해 쓰는것

drop table emps cascade constraints; --테이블 삭제!
select constraint_name, constraint_type, table_name
from user_constraints;
-----------------------------------
--------system user
grant all on hr.departments to you; -- you가 hr의 테이블 내용을 사용가능하다.


drop table employees cascade constraints; -- 복습할때 우선실행하고 진행
create table employees(
employee_id number(6) constraint emp_empid_pk primary key, -- 테이블에서 프라이머리키는 한개만 존재
first_name varchar2(20),
last_name varchar2(25) constraint emp_lastname_nn not null,
email varchar2(25) constraint emp_email_nn not null
                    constraint emp_email_pk unique, --primary key = not null + unique
phone_number varchar2(20),
hire_date date constraint emp_hiredate_nn not null,
job_id varchar2(10) constraint emp_jobid_nn not null,
salary number(8) constraint emp_salary_ck check(salary > 0),
commission_pct number(2, 2),
manager_id number(6) constraint emp_managerid_fk references employees(employee_id),
department_id number(4) constraint emp_dept_fk references hr.departments(department_id));
--------------------------------

--on delete
drop table gu cascade constraints;
drop table dong cascade constraints;
drop table dong2 cascade constraints;

create table gu (
gu_id number(3) primary key,
gu_name char(9) not null);

create table dong (
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete cascade); --복사할때는 칼럼네임을 똑같이 쓰는게 좋다.
--on delete cascade 부모가 삭제될때 나도 삭제되겠다.

create table dong2 (
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete set null); --on delete set null 부모가 삭제되면 널로 바꾸겠다
--안전하게 데이터는 남기고 추적해서 삭제해도되는지 확인

insert into gu values(100, '강남구');
insert into gu values(200, '노원구');

insert into dong values(5000, '압구정동', null);
insert into dong values(5001, '삼성동', 100);
insert into dong values(5002, '역삼동', 100);
insert into dong values(6001, '상계동', 200);
insert into dong values(6002, '중계동', 200);

insert into dong2
select * from dong;

delete gu
where gu_id = 100;

select * from dong; --구아이디가 없어져서 삼성동 역삼동 값 삭제됨
select * from dong2; --구아이디가 없어져 삼섬동 역삼동 값 null로 변함

commit;
----------------------------------

-- disable fk
drop table a cascade constraints;
drop table b cascade constraints;

create table a(
aid number(1) constraint a_aid_pk primary key);

create table b(
bid number(2),
aid number(1),
constraint b_aid_fk foreign key(aid) references a(aid));

insert into a values(1);
insert into b values(31, 1);
insert into b values(32, 9); --error, parent key not found //부모의 9가 없어 불가

alter table b disable constraint b_aid_fk; --테이블의 걸려있던 제약조건을 끊어버린것이다.
insert into b values(32, 9); -- 거짓이지만 개발은 가능하다.

alter table b enable constraint b_aid_fk; --error, parent keys not found" //살리는것이다. 하지만 9가 없어에러
alter table b enable novalidate constraint b_aid_fk; -- novalidate 앞으로 들어오는 데이터를 살펴본다.

insert into b values(33, 8); --error, parent key not found
---------------------------------------

drop table sub_departments;

create table sub_departments as
    select department_id dept_id, department_name dept_name
    from hr.departments;
    
desc sub_departments;

select * from sub_departments;
-----------------------------

drop table users cascade constraints;

create table users(
user_id number(3));

desc users

alter table users add(user_name varchar2(10)); --추가
desc users

alter table users modify(user_name number(7)); --수정
desc users

alter table users drop column user_name; --삭제
desc users
-----------------------------

insert into users values(1);

alter table users read only;--테이블을 읽기전용으로 바꾸는법
insert into users values(2); --error

alter table users read write;--읽기 쓰기로 바꾸는법
insert into users values(2);
    
commit;