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



/*
문제1.
매니저가 있는 직원은 몇 명입니까? 아래의 결과가 나오도록 쿼리문을 작성하세요
*/

select  count(manager_id) "haveMngCnt"
from    employees;


/*
문제2.
직원중에 최고임금(salary)과  최저임금을 “최고임금, “최저임금”프로젝션 타이틀로 함께 출력해 보세요.
두 임금의 차이는 얼마인가요?  “최고임금 – 최저임금”이란 타이틀로 함께 출력해 보세요.
*/

select  max(salary) "최고임금",
        min(salary) "최저임금",
        max(salary) - min(salary) "최고임금 - 최저임금"
from    employees;


/*
문제3.
마지막으로 신입사원이 들어온 날은 언제 입니까? 다음 형식으로 출력해주세요.
예) 2014년 07월 10일
*/

select  to_char(max(hire_date),'YYYY"년" MM"월" DD"일"') "마지막 입사일"
from    employees;


/*
문제4.
부서별로 평균임금, 최고임금, 최저임금을 부서아이디(department_id)와 함께 출력합니다.
정렬순서는 부서번호(department_id) 내림차순입니다.
*/

select  round(avg(salary),0) "평균임금",
        max(salary) "최고임금",
        min(salary) "최저임금",
        department_id "부서아이디"
from    employees
group by department_id
order by department_id desc;


/*
문제5.
업무(job_id)별로 평균임금, 최고임금, 최저임금을 업무아이디(job_id)와 함께 출력하고
정렬순서는 최저임금 내림차순, 평균임금(소수점 반올림), 오름차순 순입니다.
(정렬순서는 최소임금 2500 구간일때 확인해볼 것)
*/

select  job_id,
        round(avg(salary),0) "평균임금",
        max(salary) "최고임금",
        min(salary) "최저임금"
from    employees
group by job_id
order by min(salary) desc, avg(salary) asc;


/*
문제6.
가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력해주세요.
예) 2001-01-13 토요일
*/

select  to_char(min(hire_date),'YYYY-MM-DD DAY') "최장근속자 입사일"
from    employees;


/*
문제7.
평균임금과 최저임금의 차이가 2000 미만인 부서(department_id), 평균임금, 최저임금
그리고 (평균임금 – 최저임금)를 (평균임금 – 최저임금)의 내림차순으로 정렬해서 출력하세요.
*/

select  department_id "부서",
        round(avg(salary),0) "평균임금",
        min(salary) "최저임금",
        round(avg(salary),0) - min(salary) "임금격차"
from    employees
group by department_id
having  round(avg(salary),0) - min(salary) < 2000
order by round(avg(salary),0) - min(salary) desc;


/*
문제8.
업무(JOBS)별로 최고임금과 최저임금의 차이를 출력해보세요.
차이를 확인할 수 있도록 내림차순으로 정렬하세요?
*/

select  job_title,
        max_salary - min_salary
from    jobs
order by max_salary - min_salary desc;


/*
문제9
2005년 이후 입사자중 관리자별로 평균급여 최소급여 최대급여를 알아보려고 한다.
출력은 관리자별로 평균급여가 5000이상 중에 평균급여 최소급여 최대급여를 출력합니다.
평균급여의 내림차순으로 정렬하고 평균급여는 소수점 첫째짜리에서 반올림 하여 출력합니다.
*/

select  manager_id "관리자",
        round(avg(salary),0) "평균급여",
        min(salary) "최소급여",
        max(salary) "최대급여"
from    employees
where   hire_date>='2005/01/01'
group by manager_id
having  avg(salary)>=5000
order by avg(salary) desc;


/*
문제10
아래회사는 보너스 지급을 위해 직원을 입사일 기준으로 나눌려고 합니다.
입사일이 02/12/31일 이전이면 '창립맴버, 03년은 '03년입사’, 04년은 ‘04년입사’
이후입사자는 ‘상장이후입사’ optDate 컬럼의 데이터로 출력하세요.
정렬은 입사일로 오름차순으로 정렬합니다.
*/

select  first_name "이름",
        case when hire_date<'03/01/01' then '창립멤버'
             when hire_date>='03/01/01' and hire_date<='03/12/31' then '03년 입사'
             when hire_date>='04/01/01' and hire_date<='04/12/31' then '04년 입사'
             else '상장이후입사'
            end optDate
from    employees
order by hire_date asc;