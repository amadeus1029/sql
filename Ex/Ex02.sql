select  email,
        initcap(email), --첫글자 제외하고 나머진 강제로 소문자 치환
        department_id
from    employees
where   department_id = 100;


--테스트 헤보는 방법
select  initcap('asdSD')
from    dual;


select  first_name, lower(first_name), upper(first_name)
from    employees
where   department_id = 100;

--substr의 경우 음수를 넣으면 오른쪽에서부터 카운트
select  first_name, substr(first_name,1,3), substr(first_name,-3,2)
from    employees
where   department_id = 100;

-- 전체 글자수를 정한 후 공백을 원하는 문자로 채우기
select  first_name,
        lpad(first_name,10,'*'),
        rpad(first_name,10,'*'),
        lpad('asdasdasdasasdd',10,'*') --길면 걍 짤라버림
from    employees;


--replace 함수
select  first_name,
        replace(first_name, 'a', '*')
from    employees
where   department_id = 100;

select  first_name,
        replace(first_name, 'a', '*'),
        replace(first_name, substr(first_name, 2, 3), '***'),
        replace(first_name, substr(first_name, 2, 3), '*****')
from    employees
where   department_id = 100;


--숫자함수 살펴보자

--round: 소숫점 아래 n번째 자리까지 반올림
select  round(123.345, 2) "r2",
        round(123.456, 0) "r0",
        round(123.456, -1) "r-1" --이러면 첫째자리 위로 반올림하겠지
from    dual;

--trunc: 버리기
select  trunc(123.346, 2) "r2",
        trunc(123.456, 0) "r0",
        trunc(123.456, -1) "r-1"
from    dual;

--날짜함수
select  sysdate,
        to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
from    dual;

--null 값을 0으로 바꿔주기 null이 아닌값을 바꿔주기
select  commission_pct, nvl(commission_pct, 0)
from    employees;

select  commission_pct, nvl2(commission_pct, 100, 0)
from    employees;