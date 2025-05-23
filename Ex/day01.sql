/*****************************************
select문 (조회)
******************************************/
-- select문 (select절, from절)
 select * from employees; -- ; 마침표중요
SELECT * from Employees; -- 대소문자 구분하지 않음

-- 테이블 전체 데이터 조회하기
select * from employees; -- 직원
select * from locations; -- 도시
select * from regions;   -- 지역
select * from countries; -- 나라
select * from job_history; -- 업무현황
select * from jobs; -- 업무
select * from departments; -- 부서

-- -----------------------------------------------------
-- select 절
-- * 전체
select * from employees;

-- employee_id 만
select employee_id from employees;

-- employee_id, first_name, last_name
select employee_id, first_name, last_name from employees;

-- 모든 직원의 이름(fisrt_name)과 전화번호 입사일 월급을 출력하세요
select first_name, phone_number, hire_date, salary from employees;

-- 모든 직원의 이름(first_name)과 성(last_name), 월급, 전화번호, 이메일, 입사일을 출력하세요
select first_name,
	   last_name,
       salary,
       phone_number,
       email,
	   hire_date 
from employees;

-- 컬럼명에 별명 사용하기
-- 직원아이디, 이름, 월급을 출력하세요.
-- 단 직원아이디는 empNO, 이름은 "f-name", 월급은 "월 급" 으로 컬럼명을 출력하세요
select employee_id as empNo,  -- as는 생략 가능
       first_name as 'f_name', -- 변경할 때 특수기호는 사용할 수가 없어서 작은 따옴표 사용
       salary as '월 급'
from employees;

-- **컬럼 별명 설정하기
-- 직원의 이름(fisrt_name)과 전화번호, 입사일, 월급 으로 표시되도록 출력하세요
select first_name as 이름,
	   phone_number as 전화번호,
       hire_date as 입사일,
       salary as 월급
from employees;

-- 직원의 직원아이디를 사 번, 이름(first_name), 성(last_name), 월급, 전화번호, 이메일, 입사일로 표시되도록 출력하세요
select employee_id '사 번',
       first_name 이름,
       last_name 성,
       salary  월급,
       phone_number 전화번호,
       email 이메일,
       hire_date 입사일
from employees;

-- **산술 연산자 사용하기
-- 정수/정수 소수점까지 계산됨
select first_name,
       salary as '월급',
       salary-100 as '월급-식대',
       salary*12 as 연봉,
       salary*12+5000 as 연봉보너스포함,
       salary/30 as 일급,
       employee_id%3 as '워크샵 팀',
       employee_id/3 as 정수나누기
from employees;

-- 연산시 문자열은 0으로 처리
select job_id 
from employees;

select first_name, last_name,
	   concat(first_name, last_name) as 전체이름,
       concat(first_name, '-', last_name) as '전체-이름',
       concat(first_name, ' ', last_name) as '전체 이름',
       concat(first_name, ' ', last_name,' 입사일은 ', hire_date,' 입니다.') as 문장  -- 최수진 입사일은 2025-11-25 입니다.
from employees;


-- 전체 직원의 정보를 다름과 같이 출력하세요.
select concat(first_name, '-', last_name) as 성명
       ,phone_number as 전화번호
       ,salary*12 as 연봉
       ,salary as 월급
	   ,salary*12+5000 as 보너스
from employees;


-- *테이블의 컬럼명 
select first_name,
	   salary,
       '(주)개발자' as company,
       3 as no
from employees;

-- *mYSQL은 컬럼명을 생략할 수 있다. (오라클은 안됨)
select first_name,
	   '(주)개발자' as company
from employees; -- employees 테이블의 데이터가 107개 이기 땨문에 107개가 출력

select '(주)개발자'
from dual;   -- 데이터가 없는 가상의 테이블이기 때문에 하나 출력.

select now()
from regions; -- 데이터의ㅡ 갯수만큼 출력

select now() as 현재시각
from dual;   -- 가상의 테이블 사용

select now() as 현재시간;  -- from절을 생략할 수 있음(오라클에서는 안됨)