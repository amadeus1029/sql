select * from employees;

select employee_id,first_name,last_name from employees;

select first_name,phone_number,salary from employees;

--주석 달아보기
select first_name,last_name,salary,phone_number,email,hire_date from employees;

--별명 넣기
select employee_id as empNO, first_name "E-name", salary "연 봉" from employees;

select first_name "이름", phone_number "전화번호", hire_date "입사일", salary "급여" from employees;

select  first_name "이름",
    last_name "성",
    salary "급여",
    phone_number "전화번호",
    email "이메일",
    hire_date "입사일"
from employees;

/* 셀렉트문 컬럼 합치기 */
select first_name || last_name
from employees;

select first_name ||' '|| last_name as fullname
from employees;

select first_name ||'''s hire date is '|| hire_date as empinfo
from employees;

select first_name "이름", salary "월급", salary*12 "연봉"
from employees;

--문제풀기
select  first_name ||'-'|| last_name "성명",
        salary "급여",
        salary*12 "연봉",
        (salary*12+5000) "연봉2",
        phone_number "전화번호"
from employees;

--where절 사용하기
select *
from employees
where department_id=10;

select  first_name,
        salary
from    employees
where   salary>=15000;

select  first_name,
        hire_date
from    employees
where   hire_date>'07/01/01';

select  salary
from    employees
where   first_name = 'Lex';

select  first_name, salary
from    employees
where   salary<=14000 or salary>=17000;

select  *
from    employees
where   salary BETWEEN 14000 and 17000;

select  first_name, hire_date
from    employees
where   hire_date>='04/01/01' and hire_date<='05/12/31';

select  first_name , last_name, salary
from    employees
where   first_name in('Neena','Lex','John');

select  first_name, salary
from    employees
where   salary in (2100,3100,4100,5100);

--LIKE 연산자 사용해보자
select  first_name, last_name, salary
from    employees
where   first_name like 'L%';

select  first_name, last_name, salary
from    employees
where   first_name like 'L___';

select  first_name, last_name, salary
from    employees
where   first_name like '%am%';

select  first_name, last_name, salary
from    employees
where   first_name like '_a%';

select  first_name, last_name
from    employees
where   first_name like '___a%';

select  first_name, last_name
from    employees
where   first_name like '__a_';

--null을 알아보자
select  first_name,salary,commission_pct,salary*commission_pct
from    employees
where   salary BETWEEN 13000 and 15000;

select  first_name,salary,commission_pct
from    employees
where   commission_pct is null;


select  first_name, last_name, salary, commission_pct
from    employees
where   commission_pct is not null;

select  first_name, last_name
from    employees
where   manager_id is null and commission_pct is null;

--orderby 사용해보기
select  first_name, salary
from    employees
where   salary>9000
order by salary desc;

select first_name, last_name
from employees
order by first_name asc;

select  first_name, salary
from    employees
where   salary>9000
order by salary desc,first_name asc;

select  department_id, salary, first_name
from    employees
order by department_id asc;

select  first_name, salary
from    employees
where   salary>=1000
order by salary desc;

select  department_id, salary, first_name
from    employees
order by department_id asc, salary desc;