-- ----------------------------------------------------------------
-- web 계정 02
-- ----------------------------------------------------------------
-- 계정 삭제
drop table author;
drop table  book;


show tables;

-- 테이블 조회
select * from author;

create table author(
	author_id		int  				primary key	auto_increment,    --  번호 자동 증가
    author_name varchar(100)		not null,
    author_desc  varchar(500)
);

insert into author
values(null, '박경리', '토지작가');

insert into author
values(null, '이문열', null);

insert into author(author_desc, author_name)
values('런닝맨', '유재석');


-- -------------------------------------------------
-- 데이터 삭제
-- where절에 컬럼 조건식으로 삭제
delete from author
where author_id >=1 ;  -- 프라이머리 키값으로는 삭제 가능
								-- 요거로 전체 삭제했을 경우 다시 값을 매기면 다시 1번부터 먹는 게 아닌 삭제된 번호 이후의 것으로 먹는다.
								-- 그게 싫으면 테이블 삭제 후 다시 만드삼.
                                
                                
delete from author
where author_id = 3 ;                                  
                                


-- pk 칼럼 이외의 칼럼은 기본적으로 삭제되지 않는다(옵션으로 조정할 수 있다) 이론적으로 되긴 하지만 자체적으로 막아놓음 
delete from author
where author_name = '이문열';  

delete from author; -- 전체 삭제 의미(막혀있음)

-- -------------------------------------------------

-- 데이터 수정
-- update 테이블명 set  컬럼명 = 값, 컬럼명=값, 컬럼명=값 조건절;

update author set  author_name='기안84', author_desc = '웹툰작가' ; -- 어떤 걸 바꾸라는 지 모르기때문에 다 바꿀 수 있어서 위험 (자체적으로 막아주기는 함.) 

-- where 절을 꼭 써야한다 (pk로 조건절 작성)
update author 
set  	author_name='기안84', 
		author_desc = '웹툰작가' 
where author_id = 1;

update author 
set  	author_name='서장훈', 
		author_desc = '농구선수' 
where author_id >= 1;  --  정보들은 한꺼번에 다 바꿔버림






