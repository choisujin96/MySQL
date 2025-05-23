/****************************
 select 문(조회)
 ****************************/
 -- --------------------------
 -- where 절
 -- --------------------------
 -- 부서 아이디가 10인 사원의 이름을 구하시오.
 select first_name,
		department_id
 from employees
 where department_id = 30;    -- 갯수를 조정할 수 있다. 조건을 통해서
 
 -- #1
 select concat(first_name,' ', last_name) 성명
		,salary 월급
 from employees
 where salary >= 15000;
 
 
 -- #2
 select concat(first_name, ' ', last_name) 성명
		,hire_date 입사일
 from employees
 where hire_date > '07/01/01';
 
 
 -- #3
 select first_name
		,salary	
 from employees
 where first_name = 'Lex';
 
 
 -- #4
 select first_name
		,salary	
 from employees
 where binary first_name = 'lex'; -- 문자열은 대소문자를 구별하지 않음. 
 -- 구별하려면 binary 사용
 
 
 -- #5 조건이 2개 이상 일 때 한꺼번에 조회하기
 -- 월급이 14000 이상 17000 이하인 사원의 이름과 월급을 구하시오.
 -- salary >= 14000 월급이 14000 이상
 -- salary <= 17000 월급이 17000 이하
 -- 두 조건이 모두 만족해야 한다. &&(자바) --> and,  (||(자바) --> or )
 select first_name
		,salary
 from employees
 where salary >= 14000 
 and salary <=17000;
 
 
-- #6
 select first_name
		,salary
 from employees
 where salary <= 14000 
 or salary >=17000;
 


 -- #7 입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요
 select concat(first_name, ' ', last_name) as 성명
        ,hire_date
 from employees
 where hire_date >= '04/01/01' 
 and hire_date <= '05/12/31';
 
 
 --
 select concat(first_name, '-', last_name) as 성명
        ,salary as 월급
 from employees
 -- where salary >= 14000 and salary <= 17000
 where salary between 14000 and 17000; -- --> 14000 ~ 17000 사이를 표현할 때 이렇게 사용해도 됨. 편한 걸 사용하면 됨.
 
-- in 연산자로 여러 조건 검사하기 
 select first_name
	    ,salary
 from employees
 where first_name = 'Lex' 
 or first_name = 'Neena' 
 or first_name = 'John';
 
 
select first_name
       ,salary
from employees
where first_name in ('Lex', 'Neena', 'John'); 
 
select concat(first_name, ' ', last_name)
	   ,salary
from employees
where salary in(2100, 3100, 4100, 5100);
 
 
-- Like 연산자로 비숫한 것들 모두 찾기
select *
from employees
-- where first_name like 'L%' -- > L로 시작하고 뒤에 몇글자가 와도 상관없다.
	where first_name like 'L___'; -- > L로 시작하고 뒤에 언더바 만큼의 길이를 가진 이름. ( L뒤에 찾고 싶은 글자수 만큼 _ 언더바 작성.)


-- 이름에 am 을 포함한 사원의 이름과 월급을 출력하세요
select first_name
       ,salary 
from employees
where first_name like '%am%';

-- ▪ 이름의 두번째 글자가 a 인 사원의 이름과 월급을 출력하세요
select first_name
       ,salary
from employees
where first_name like '_a%';

-- ▪ 이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
select first_name
from employees
where first_name like '___a%';


-- ▪ 이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select first_name
       ,salary
from employees
where first_name like '____' and first_name like '_a%';


-- --부서가 없는 ㅏ원ㅇ의 이름과 부서벌호를 입력하세려.
-- is null
select department_id
from employees
where department_id is null;

-- 부서가 있는 사람의 이름과 부서번호를 출력하세요.
-- is not null
select first_name 
      ,department_id
      ,department_id
from employees
where department_id is not null;

select first_name
	   ,salary
       ,commission_pct
       ,salary*commission_pct+200
from employees;

-- 커미션비율이 있는 사원의 이름과 월급 커미션비율을 출력하세요
select first_name
	   ,salary
       ,commission_pct
from employees
where commission_pct is not null;


-- 담당매니저가 없고 커미션비율이 없는 직원의 이름과 매니저아이디 커미션 비율을 출력하세요
select first_name
	   ,manager_id
       ,commission_pct
from employees
where commission_pct is null
and manager_id is null; 



-- 부서가 없는 직원의 이름과 월급을 출력하세요
select first_name
	   ,salary
	   ,department_id
from employees
where department_id is null;
 
 
-- 월급이 6000 이상 10000 이하인 직원 중 commission 비율이 없는 직원의
-- 이름 월급 커미션 비율을 출력하세요.
select first_name
	   ,salary
       ,commission_pct
from employees
where salary >= 6000 
and salary <= 10000
and commission_pct is null;

-- -----------------------
-- order by 절(정렬)
-- ----------------------- 
 -- 직원의 이름과 월급을 월급이 많은 직원부터 출력하세요. (큰 수-->작은 수 : 내림차순)
 -- 오름차순 :asc   내림차순:desc
 
 select *
 from employees
 -- where salary >= 10000
 order by salary desc ;

 -- 월급이 9000이상인 직원의 이름과 월급을 적은 순대로 출력
 select first_name
        ,salary
 from employees
 where salary >= 9000
 order by salary asc;
 
 
-- 부서번호를 오름차순으로 정렬하고 부서번호, 월급, 이름을 출력하세요
select department_id
		,salary
        ,first_name
from employees
order by department_id asc;


-- 월급이 10000 이상인 직원의 이름 월급을 월급이 큰직원부터 출력하세요
select first_name 
	   ,salary
from employees
where salary >=10000
order by salary desc;


--  직원의 이름, 급여, 입사일을 이름의 알파벳 올림차순으로 출력하세요
select first_name
       ,salary
       ,hire_date
from employees
order by first_name asc;


--  직원의 이름, 급여, 입사일을 입사일이 빠른 사람 부터 출력하세요
select first_name
       ,salary
       ,hire_date
from employees
order by hire_date asc;


-- 부서번호를 오름차순으로 정렬하고 부서번호가 같으면 월급이 높은 사람부터 부서번호 월급 이름을 출력하세요 
select department_id
	   ,salary
       ,first_name
from employees
order by department_id asc, salary desc;
 
 
 
 
 
 
 
 
 
 