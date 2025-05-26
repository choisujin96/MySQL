-- 복습
-- 월급이 10000 이상인 직원의 이름 월급을 월급이 크ㄴ직원부터 출력하세요.
-- select문의 기본구조(4개의 절)
-- *작동순서를 잘 알아야 한다.
-- 정상작동
select first_name fname
	   ,salary s
from employees
where salary>=10000
order by salary desc;

-- where 절 x, orer by 절 o --> 작동 순서를 알아야한다.
select first_name fname
	   ,salary s
from employees
where salary>=10000
order by s desc;



/*******************************************
*단일행 함수
*******************************************/
-- *단일행 함수 -> 숫자함수

-- *round() : 반올림
select round(123.123, 2)            -- 원본(기준)숫자, 소수점 2번째자리까지 표현  자리순서: (-2 -1 0. 1 2 3 )
	   ,round(123.126, 2)           -- 소수점 3째자리에서 반올림 	
       ,round(234.567, 0)
       
from dual;                       -- --> 가짜테이블



-- *ceil() : 올림   0번째 자리까지표현(소수점 1자리부터는 버림)
select ceil(123.456) -- 124
       ,ceil(123.789) -- 124
       ,ceil(123.7892313) -- 124
from dual;

-- *floor() : 내림   0번째 자리까지표현(소수점 1자리부터는 버림)
select  floor(123.456)  -- 123
		,floor(123.789)  -- 123
        ,floor(123.7892313) -- 123
        ,floor(987.1234) -- 987
from dual;


-- *truncate(): 자리수 버림  소수점 m 자리까지 표현, 정수자리(0~-m)일경우 m자리까지 표현 후 남은 뒷숫자를 0으로 변함
select  truncate(1234.34567, 2) -- 1234.34
	   ,truncate(1234.34567, 3) -- 1234.345
	   ,truncate(1234.34567, 0) -- 1234
       ,truncate(1234.34567, -2) -- 1200 
from dual;


-- *power(숫자, n), pow(숫자, n ): 숫자의 n승
select  power(12,2) -- 12*12  -->144
		,pow(12,2)   -- 12*12  -->144
from dual;

-- *sqrt(숫자) : 숫자의 제곱근(루트)
select sqrt(144)  -- 12
from dual;

-- sign(숫자): 숫자가 음수이면 -1, 0이면 0, 양수이면 1  
select sign(123) -- 1(양수)
	   ,sign(0) -- 0
	   ,sign(-123) -- -1(음수)
from dual;

-- abs(숫자): 절대값  
select abs(123) -- 123
  	   ,abs(0)  -- 0
       ,abs(-123) -- 123
from dual;

-- greatest(x, y, z, ...): 괄호안의 값중 가장 큰값 
select greatest(2, 0 -2) -- 2
	   ,greatest(4, 3.2, 5.25) -- 5.25
       ,greatest('B', 'A', 'C', 'c') -- c
from dual;

-- least (x, y, z, ...): 괄호안의 값중 가장 작은값  
select least(2, 0, -2)  -- -2
	   ,least(4, 3.2, 5.25)  -- 3.25
       ,least('B', 'A', 'C', 'c') -- A
from dual;



-- *단일행 함수 > 문자함수
-- concat(str1, str2, ..., strn): str1, str2, ..., strn을 연결  
select concat('안녕', '하세요')
from dual;

select concat('안녕', '-', '하세요')
from dual;

select concat(first_name, ' ' ,last_name)
from employees;


-- CONCAT_WS(s, str1, str2, ..., strn): str1, str2, ... 
-- strn을 연결할때 사이에 s 로 연결  *with seperator
select concat_ws('-', 'abc', '123', '가나다')   -- abc-123-가나다  ***연결할때 첫번째 기호(?) 로 합쳐라
from dual;

select first_name, last_name
       ,concat(first_name, '-' ,last_name, '-', employee_id)
       ,concat_ws('-', first_name ,last_name, employee_id)
from employees;

-- LCASE(str) 또는 LOWER(str): str의 모든 대문자를 소문자로 변환
select first_name
	  ,lcase(first_name)
      ,lower(first_name)
      ,lower('ABCabc!#%')
      ,lower('가나다')
from employees;		


-- UCASE(str) 또는 UPPER(str): str의 모든 소문자를 대문자로 변환
select first_name
	  ,ucase(first_name)
      ,upper(first_name)
      ,upper('ABCabc!#%')
      ,upper('가나다')
from employees;


-- 문자갯수
-- LENGTH(str): str의 길이를 바이트로 반환
-- CHAR_LENGTH(str) 또는 CHARACTER_LENGTH(): str의 문자열 길이를 반환

select  first_name
       ,length(first_name)   -- byte 수
       ,char_length(first_name)   -- 글자수
       ,character_length(first_name) -- 글자수
from employees;


-- SUBSTRING(str, pos, len) 또는 SUBSTR(str, pos, len): 
-- str의 pos 위치에서 시작하여 len 길이의 문자열 반환
select first_name
	  ,substring(first_name, 1, 3) -- 1번째부터 시작해서 3글자만 출력해 라는 뜻  (1번~3번까지 출력해! 라는 뜻 절대절대 아님. 선생님이 강조 엄청하심)
      ,substring(first_name, 2, 3)  -- 2번째부터 시작해서 3글자만 출력해 라는 뜻
      ,substring(first_name, -2, 3) --  숫자 앞에 마이너스가 붙으면 반대(끝)쪽 해당 숫자에서 시작해서 3글자만 출력해 라는 뜻
from employees;


select substr('901112-2234567', 8, 1) -- 성별
	  ,substr('901112-1234567', -7, 1) -- 성별
	  ,substr('010-2222-2222', 1, 3) -- 성별	
        
from dual;

 -- LPAD(str, len, padstr): str 문자열 왼쪽에 padstr 문자열을 추가하여, 전체 문자열의 길이가 len이 되도록 만듬 
-- RPAD(str, len, padstr):  str 문자열 오른쪽에 padstr 문자열을 추가하여, 전체 문자열의 길이가 len이 되도록 만듬
select  first_name
	   ,lpad(first_name, 10, '*') -- 10자를 만드는데, 모자른 글자수는 *로 채워라 (왼쪽부터채우기)
       ,rpad(first_name, 10, '123') -- 10자를 만드는데, 모자른 글자수는 123으로 채워라 (오른쪽부터채우기) 
from employees;


-- TRIM(str): str의 양쪽에 있는 공백 문자를 제거함!  문자 중간에 있는 공백은 띄어쓴 거인지 뭔지 모르기때문에 제거하지 않음
-- |___________안녕하세요___________|
select concat('|', '        안녕하세요        '  , '|')
	  ,concat('|', trim('        안녕하세요        ')  , '|') -- 공백 없애기
      ,concat('|', ltrim('        안녕하세요        ')  , '|')   -- 왼쪽 공백을 없앤다.
      ,concat('|', rtrim('        안녕하세요        ')  , '|')  -- 오른쪽 공백을 없앤다.
from dual;


-- REPLACE(str, from_str, to_str): str에서 from_str을 to_str로 변경
select first_name
	  ,replace(first_name,'a', '*')  -- 'a' 글자를 '*'로 바꿔라
      ,replace(first_name,'a', '^&*') -- 'a' 한글자여도 글자수 상관없이 '^&*'로 바뀜
from employees;

select first_name
      ,substr(first_name, 2, 3)
      ,replace(first_name, substr(first_name, 2, 3), '***')
from employees;      



-- *단일행함수 -> 날짜함수
-- CURRENT_DATE() 또는 CURDATE(): 현재 날짜를 반환

-- 날짜
select current_date() from dual;
select curdate() from dual;

-- 시간
select current_time() from dual;
select curtime() from_dual;

-- 날짜 + 시간
select current_timestamp() from dual;

-- 날짜,시간 더하기 빼기
-- ADDDATE() 또는 DATE_ADD(): 날짜 시간 더하기
select  '2021-06-20 00:00:00'
		,adddate('2021-06-20 00:00:00', interval 1 year)   -- +1년
        ,adddate('2021-06-20 00:00:00', interval 1 month)  -- +1달
        ,adddate('2021-06-20 00:00:00', interval 1 week)   -- +1주
        ,adddate('2021-06-20 00:00:00', interval 1 day)    -- +1일
        ,adddate('2021-06-20 00:00:00', interval 1 hour)  -- +1시간
        ,adddate('2021-06-20 00:00:00', interval 1 minute)-- +1분
        ,adddate('2021-06-20 00:00:00', interval 1 second) -- +1초
from dual;
-- SUBDATE() 또는 DATE_SUB(): 날짜 시간 빼기
select  '2021-06-20 00:00:00'
		,subdate('2021-06-20 00:00:00', interval 1 year)   -- +1년
        ,subdate('2021-06-20 00:00:00', interval 1 month)  -- +1달
        ,subdate('2021-06-20 00:00:00', interval 1 week)   -- +1주
        ,subdate('2021-06-20 00:00:00', interval 1 day)    -- +1일
        ,subdate('2021-06-20 00:00:00', interval 1 hour)  -- +1시간
        ,subdate('2021-06-20 00:00:00', interval 1 minute)-- +1분
        ,subdate('2021-06-20 00:00:00', interval 1 second) -- +1초
from dual;

-- DATEDIFF(): 두 날짜간 일수차 
-- TIMEDIFF(): 두 날짜시간 간 시간차
select datediff('2021-06-21 01:05:05', '2021-06-20 01:00:00') 
	   ,timediff('2021-06-21 01:05:05', '2021-06-20 01:00:00')
from dual;

select datediff('2025-09-05', '2025-03-27') 
from dual; -- 수업기간 몇일 굥휴일 포함

select first_name
       ,datediff('2025-05-26', hire_date)
       ,datediff(now(), hire_date)   -- 매일 날짜를 고칠 수 없으니 now 라는 현재 날짜 나오는 함수 사용
       ,datediff(now(), hire_date)/365 -- 몇년 일했는지
       ,ceil(datediff(now(), hire_date)/365) -- 연차 
from employees;

-- ---------------------중요함---------------------------------------
-- *단일행함수 > 변환함수
-- DATE_FORMAT(date, format): date를 format형식으로 변환
select  now()
		,date_format(now(), '%y/%m/%d %h:%i:%s')  -- 소문자 y는 두자리년도
        ,date_format(now(), '%Y/%M/%D (%p)%H:%i:%s') -- 대문자 Y와 4자리년도,  M은 월이름, D는 일자를 nd,rd,th로 표현, (%p)는 AM,PM 표시, H는 3시->15시
		,date_format(now(), '%Y/%m/%d %H:%i:%s') -- 많이씀
from dual;

select first_name
	   ,date_format(hire_date, '%Y.%m.%d') hire_date
from employees;
-- ------------------------------------------------------------

-- 원래 문자열 --> 날짜형(자동으로 변환)
select datediff('2021-06-22', '2021-06-21')
from dual;
-- 문자열 -->날짜형으로 변환 --> 계산

select datediff('2021-Jun-22', '2021-06-21')
from dual;

select  str_to_date('2021-Jun-22', '%Y-%b-%d')
	   ,str_to_date('2021-Jun-22', '%Y-%m-%d')
       ,dattediff
from dual;

select datediff('2021-Jun-22', '2021-06-21')
from dual;

-- FORMAT(숫자, p): 숫자에 콤마(,) 를 추가, 소수점 p자리까지 출력
select  format(123456, 0)
		,format(1234567.89, 0) -- 소수점은 없애버리면서 자리수 반올림
        ,format(1234567.88465, 4) -- 소수점 4번째 자리까지 표현하고 그뒤에는 버려줘 (없애버리면서 자리수 반올림)
        ,format(1234567.88465, -5) -- 소수점 자리수 (-는 안됨) 반올림
from dual;


-- IFNULL(컬럼명, null일때값): 컬럼의 값이 null일때 정해진값을 출력
select  first_name
		,commission_pct
        ,ifnull(commission_pct, '해당없음')
from employees;


select  first_name
		manager_id
	    ,ifnull(manager_id, '매니저 없음')
from employees;		















 












