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

--����] �Ʒ� ���̺��� �����Ϻ��� �Ի��ϼ� �������� �����϶�.
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

--����] ������� �̸�, �Ի���, �λ������� ��ȸ�϶�.
--      �λ������� �Ի��� �� 3���� �� ù��° �������̴�.
--      ��¥�� YYYY.MM.DD�� ǥ���Ѵ�.
select last_name, to_char(hire_date, 'YYYY.mm.dd') hire_date, 
        to_char(add_months(hire_date, 3), '��'), ('yyyy.mm.dd'),(next_day(add_months(hire_date, 3), '��'),'yyyy.mm.dd')
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

--���� <�̸�>earns<$,����>monthly but wants <$,����x3>. �� ��ȸ�϶�.
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

--����] ������� �̸�, ����, ������ ��ȸ�϶�.
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
    coalesce(to_char(commission_pct), to_char(manager_id), 'None') --ó������ null�� �ƴѰ��� ����
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
where department_id = 80;  --(trunc(salary / 2000)�� ������ 0�� �񱳰� 0.00�� ���ϰ�

select decode(salary, 'a', 1)
from employees; --�⺻���� ���̱� ������ ��ġ�ϴ°��̾��� ��� ���� ���

select decode(salary, 'a', 1, 0)
from employees; --�⺻���� 0�̱� ������ ��ġ�ϴ°��� ���� ��� 0�� ���
--'a'�� �������� ���߱� ���� ���ڸ� ���ڷ� �����ߴ��� �˼�����

select decode(job_id, 1, 1)
from employees; --error job_id�� 1�� Ÿ���� �޶� ����

select decode(hire_date, 'a', 1)
from employees;

select decode(hire_date, 1, 1)
from employees; -- ���̾� ����Ʈ�� ���ڷ� �ٲٷ��ٰ� �����ؼ� ����

-- ����] ������� ����, ������ ����� ��ȸ�϶�
--      IT_PROG     A
--      AD_PERS     B
--      ST_MAN      C
--      ST_CLERK    D                  
select job_id, decode(job_id,
    'IT_PROG',    'A',
    'AD_PRES',    'B',
    'ST_MAN',     'C',
    'ST_CLEKR',   'D') grade -- ���ڿ��� ''�ٿ����Ѵ�.
from employees;

select last_name, job_id, salary,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees; --���̽��� �����ؼ� ��������� �ϳ��� Į��

select case job_id when '1' then 1
                    when '2' then 2
                    else 0 
        end grade
from employees;  --���ذ��� �񱳰� Ÿ�Ե� �����ؾ��ϰ� then ������ ���ϰ��� Ÿ���� �����ؾ���

select case salary when 1 then '1'
                    when 2 then '2'
                    else '0' 
        end grade
from employees;

select case job_id when '1' then '1'
                    when 2 then '2'
                    else '0' 
        end grade
from employees; --���ذ��� �񱳰��� Ÿ���̴޶� ����

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
from employees; --case ���ǹ� ����

--����] ������� �̸�, �Ի���, �Ի������ �����Ϻ��� ���ϼ����� ��ȸ�϶�.
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

--����] 2005�� ������ �Ի��� ����鿡�� 100���� ��ǰ��, 2005�� ���� �Ի��� ����鿡�� 10����
--      ��ǰ���� �����Ѵ�.
--      ������� �̸�, �Ի���, ��ǰ�� �ݾ��� ��ȸ�϶�.

select last_name, hire_date,
    case when hire_date <= '2005/12/31' then '100����'
        else '10����' end gift
from employees
order by gift, hire_date;