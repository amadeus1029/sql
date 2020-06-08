-- 그룹함수를 배워보자
select  avg(salary)
from    employees;

select  count(*)
from    employees;

select  count(commission_pct)
from    employees;

select  count(*),count(commission_pct)
from    employees;


select  count(*)
from    employees
where   salary>16000;


select  count(*),sum(salary),avg(salary)
from    employees;


select  avg(commission_pct),avg(nvl(commission_pct,0))
from    employees;


select  max(salary),min(salary)
from    employees;


select  department_id,round(avg(salary),0)
from    employees
group by department_id
order by department_id asc; -- 뭐 부서아이디를 빼고 출력하는 것도 가능은 하겠지만 의미가 없겠지


-- 이거 왜 되는거야? -> 그룹 내에서도 따로 직업별로 묶어주기때문에
select  department_id, job_id, count(*), sum(salary), round(avg(salary),0)
from    employees
group by department_id, job_id
order by department_id asc;


select  department_id, count(*), sum(salary)
from    employees
where   department_id = 100
group by department_id
having sum(salary)>20000;


select  employee_id,
        salary,
        case    when job_id = 'AC_ACCOUNT' then salary + salary * 0.1
                when job_id = 'SA_REP' then salary + salary * 0.2
                when job_id = 'ST_CLERK' then salary + salary * 0.3
                else salary
            end realSalary
from    employees;


-- 뭐 이렇게도 가능은 하지
select  employee_id,
        salary,
        decode( job_id, 'AC_ACCOUNT' ,salary + salary * 0.1,
                'SA_REP', salary + salary * 0.2,
                'ST_CLERK', salary + salary * 0.3,
                salary) realSalary
from    employees;


-- 문제 풀어보자
select  first_name,
        department_id,
        case    when department_id >=10 and department_id <=50 then 'A-TEAM'
                when department_id >=60 and department_id <=100 then 'B-TEAM'
                when department_id >=110 and department_id <=150 then 'C-TEAM'
                else '팀없음'
            end "팀"
from    employees;