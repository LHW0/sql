--detatype conversion

select hire_date
from employees
where hire_date = '2003/06/17';

select salary
from employees
where salary = '7000';

select hire_date || ''
from employees;

select salary || ''
from employees;
-----------------------------

select to_char(hire_date)
from employees;

select to_char(sysdate,'yyyy-mm-dd') -- fm
from dual;

select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)')
from dual;

select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual;

select to_char(sysdate, 'd')
from dual;

--과제] 아래 테이블을 월요일부터 입사일순 오름차순 정렬하라.
select last_name, hire_date,
        to_char(hire_date, 'day') day
from employees
order by to_char(hire_date -1, 'd');

select to_char(sysdate, 'hh24:mi:ss am'
from dual;

select to_char(sysdate, 'DD "of" month')
from dual;

select to_char(hire_date, 'fmDD month RR') --fill mode
from employees;

--과제] 사원들의 이름, 입사일, 인사평가일을 조회하라.
--      인사평가일은 입사한 지 3개월 후 첫번째 월요일이다.
--      날짜는 YYYY.MM.DD로 표시한다.
select last_name, to_char(hire_date, 'YYYY.mm.dd') hire_date, 
        to_char(add_months(hire_date, 3), '월'), ('yyyy.mm.dd'),(next_day(add_months(hire_date, 3), '월'),'yyyy.mm.dd')
from employees;
------------------------------

select to_char(salary)
form employees;

select to_char(salary, '$99,999.99')
        ,to_char(salary, '$00,000.00')
from employees;
where last_name = 'Ernst';

select '|' || to_char(12.12, '9999.999') || '|',
        '|' || to_char(12.12, '0000.000') || '|'
from dual;

select '|' || to_char(12.12, 'fm9999.999') || '|',
        '|' || to_char(12.12, 'fm0000.000') || '|'
from dual;

select to_char(1237, 'L9999')
from dual;

--과제 <이름>earns<$,월급>monthly but wants <$,월급x3>. 로 조회하라.
select last_name || 'erans' ||
        to_char(salary, '$99,999') || 'monthly but wants ' ||
        to_char(salary * 3, '$9999,999') || '.'
from employees;
---------------------------------

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yyyy');

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'fxMon dd, yyyy'); -- format eXtract
-----------------------

select to_number('1237')
from dual;

select to_number('1,237')
from dual; -- error

select to_number('1,237.12', '9,999.99')
from dual;
---------------------------


--etc


select nvl(null, 0)
from dual;

select job_id, nvl(commission_pct, 0)
from employees;

--과제] 사원들의 이름, 직업, 연봉을 조회하라.
select last_name, job_id, salary * (1 + nvl(commission_pct, 0)) * 12 ann_sal
from employees
order by ann_sal desc;

select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees;

select first_name, last_name,
        nullif(length(first_name), length(last_name))
from employees;

select to_char(null), to_number(null), to_date(null)
from dual;

select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None') --처음으로 null이 아닌값을 리턴
from employees;

-------------------------------------

select last_name, salary,
    decode(trunc(salary / 2000),
    0, 0.00,
    1, 0.09,
    2, 0.20,
    3, 0.30,
    4, 0.40,
    5, 0.42,
    6, 0.44,
        0.45) tax_rate
from employees
where department_id = 80;  --(trunc(salary / 2000)이 기존값 0이 비교값 0.00이 리턴값

select decode(salary, 'a', 1)
from employees; --기본값은 널이기 때문에 일치하는것이없어 모두 널이 출력

select decode(salary, 'a', 1, 0)
from employees; --기본값이 0이기 때문에 일치하는것이 없어 모두 0이 출력
--'a'는 셀러리와 맞추기 위해 문자를 숫자로 변경했던걸 알수있음

select decode(job_id, 1, 1)
from employees; --error job_id와 1의 타입이 달라 에러

select decode(hire_date, 'a', 1)
from employees;

select decode(hire_date, 1, 1)
from employees; -- 하이어 데이트를 숫자로 바꾸려다가 실패해서 에러

-- 과제] 사원들의 직업, 직업별 등급을 조회하라
--      IT_PROG     A
--      AD_PERS     B
--      ST_MAN      C
--      ST_CLERK    D                  
select job_id, decode(job_id,
    'IT_PROG',    'A',
    'AD_PRES',    'B',
    'ST_MAN',     'C',
    'ST_CLEKR',   'D') grade -- 문자에는 ''붙여야한다.
from employees;

select last_name, job_id, salary,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees; --케이스로 시작해서 엔드까지가 하나의 칼럼

select case job_id when '1' then 1
                    when '2' then 2
                    else 0 
        end grade
from employees;  --기준값과 비교값 타입도 동일해야하고 then 이후의 리턴값도 타입이 동일해야함

select case salary when 1 then '1'
                    when 2 then '2'
                    else '0' 
        end grade
from employees;

select case job_id when '1' then '1'
                    when 2 then '2'
                    else '0' 
        end grade
from employees; --기준값과 비교값의 타입이달라 에러

select case job_id when 1 then '1'
                    when 2 then '2'
                    else 0 
        end grade
from employees; --error 

select case job_id when 1 then 1
                    when 2 then '2'
                    else 0 
        end grade
from employees; --error

select last_name, salary,
    case when salary < 5000 then 'low'
        when salary < 10000 then 'medium'
        when salary < 20000 then 'high'
        else 'good'
    end grade
from employees; --case 조건문 가능

--과제] 사원들의 이름, 입사일, 입사요일을 월요일부터 요일순으로 조회하라.
select last_name, hire_date, to_char(hire_date, 'fmday') day
from employees
order by case day
        when 'monday' then 1
        when 'tuesday' then 2
        when 'wednesday' then 3
        when 'thursday' then 4
        when 'friday' then 5
        when 'saturday' then 6
        when 'sunday' then 7
    end;

--과제] 2005년 이전에 입사한 사원들에게 100만원 상품권, 2005년 이후 입사한 사원들에겐 10만원
--      상품권을 지급한다.
--      사원들의 이름, 입사일, 상품권 금액을 조회하라.

select last_name, hire_date,
    case when hire_date <= '2005/12/31' then '100만원'
        else '10만원' end gift
from employees
order by gift, hire_date;