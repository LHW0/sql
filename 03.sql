--single function
--SQL(Structed Query Language)
--PL/SQL(Procedure Language/SQL) PL = SQL�� �������� ���� �����ϴ°� 

--����� �Ķ���ͷ� ���ڵ�� ���ϰ��� ���ڵ��
--�Ķ���ͷ� ���� ���ڵ� ������ ���ϳ��� �׷� ��ǵ��� �̱�����̶�� �Ѵ�.

desc dual
select * from dual; --�����Ͱ� ��ȸ ���ڵ尡 ���ϵȰ�; �̱������ ���ڵ尡 �ϳ� �ʵ尡 �ϳ�

select lower('SQL Course') --lower�� �ҹ��ڷ� �ٲ۴ٴ¶�
from dual;     --SQL�ּҹ��� select from

select upper('SQL Course')  --upper�� �빮�ڷ� �ٲ۴ٴ¶�
from dual;

select initcap('SQL Course') --initcap �������� ù���ڸ� �빮�ڷ� �ٲ۴�
from dual;

select last_name
from employees
where last_name = 'higgins'; --������ ���� ���� ��ҹ��� ������ �ǹǷ� �ҹ���,�빮�ڴ� ���� �ٸ���

select last_name
from employees
where last_name = 'Higgins'; --������ ���� ���� ��ҹ��� ������ �ǹǷ� �ҹ���,�빮�ڴ� ���� �ٸ���

select last_name
from employees
where lower(last_name) = 'higgins'; --lower�� ��Ʈ������ �ʵ尪�� �Ķ���ͷ� �������̴�.
-- �̱������ ���ڵ带 �ϳ��� ������ �ֱ⶧���� employees�� �ִ� 107���� ���ڵ带 �޾� 107�� �����Ѱ��̴�.

select concat('Hello', 'World')
from dual; --���� �ΰ��� �ٿ��� ��ȸ

select substr('HelloWorld', 2, 5)
from dual; --SQL�� index�� 1���� ����. index 2������ 5���ڸ� �����̴�. ellow

select length('Hello')
from dual; --������ ���̸� ��ȸ�Ѵ�.

select instr('Hello', 'l')
from dual; -- ó������ �߰ߵ� �Է°��� �ε����� �߰��ϰ� ������. l�� 3�� �ε������� �߰��ϰ� ����.

select instr('Hello', 'w')
from dual; -- w�� ��� 0���� ���

select lpad(salary, 5, '*') --5�ڸ��� �����ϰ� �������� ������ ä��� 
from employees;

select rpad(salary, 5, '*') --5�ڸ��� �����ϰ� �������� �������� ä��� 
from employees;

select replace('JACK and JUE', 'J', 'BL') --���ڸ� �ٲ۴�.
from dual;

select trim('H' from 'Hello') -- �Ӹ������� �Ű澲�� ���ڸ� ����. ����ִ� ���ڴ� ����.
from dual;

select trim('l' from 'Hello')
from dual;

select trim(' ' from ' Hello ')
from dual;

--����] �� query���� ' '�� trim ������ ������ Ȯ���� �� �ְ� ��ȸ�϶�
select rpad(trim(' ' from ' Hello '), 6, '*')
from dual;








