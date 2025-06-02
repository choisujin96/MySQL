-- ----------------------------------------------------------------
-- root 계정
-- ----------------------------------------------------------------

-- #계정만들기
-- create user '계정이름' identified by 비밀번호;
-- 외워야함

-- @% 모든곳 접속 허용
create user 'web'@'%' identified by '1234' ;

  -- localhost  에서만 접속가능
create user 'web'@'localhost' identified by '1234' ; 

  
 -- 해당 아이피 (같은 컴퓨터) 에서만 접속가능
create user 'web'@'192.168.0.122' identified by '1234' ;


                      
-- #계정 비밀번호 변경
-- alter user 계정 identified by '비번';

alter user 'web'@'%' identified by 'web';

/*
mysql -uweb -p 
-- --> 'web'@'192.168.0.122'  로 로그인 된다.
-- --> 로그인 우선순위 'web'@'192.168.0.122'   >   'web'@'localhost'  >  'web'@'%'
*/


-- #계정 삭제
drop user  'web'@'192.168.0.122';

drop user  'web'@'localhost';

drop user   'web'@'%';


-- #계정 조회
use mysql;

select user, host
from user;


-- --------------------------------------------------------------
-- #데이터베이스(스키마) 만들기
create database web_db
default character set utf8mb4
collate utf8mb4_general_ci
default encryption='n'
;


-- #데이터베이스(스키마) 삭제
drop database web_db;

-- #데이터베이스(스키마) 조회
show databases;                   

-- #데이터베이스(스키마) 선택
use web_db;   


-- ---------------------------------------------------

-- #권한부여
-- 'web'@'%'  계정이 web_db (데이타베이스)의 모든 테이블에 모든 권한 부여
grant all privileges on web_db.* to 'web'@'%' ;
flush privileges;



