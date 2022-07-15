--single function
--SQL(Structed Query Language)
--PL/SQL(Procedure Language/SQL) PL = SQL을 절차지향 언어로 포장하는것 

--펑션은 파라미터로 레코드고 리턴값도 레코드다
--파라미터로 들어온 레코드 개수가 딱하나인 그런 펑션들을 싱글펑션이라고 한다.

desc dual
select * from dual; --데이터값 조회 레코드가 리턴된것; 싱글펑션은 레코드가 하나 필드가 하나

select lower('SQL Course') --lower가 소문자로 바꾼다는뜻
from dual;     --SQL최소문법 select from

select upper('SQL Course')  --upper은 대문자로 바꾼다는뜻
from dual;

select initcap('SQL Course') --initcap 각글자의 첫글자를 대문자로 바꾼다
from dual;

select last_name
from employees
where last_name = 'higgins'; --데이터 안의 값은 대소문자 구분이 되므로 소문자,대문자는 서로 다른값

select last_name
from employees
where last_name = 'Higgins'; --데이터 안의 값은 대소문자 구분이 되므로 소문자,대문자는 서로 다른값

select last_name
from employees
where lower(last_name) = 'higgins'; --lower가 라스트네임의 필드값을 파라미터로 받은것이다.
-- 싱글펑션은 레코드를 하나만 받을수 있기때문에 employees에 있는 107개의 레코드를 받아 107번 실행한것이다.

select concat('Hello', 'World')
from dual; --글자 두개를 붙여서 조회

select substr('HelloWorld', 2, 5)
from dual; --SQL은 index가 1부터 시작. index 2번부터 5글자를 뜯어낸것이다. ellow

select length('Hello')
from dual; --글자의 길이를 조회한다.

select instr('Hello', 'l')
from dual; -- 처음으로 발견된 입력값의 인덱스를 발견하고 끝낸다. l을 3의 인덱스에서 발견하고 끝냄.

select instr('Hello', 'w')
from dual; -- w가 없어서 0으로 출력

select lpad(salary, 5, '*') --5자리로 제한하고 랜덤값이 왼쪽을 채운다 
from employees;

select rpad(salary, 5, '*') --5자리로 제한하고 랜덤값이 오른쪽을 채운다 
from employees;

select replace('JACK and JUE', 'J', 'BL') --글자를 바꾼다.
from dual;

select trim('H' from 'Hello') -- 머리꼬리만 신경쓰며 글자를 뜯어낸다. 가운데있는 글자는 못뜯어냄.
from dual;

select trim('l' from 'Hello')
from dual;

select trim(' ' from ' Hello ')
from dual;

--과제] 위 query에서 ' '가 trim 됐음을 눈으로 확인할 수 있게 조회하라
select rpad(trim(' ' from ' Hello '), 6, '*')
from dual;








