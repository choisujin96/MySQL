
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

-- > 11000 보다 많이 받는 사람리스트
select 	first_name
			,salary
from employees
where salary >=11000;

-- 1)과 2)합친다
select 	first_name
			,salary
from employees
where salary >=(select  salary
						from employees               -- 줄 정리 잘 하기
						where first_name = 'Den');
                        
                        
-- 월급을 가장 적게 받는 사람의 이름, 월급, 사원번호는?
-- 가장 적은 월급 min() 은 그룹함수라 이름, 월급 등 다름 함수와 같이 사용 불가. (그룹함수끼리는 가능)
-- 1. 가장 적은 월급 찾기 -- 2100
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


-- 2)6461.831776보다 월급이 적은 사람을 구한다
select 	first_name
			,salary
from employees
where salary <= 6461.831776;


-- 1)과 2) 합친다
select 	first_name
			,salary
from employees
where salary <= (select avg(salary)
						from employees)
order by salary desc;




-- **다중행 SubQuery**
-- 부서번호가 110인 직원의 급여와 같은 월급을 받는 
-- 모든 직원의 사번, 이름, 급여를 출력하세요.

-- 1) 부서번호가 100인 직원의 월급  12008.00, 8300.00
select *
from employees
where department_id = 110;

-- 2-1) where 절로 구하기, or 조건절이 여러개
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

/*
Jennifer 10 4400.00
Michael  20 13000.00
Den      30 11000.00
Susan    40 6500.00
Adam	 50	8200.00     
*/



-- 1) 각 부서별로 최고 월급 --> 이름 출력 안됨 why? 그룹함수라서. department_id는 where절에 그룹을 지어줘서 가능.
select  department_id
           ,max(salary)
from employees 
group by department_id;


/*
10	4400.00
20	13000.00
30	11000.00
...
*/


-- 2)  각부서별로 최고금액을 받은 사람 이름 출력
-- 2-1) where절로 표현
select  *
from employees 
where (department_id = 10 and salary = 4400)
or  (department_id = 20 and salary = 13000)
or (department_id = 30 and salary = 11000);


-- 2-2  in ()   --> 비교값이 2개이상 
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


-- 2) 8300보다 많은 직원( 8300보다 많은 또는 12008 보다 많은 )
-- 2-1) where절
select 	first_name
			,salary
from employees
where salary > 8300
or salary >12008;



-- 2-2) any()    where절이 or일때
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

-- 1) 부서번호 110인 직원의 월급 구하기
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

-- 2-2) all ()로 표현   -- 의미만
select 	first_name,
		salary
from employees
where salary >all (8300, 12008)
;

-- 합치기 2-2) 사용
select 	first_name
			,salary
from employees
where salary > all ( select salary
							 from employees
							 where department_id = 110);



-- ------------------------------------------------
# SubQuery   where절 vs 테이블
-- ------------------------------------------------
-- #where절로 해결
-- 각 부서별로 최고월급(24000)을 받는 사원의 부서번호, 직원번호, 이름, 월급을 출력하세요
select 	department_id
			,max(salary)
from employees
group by department_id
order by department_id asc;        --  확인용


-- 2-1) where절  
select  *
from employees 
where department_id = 10 and salary = 4400
or  department_id = 20 and salary = 13000
or  department_id = 30 and salary = 11000;


-- 2-2)   in (),  >any (),  >all () 
select 	department_id
			,employee_id
			,first_name
			,salary
from employees
where (department_id , salary) in ((10, 4400), (20, 13000), (30,11000));


-- 3) 2-2)로 합친다
-- 부서번호, 직원번호, 이름, 월급
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
 테이블2 를 조인한다

select *
from 테이블명
where 컬럼명 in (서브커리 결과)
*/
-- ---------------------------------------------------------------

-- ---------------------------------------------------------------
-- 각 부서별로 최고월급(24000)을 받는 사원의 부서번호, 직원번호, 이름, 월급을 출력하세요
-- #테이블로 해결

-- 1) 각 부서별 최고월급 데이터가 있는 테이블이 있다면 구할 수 있다
--    --> 이부분은 아이디어가 필요함(어려울 수있으므로 지금 생각이 안난다면 넘어가자)
--    --> 단 테이블 조인으로 해결할 수 있다 는 믿고가자
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
select employee_id,
		department_id,
		first_name,
		salary
from employees e,  가상의테이블 s
where e.department_id = s.department_id
and e.salary = s.salary
;


-- 3) 합치기      -- 1)번의 결롸를 테이블로 사용
select 	e.department_id,
			e.employee_id,
			e.first_name,
			e.salary,
			s.maxSalary
from employees e, (select  department_id,
										 max(salary) maxSalary
								from employees
								group by department_id) s 
where e.department_id = s.department_id
and e.salary = s.maxSalary
;



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
or (e.department_id = 30 and salary = 11000);


-- --------------------------------------------------------

-- ------------------------------
# Limit
-- ------------------------------
-- 직원 관리 페이지, 사번이 작은 직원이 위쪽에 출력 (요구사항에 있었음)
-- --> 자동으로 정렬되더라도 꼭 order by 절로 정렬해줘야함

/*
(0, 10)  --> 1번부터 10개
(10, 10) --> 10번부터 10개
(20, 10) --> 20번부터 10개


*/
select 	employee_id
			,first_name
            ,salary
from employees
order by employee_id asc
limit 0, 10      -- 1번부터 10개
;
-- ---------------------------------
-- *다른표현
select 	employee_id
			,first_name
            ,salary
from employees
order by employee_id asc
limit 5 offset 0 -- 1개번부터 5개
;

select 	employee_id
			,first_name
            ,salary
from employees
order by employee_id asc
limit 8 offset 3 -- 3번부터 8개
;



-- 07년에 입사한 직원 중 급여가 많은 직원 중 3에서 7등의 이름 급여 입사일은?
-- 가장 많은 급여: 171 172 155 178 113

-- 1) 전체조회
select *
from employees


-- 2) 2007년 입사자만 조회
select *
from employees
where hire_date > '2007-01-01'
and hire_date < '2007-12-31';


-- 3) 가장 큰 월급부터  내림차순 정렬
select *
from employees
where hire_date > '2007-01-01'
and hire_date < '2007-12-31'
order by salary desc;


-- 4) 출력컬럼 결정
select 	employee_id
			,first_name
			,salary
            ,hire_date
from employees
where hire_date >= '2007-01-01'
and hire_date <= '2007-12-31'
order by salary desc
limit 2,  5;

-- ----------------------


select 	first_name
            ,hire_date
from employees
where hire_date between '2007-01-01' and '2007-12-31'    -- 비트윈은 양쪽 다 포함이 되야 되는 경우에만! ex)   '2007-12-31 대신 '2008-01-01' 이 들어가면 이 값도 포함되서 여기까지 출력된다.
order by hire_date asc;




select 	first_name
            ,hire_date
            ,date_format(hire_date, '%Y')
from employees
where date_format(hire_date, '%Y') = '2007'
order by hire_date asc;


-- --------------------------------------
-- 부서번호가 100인 직원중 급여를 가장 많이 받은 직원의 이름, 급여, 부서번호를 출력하세요.
-- 가장 많이 받는  12008.00 낸시

-- 수진 푼 것
select 	first_name
			,salary
            ,department_id
from employees
where department_id = 100
order by salary desc
limit 0, 1;


-- 1)
-- 2)
-- 3) 월급 12008 직원을 찾는다, 부서번호 100이어야 한다.
select *
from employees
where salary = 12008
and department_id = 100 ;


-- 4) 서브쿼리 적용
select 	first_name
			,salary
            ,department_id
from employees
where salary = (select 	max(salary)
						from employees
						where salary = 12008)
and department_id = 100 ;

-- >되도록 max 를 이용한 서브쿼리를 사용해서 짜는 연습을 마아아아않이 한다.
-- --------------------------------------------------------------------
-- limit 사용
select 	first_name
			,salary
            ,department_id
from employees
where department_id = 100
order by salary desc
limit 0, 1;

