-- 테이블 쪼인해보자

select  em.employee_id,
        em.first_name,
        em.department_id,
        de.department_id,
        de.department_name
from    employees em, departments de
where   em.department_id = de.department_id;



--모든 직원이름 부서이름, 업무명 출력하기

select  em.first_name "직원이름",
        de.department_name "부서이름",
        jb.job_title "업무명",
        em.department_id,
        de.department_id,
        em.job_id,
        jb.job_id
from    employees em, departments de, jobs jb
where   em.department_id = de.department_id and em.job_id = jb.job_id;



--null값도 찍어주려면 다른 문법을 사용해야한다

select  e.first_name,
        e.department_id,
        d.department_name
from    employees e left outer join departments d
                                    on      e.department_id = d.department_id;

--위의 쿼리문은 아래와 같다

select  e.first_name,
        e.department_id,
        d.department_name
from    employees e, departments d
where   e.department_id = d.department_id(+); -- 좌측이 기준이 된다(null이 나올수 있는 쪽에 +를 붙인다)


select  e.first_name,
        e.department_id,
        d.department_name
from    employees e right outer join departments d
                                     on      e.department_id = d.department_id;


-- full outer join은 뭐냐?

select  e.first_name,
        e.department_id,
        d.department_name
from    employees e full outer join departments d
                                    on      e.department_id = d.department_id;


--self join이란

select  emp.first_name "직원이름",
        man.first_name "관리자",
        emp.manager_id,
        man.employee_id
from    employees emp, employees man
where   emp.manager_id = man.employee_id;