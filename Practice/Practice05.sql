-- 혼합 sql 문제

/*
문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
(45건)
*/

select  first_name "이름",
        manager_id "매니저아이디",
        commission_pct "커미션비율",
        salary "월급"
from    employees
where   manager_id is not null
  and commission_pct is null
  and salary>3000;


/*
문제2.
각 부서별로 최고의 급여를 받는 사원의
직원번호(employee_id), 이름(first_name), 급여(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하세요
-조건절비교 방법으로 작성하세요
-급여의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.
(11건)
*/

select  employee_id "직원번호",
        first_name "이름",
        salary "급여",
        to_char(hire_date,'YYYY-MM-DD DAY') "입사일",
        replace(phone_number,'.','-') "전화번호",
        department_id "부서번호"
from    employees
where   (salary,department_id) in (select max(salary),
                                          department_id
                                   from    employees
                                   group by department_id)
order by salary desc;


/*
문제3
매니저별로 평균급여 최소급여 최대급여를 알아보려고 한다.
-통계대상(직원)은 2005년 이후의 입사자 입니다.
-매니저별 평균급여가 5000이상만 출력합니다.
-매니저별 평균급여의 내림차순으로 출력합니다.
-매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여 입니다.
(9건)

*/
select
    em.first_name,
    manId,
    avgSal,
    minSal,
    maxSal
from
    employees em,
    (select
         manager_id manId,
         avg(salary) avgSal,
         min(salary) minSal,
         max(salary) maxSal
     from
         employees
     where
             hire_date>='06/01/01'
     group by
         manager_id) man
where
        em.employee_id = manId
  and
        avgSal>=5000;



/*
문제4.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)
*/

select  em.employee_id "사번",
        em.first_name "이름",
        de.department_name "부서명",
        man.first_name "매니저명"
from    employees em, employees man, departments de
where   em.manager_id = man.employee_id and em.department_id = de.department_id(+);


/*
문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
*/

select  rn "순서",
        emid "사번",
        emname "이름",
        dename "부서명",
        emsal "급여",
        emhire "입사일"
from    (select rownum rn,
                emid,
                emname,
                dename,
                emsal,
                emhire
         from    (select em.employee_id as emid,
                         em.first_name as emname,
                         de.department_name as dename,
                         em.salary as emsal,
                         em.hire_date as emhire
                  from    employees em, departments de
                  where   em.department_id = de.department_id and em.hire_date >= '05/01/01'
                  order by em.hire_date asc)
        )
where   rn>=11 and rn<=20;


/*
문제6.
가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름(department_name)은?
*/

select  em.first_name ||' '|| em.last_name "이름",
        em.salary "연봉",
        de.department_name "부서명",
        em.hire_date "입사일"
from    employees em, departments de
where   em.department_id = de.department_id and hire_date = (select max(hire_date)
                                                             from employees);


/*
문제7.
평균연봉(salary)이 가장 높은 부서 직원들의
직원번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary)을 조회하시오.
*/


select
    em.employee_id,
    em.first_name,
    em.last_name,
    jb.job_title,
    em.salary
from
    employees em,
    jobs jb,
    (select department_id,
            avg(salary) avgSal
     from    employees
     group by department_id) avg,
    (select max(avg(salary)) maxSal
     from    employees
     group by department_id) max
where em.department_id = avg.department_id
  and avgSal = maxSal
  and em.job_id = jb.job_id;



/*
문제8.
평균 급여(salary)가 가장 높은 부서는?
*/
select
    de.department_name
from
    departments de,
    (select
         department_id,
         avg(salary) avgSal
     from
         employees
     group by
         department_id) avg,
    (select
         max(avg(salary)) maxSal
     from
         employees
     group by department_id) max
where   de.department_id = avg.department_id
  and avgSal = maxSal;



/*
문제9.
평균 급여(salary)가 가장 높은 지역은?
*/
select  regionName
from    (select rownum rn,
                ro.region_name as regionName,
                so.avgSal as averageSalary
         from    regions ro, (select ro.region_id as regionId,
                                     avg(salary) as avgSal
                              from    employees em, departments de, locations lo, countries co, regions ro
                              where   em.department_id = de.department_id
                                and de.location_id = lo.location_id
                                and lo.country_id = co.country_id
                                and co.region_id = ro.region_id
                              group by ro.region_id) so
         where   ro.region_id = so.regionId)
where   rn=1; --이렇게도 뭐 할수는 있는거 같다..


/*
문제10.
평균 급여(salary)가 가장 높은 업무는?
*/

select
    jb.job_title
from
    jobs jb,
    (select
         job_id,
         avg(salary) avgSal
     from
         employees
     group by
         job_id) avg,
    (select
         max(avg(salary)) maxSal
     from
         employees
     group by
         job_id) max
where
        jb.job_id = avg.job_id
  and
        avgSal = maxSal;
