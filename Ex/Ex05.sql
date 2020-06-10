select  first_name,
        salary
from    employees
where   salary>(select salary
                from employees
                where first_name = 'Den')
order by salary desc;


select  first_name,
        salary,
        employee_id
from    employees
where   salary=(select min(salary)
                from employees);


select  first_name,
        salary,
        employee_id
from    employees
where   salary<(select avg(salary)
                from employees)
order by salary asc;



select  employee_id,
        first_name,
        salary
from    employees
where   salary in (select  salary
                   from    employees
                   where   department_id = '110');


-- join이랑 같이 써보자
select  em.first_name,
        em.salary,
        de.department_name
from    employees em, departments de
where   em.department_id = de.department_id
  and     (em.department_id, em.salary) in (select    department_id,
                                                      max(salary)
                                            from    employees
                                            group by department_id)
order by de.department_name asc;


-- 다중행인 경우 any와 all연산자 사용해야

select  employee_id,
        first_name,
        salary
from    employees
where   salary > any(select salary
                     from   employees
                     where  department_id = '110');

select  employee_id,
        first_name,
        salary
from    employees
where   salary > all(select salary
                     from   employees
                     where  department_id = '110');


--아래 두가지 비교해보자

select department_id, employee_id, first_name, salary
from employees
where (department_id, salary) in (select department_id, max(salary)
                                  from employees
                                  group by department_id);


select e.department_id, e.employee_id, e.first_name, e.salary
from employees e, (select department_id, max(salary) salary
                   from employees
                   group by department_id) s
where e.department_id = s.department_id
  and e.salary = s.salary;




-- 혼자서 연습해보자 : 각 부서의 이름, 관리자, 평균연봉, 최고연봉, 최저연봉을 뽑아서 부서번호에 맞게 정렬해보자

select  de.department_name "부서이름",
        em.first_name "관리자이름",
        sa.avgSalary "부서평균연봉",
        sa.maxSalary "부서최고연봉",
        sa.minSalary "부서최저연봉"
from    employees em, departments de, (select  max(salary) maxSalary,
                                               min(salary) minSalary,
                                               round(avg(salary),0) avgSalary,
                                               department_id
                                       from    employees
                                       group by department_id) sa
where em.employee_id = de.manager_id and de.department_id = sa.department_id
order by sa.department_id asc;


--rownum을 배워보자

--틀린 경우1 정렬 전에 넘버링이 되기때문에 크기 순서대로 뽑지 못함
select  rownum,
        employee_id,
        first_name,
        salary
from    employees
where   rownum<6
order by salary desc;


--틀린 경우2 where절을 생성하기 전부터 rownum을 체크하기떄문에 1번이 무한하게 씹힌다 (도표 꼭 참고할 것)
select  rownum,
        employee_id,
        first_name,
        salary
from    (select employee_id,
                first_name,
                salary
         from    employees
         order by salary desc)
where   rownum<=5 and rownum>=2;


--최종적으로는 이렇게 작업하자
select  salaryRank,
        first_name,
        salary
from (select    rownum salaryRank,
                employee_id,
                first_name,
                salary
      from    (select employee_id,
                      first_name,
                      salary
               from    employees
               order by salary desc)
     )
where salaryRank>=10 and salaryRank<=20;


--예제 풀어보기
select  salaryRank "순위",
        first_name "이름",
        salary "급여",
        hire_date "입사일"
from    (select rownum salaryRank,
                first_name,
                salary,
                hire_date
         from    (select first_name,
                         salary,
                         hire_date
                  from    employees
                  where   hire_date like '07%'
                  order by salary desc)
        )
where   salaryRank>=3 and salaryRank<=7;