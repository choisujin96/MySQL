use hr_db;   -- 미리 설정해놔서 안해도 괜찮음

select  *
 from employees;
 
 
 /*******************************************
*복수행 함수(그룹함수, 집계함수)
*******************************************/
-- 종류: 갯수 합계 평균 최고값 최저값

-- 사용가능 (결과 1개 -> 표현 가능)
select  avg(salary)	
from employees;

-- 사용불가능  
-- -> 왜? avg는 합계 하나만 값을 내는데 이름은 107개가 나오니 테이블 모양이 안맞아 출력이 불가.
-- (107개와 1개를 같이 표현 못함 )
 select  first_name
		  ,avg(salary)	
from employees;



-- *그룹함수 - count()
-- 직원의 수를 구하시오.
select count(*)  -- 전체 갯수 (row 갯수)
from employees;

-- 커미션을 받은 직원의 수
select count(commission_pct)  -- 해당 칼럼에 null 제외하고 데이터 가지고 있는 갯수
from employees;

-- 매니저(팀장)가 있는 직원의 수(null을 제외한 갯수)
select count(manager_id)
from employees;

select count(*), count(commission_pct)
from employees;

-- 월급이 16000 초과 되는 직원의 수는?
select    count(*)
			,count(salary)
from employees
where salary >16000;

select count(salary)
from employees
where salary >16000;

select    count(*)
			,count(salary)
			,count(manager_id)  -- null 제외한 값
from employees
where salary >16000;

-- *그룹함수 - sum() :  입력된 데이터들의 합계 값을 구하는 함수
-- 전체 직원의 수와 급여의 합
select 	count(*)
			,sum(salary)
from employees;


-- 그룹함수 - avg() :입력된 값들의 평균값을 구하는 함수 
-- 주의: null 값이 있는 경우 빼고 계산함 – ifnull() 함수사용,  null도 포함시킬지 말지 결정도 해야함.

-- 월급의 평균을 구하시오
select   avg(salary)                     -- salary 가 null 이면 평균에 포함안됨
           ,avg(ifnull(salary, 0))         -- salary 가 null 이면  0으로 변경해서 평균에 포함됨
from employees;

select  avg(ifnull(commission_pct, 0))
from employees;



-- 그룹함수 - max() / min() : 입력된 값들중 가장 큰값/작은값 을 구하는 함수
-- 여러건의 데이터를 순서대로 정렬 후 값을 구하기때문에 데이터가 많을 때는 느리다(주의해서 사용) 

select max(salary)
from employees;

select max(salary)
         ,min(salary)
         ,sum(salary)
from employees;

select  max(hire_date)
		  ,max(first_name)
from employees;



-- -----------------------------------------------------------------------------------------
-- 부서별로 월급 합계를 구해라
-- 현재로는 where절을 이용해서 구한다 --> 한그룹씩만 가능

select  sum(salary)
from employees
where department_id = 90;


-- 한번에 그룹별로 함계를 구한다.
-- ****Group by 에 참여한 컬럼이나 그룹함수만 올 수 있다.****중요
select  department_id
		   ,count(*)
           ,sum(salary)
           ,avg(salary)
           ,max(salary)
           ,min(salary)
from employees
group by department_id;

-- 부서별로 부서 번호와 인원수 월급합계를 출력하세요,
select    department_id
			,count(*)
            ,sum(salary)
from employees
group by department_id;


-- 부서별로 부서 번호와 최고월급, 최고월급을 받는 직원의 이름을 출력하세요 .
-- ****Group by 에 참여한 컬럼이나 그룹함수만 올 수 있다.****중요
select  department_id
           ,max(salary)
           ,first_name      --  안됨 해당 되지 않음
from employees
group by department_id;


-- 그룹을 나누는 첫번째 기준 department_id, 그안에서 서브(두번째)그룹을  job_id로
select	department_id 
			,job_id
            ,first_name  -- 그룹에 참여하지 않은 컬럼명은 사용할 수 없다.
			,sum(salary)
            ,count(*)
from employees
group by department_id, job_id;

-- ----------------------------------------------------------------------
-- 월급의 합계가 20000 이상인 부서의 부서 번호와, 인원수, 월급 합계를 출력하세요,
select 	department_id
			,count(*)
            ,sum(salary) as ssum            
from employees
group by department_id
having sum(salary) >= 20000;   -- 그룹용 where 버전이라고 생각하면 됨.


-- 월급의 합계가 20000 이상이고 부서 번호가 100번 이상인 
-- 부서의 부서번호, 인원수, 월급 합계를 출력하세요,
-- having절()
select 	department_id
			,count(*)
            ,sum(salary) as ssum            
from employees
group by department_id
having sum(salary) >= 20000   -- 그룹용 where 버전이라고 생각하면 됨.
and department_id >=100;



select 	department_id
			,count(*)
            ,sum(salary)
            ,avg(salary)
            ,max(salary)
            ,min(salary)
from employees
group by department_id;




 /*******************************************
* if (조건문), 참일때, 거짓일때
*******************************************/

-- 모든 직원의 이름, 월급, 수당, 상태(state)를 출력하세요.
-- 상태컬럼은 수

select	 first_name
			,salary
            ,commission_pct
            ,if(commission_pct is null, '사무직', '영업사원') as 'if()'  --  if (조건식, 조건에 해당되면 이거(참일 때), 아니면 이거(거짓일때))
            ,ifnull(commission_pct, '없음') as 'ifnull()'
from employees;


-- 직원아이디, 월급, 업무아이디, 실제월급(realSalary)을 출력하세요.
 -- 실제월급은 job_id 가 'AC_ACCOUNT' 면 월급+월급*0.1,                          
 -- 'SA_REP' 월급+월급*0.2,                       
 -- 'ST_CLERK' 면 월급+월급*0.3                           
 -- 그외에는 월급으로 계산하세요.

select 	 job_id as 업무아이디
			,salary as 월급
            ,case when job_id = 'AC_ACCOUNT' then salary+salary*0.1
					when  job_id = 'SA_REP' then salary+salary*0.2
                    when  job_id = 'ST_CLERK' then salary+salary*0.3
                    else salary
            end as 실제월급
from employees;


-- 직원의 이름, 부서아이디, 팀을 출력하세요.
-- 팀은 코드로 결정하며 부서코드가    10~50 이면 'A-TEAM'
--   												 	 60~100이면 'B-TEAM' 
 --                                                    110~150이면 'C-TEAM' 
--                                                     나머지는 '팀없음' 으로 
-- 출력하세요.

select 	first_name
			,department_id
            ,case 	when department_id >=10 and department_id <=50   then 'A-TEAM'
						when department_id >=60 and department_id <=100   then 'B-TEAM'
                        when department_id >=110 and department_id <=150   then 'C-TEAM'
                        else '팀없음' 
                        end as team
from employees;










