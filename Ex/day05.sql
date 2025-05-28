/************************************************
* join
************************************************/

-- 직원의 이름과 직원이 속한 부서명을 함께 출력하세요
-- steven 90  90 Excutive
-- 카디젼 프로덕트 모든 경우의 수의 갯수가 된다.
-- 107 * 27 = 2889 (원하는 게 아니다)
select first_name, department_name
from employees, departments;


-- where 절을 사용한다.
select 	first_name
			,department_name
from employees, departments
where employees.department_id = departments.department_id
;

-- ------------------------------
# inner join (equi join)
-- ------------------------------
-- 이큐조인: 양쪽에 똑같은 데이터가 있는 애들을 합쳐서 같이 쓰겠다.
-- 직원의 이름과 직원이 속한 부서명을 출력하세요.  -> null 값이 있는 애는 제외하고 숫자를 세기 때문에 106개이다.

select	first_name,
			employees.department_id,
			departments.department_id
from employees inner join departments
on employees.department_id = departments.department_id 
;

-- inner join (equi join) 정식표현
-- 칼럼에 별명을 붙여줄 수 있음 
select 	e.first_name
			,e.department_id
            ,d.department_id
            ,d.department_name
from employees e inner join departments d
on e.department_id = d.department_id;

-- inner join (equi join) where절 사용 -->많이 사용
select 	e.first_name
			,e.department_id
            ,d.department_id
            ,d.department_name
from employees e, departments d
where e.department_id = d.department_id;

-- -----------------------------------------
-- 여러개 테이블을 조인할 때
/*
107      27        23
이름   부서명    부서도시
Steven Excutive  Seattle
Neena  Excutive  Seattle
...
David  IT        Southlake
(106개)
*/
-- inner join (equi join) where절 사용 -->많이 사용
select	e.first_name,
			d.department_name,
			l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
;


-- inner join (equi join) 정식표현
/*
107      27        23
이름   부서명    부서도시
Steven Excutive  Seattle
Neena  Excutive  Seattle
...
David  IT        Southlake
(106개)
*/


select	 e.first_name
			,d.department_name
            ,l.city
            ,l.location_id
            ,d.location_id
from employees e
inner join departments d
          on e.department_id = d.department_id  -- 여기까지 합친 걸
inner join locations l                                   -- 또 여기랑 합치겠다.
          on d.location_id = l.location_id;


-- 모든 직원이름, 부서이름, 업무명을 출력하세요

select e.first_name
		  ,d.department_id
          ,j.job_title
from employees e
    	, departments d
        , jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id;



select  e.first_name
		  ,d.department_id
          ,j.job_title
from employees e
inner join departments d
		 on e.department_id = d.department_id
inner join jobs j
		 on e.job_id = j.job_id
 ;
 
-- ------------------------------
# left outer join
-- ------------------------------
-- 왼쪽 테이블을 기준, 기준 테이블의 정보는 다 보여줌
-- (Kimberely 가 결과에 있어야 함:소속부서가 없는 직원)
select	e.first_name
			,d.department_name
            ,e.department_id
            ,d.department_id
from employees e
left outer join departments d
				on e.department_id = d.department_id;


-- ------------------------------
# right outer join --> left outer join
-- ------------------------------
-- 모든 직원의 부서번호, 이름, 부서번호를 출력하세요.
-- 직원이 없는 부서도 표시  (Kimberely 결과에 없다)
select	e.first_name
			,d.department_name
            ,e.department_id
            ,d.department_id
from employees e
right outer join departments d
					on e.department_id = d.department_id;
                    
	-- 문법의 왼 (기준 뭘로 할래?)  오  이렇게 되는 거임. 표는 상관 없음.   
    -- from 에 쓰는 건 원본 데이터에 들어가는 게 아니고 복사해서 들어가는 거임
    
    
-- ------------------------------
# full outer join    union
-- ------------------------------
 -- (왼쪽 기준)
 -- union
 -- (오른쪽 기준)
-- 킴벌리랑 부서는 있지만 사람은 없는 거 함께 나와야함
--  합치려면 칼럼명이 같아야하고, 갯수가 같아야함  (왼쪽과 오른쪽의 모양이 맞아야한다.)
    
    
( 
	-- 왼쪽기준
  select	 e.employee_id
				 ,e.first_name
				,d.department_id
                ,d.department_name
    from employees e
    left outer join departments d
					on e.department_id = d.department_id
)
 union
  (
   -- 오른쪽 기준
select 	e.employee_id
			,e.first_name
            ,d.department_id
            ,d.department_name
from employees e
right outer join departments d 	
	on e.department_id = d.department_id
  )
; 
    

-- ------------------------------
# self join 
-- ------------------------------
-- 테이블에서 자신의 pk 를 fk 로 가지고 다는 경우
-- 같은 테이블을 두번 불러와서 써야되는 경우
-- 두번 불러와서 별명을 다르게 해준다. (꼭!!!!! 별명을 줘야 함.)
    
    select 	e.employee_id
				,e.first_name
                ,e.phone_number
                ,m.employee_id as m_id
                ,m.first_name as m_first_name
                ,m.phone_number as m_phone_number
    from employees e , employees m 
    where e.manager_id = m.employee_id;
    
    
-- ------------------------------
# 참고 잘못된 조인
-- ------------------------------
   -- 아무 컬럼이나 where에 사용하면 안된다.
   select *
   from employees e, locations l
   where e.salary = l.location_id;
   -- 월급과 도시는 아무러 관계가 없다.
   
   
   -- ------------------------------------------------------------------------------------------
# 조인 연습(equi join, inner join 두가지로 풀어볼것)
-- 직원아이디, 이름, 월급, 부서아이디, 부서명, 도시아이디, 도시명
  
  
  select 	e.employee_id
				,e.first_name
                ,e.salary
                ,d.department_id
                ,d.department_name
                ,l.location_id
                ,l.city
   from employees e, departments d, locations l
   where e.department_id = d.department_id
   and d.location_id=l.location_id;
   
   
   select	e.employee_id
				,e.first_name
                ,e.salary
                ,d.department_id
                ,d.department_name
                ,l.location_id
                ,l.city
   from employees e
inner join departments d
		  on e.department_id = d.department_id
inner join locations l
		  on d.location_id = l.location_id;
   
   
-- 직원아이디, 이름, 월급, 부서아이디, 부서명, 도시아이디, 도시명, 나라아이디, 나라명
select 	e.employee_id
			,e.first_name
            ,e.salary
            ,d.department_id
            ,d.department_name
            ,l.location_id
            ,l.city
            ,c.country_id
            ,c.country_name
from employees e, departments d, locations l, countries c
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id;



select 	e.employee_id
			,e.first_name
            ,e.salary
            ,d.department_id
            ,d.department_name
            ,l.location_id
            ,l.city
            ,c.country_id
            ,c.country_name
from employees e
inner join departments d
		on e.department_id = d.department_id
inner join locations l
		on d.location_id = l.location_id
inner join countries c
		on l.country_id = c.country_id;

   
   
-- 직원아이디, 이름, 월급, 부서아이디, 부서명, 도시아이디, 도시명, 나라아이디, 나라명, 지역아이디, 지역명

select	e.employee_id
			,e.first_name
            ,e.salary
            ,d.department_id
            ,d.department_name
            ,l.location_id
            ,l.city
            ,c.country_id
            ,c.country_name
            ,r.region_id
            ,r.region_name
from employees e, departments d, locations l , countries c, regions r
where e.department_id  = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id = r.region_id;
   
   
   
select e.employee_id
			,e.first_name
            ,e.salary
            ,d.department_id
            ,d.department_name
            ,l.location_id
            ,l.city
            ,c.country_id
            ,c.country_name
            ,r.region_id
            ,r.region_name
from employees e
inner join departments d
		on e.department_id = d.department_id
inner join locations l
		on d.location_id = l.location_id
inner join countries c
		on l.country_id = c.country_id
inner join regions r
		on c.region_id = r.region_id;

   
   