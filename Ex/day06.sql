
-- ------------------------------
# SubQuery
-- ------------------------------

-- **단일행 SubQuery**
-- 'Den' 보다 월급을 많은 사람의 이름과 월급은?
-- 혼자 짜본 거
select 	first_name
			,salary
from employees
where salary > 11000
order by salary desc;

-- *선생님 설명*
-- > 딘의 월급 확인
select 	first_name
			,salary
from employees
where first_name = 'Den';

-- > 11000 보다 많이 받는 사람
select 	first_name
			,salary
from employees
where salary >=11000;

-- 합친다
select 	first_name
			,salary
from employees
where salary >=(select  salary
						from employees               -- 줄 정리 잘 하기
						where first_name = 'Den');
                        
                        
-- 월급을 가장 적게 받는 사람의 이름, 월급, 사원번호는?
-- 가장 적은 월급 min() 은 그룹함수라 이름, 월급 등 다름 함수와 같이 사용 불가. (그룹함수끼리는 가능)
-- 1. 가장 적은 월급 찾기
select 	min(salary)
from employees;

-- 2. 월급이 2100인 사람의 이름.,월급, 사번
select 	first_name
			,salary
			,employee_id
from employees
where salary = 2100;


-- 3.합치기
select 	first_name
			,salary
			,employee_id
from employees
where salary = (select 	min(salary)
						from employees);
                        
-- 절대 한방에 작성하지 않는다. 꼭  검증 절차 거치기!!!!!!!!!!!!!!

-- 평균 월급보다 적게 받는 사람의 이름. 월급을 출력하세요.

select avg(salary)
from employees;

select 	first_name
			,salary
from employees
where salary <= 6461.831776;


select 	first_name
			,salary
from employees
where salary <= (select avg(salary)
						from employees)
order by salary desc;




-- **다중행 SubQuery**
-- 부서번호가 110인 직원의 급여와 같은 월급을 받는 
-- 모든 직원의 사번, 이름, 급여를 출력하세요.

select *
from employees
where department_id = 110;

-- 2-1) where 절로 구하기, 조건절이 여러개
select employee_id
		  ,first_name
          ,salary
from employees
where salary = 8300.00
or salary = 12008.00;

-- 2-2) in () 구하기
select employee_id
		  ,first_name
          ,salary
from employees
where salary in (8300.00, 12008.00);


-- 합치기 2-2)사용
select  employee_id
			,first_name
            ,salary
from employees
where salary in (select salary
						 from employees
						 where department_id = 110);
                         

-- 각 부서별로 최고급여를 받는 사원의 이름과 월급을 출력하세요,

-- 1) 각 부서별로 최고 월급 --> 이름 출력 안됨 why? 그룹함수라서. department_id는 where절에 그룹을 지어줘서 가능.
select  department_id
           ,max(salary)
from employees 
group by department_id;


-- 2)  각부서별로 최고금액을 받은 사람 이름 출력

select  *
from employees 
where department_id = 10 and salary = 4400
or  department_id = 20 and salary = 13000
or  department_id = 30 and salary = 11000;

-- 2-2 
select  	first_name
			,department_id
			,salary
from employees 
where (department_id, salary) in ((10, 4400), (20, 13000), (30, 11000));


-- 3. 합치기 2-2 사용
select  	first_name
			,department_id
			,salary
from employees                              -- (1번식)
where (department_id, salary) in (select  department_id
															 ,max(salary)
												  from employees 
												  group by department_id);


-- 부서번호가 110인 직원의 월급 중
-- 가장 작은 월급(8300) 보다 월급이 많은 모든 직원의 
-- 이름, 급여를 출력하세요.(or연산--> 8300보다 큰)

-- 1) 부서번호가 110 인 직원의 월급 (8300, 12008)
select 	*
from employees
where department_id = 110;

-- 2-2) where 절
select 	first_name
			,salary
from employees
where salary > 8300
or salary >12008;



-- or ----> any
select *
from employees
where salary >=any (8300, 12008);
-- >없는 문법임 개념만 잡으셈


-- 3) 합치기
select *
from employees
where salary >=any (select salary
								from employees
								where department_id = 110
								);


-- 부서번호가 110인 직원의 월급 중 
-- 가장 많은 월급 보다 월급이 많은 모든 직원의 
-- 이름, 급여를 출력하세요.(and연산--> 12008보다 큰)

select	first_name
			,salary
from employees
where department_id = 110;


-- 2) 부서번호 110의 직원의 월급 중 가장 높은 월급보다 월급이 높은 직원 구하기
-- 2-1) where 절로 표현
select 	first_name
			,salary
from employees
where salary > 8300
and salary > 12008;

-- 2-2) all () 로 표현
select first_name
from employees
where salary > all ( 8300, 12008);

-- 합치기 2-2) 사용
select 	first_name
			,salary
from employees
where salary > all ( select salary
							 from employees
							 where department_id = 110);


-- 각 부서별로 최고월급(24000)을 받는 사원의 부서번호, 직원번호, 이름, 월급을 출력하세요
select 	department_id
			,max(salary)
from employees
group by department_id
order by department_id asc;



select  *
from employees 
where department_id = 10 and salary = 4400
or  department_id = 20 and salary = 13000
or  department_id = 30 and salary = 11000;



select 	department_id
			salary
from employees
where (department_id , salary) in ((10, 4400), (20, 13000), (30,11000));



select 	department_id
			,employee_id
            ,first_name
			,salary
from employees
where (department_id , salary) in (select 	department_id
																,max(salary)
													from employees
													group by department_id);



/*
-- 테이블2 를 조인한다
select *
from테이블명, 테이블2, (서브퀄결과)
where 컬럼명 = 컬럼명
*/

-- 각 부서별로 최고월급(24000)을 받는 사원의 부서번호, 직원번호, 이름, 월급을 출력하세요
-- 1) 각 부서별 최고월급
select 	department_id
			,max(salary)
from employees
group by department_id;

/* 결과일부
(10, 4400)
(20, 13000)
(30, 11000)
*/


-- 2) 전체구조
-- select *
-- from employeese,  가상의 테이블 s




-- 각 부서별로 최고급여를 받는 사원을 출력하세요.
select department_id
		 ,max(salary)
from employees
group by department_id;

select 	employee_id
			,department_id
            ,first_name
            ,salary
from employees e
where (e.department_id = 10 and salary = 4400)
or (e.department_id = 20 and salary = 13000)
or (e.department_id = 30 and salary = 11000)










-- --------------------------------------------------------


