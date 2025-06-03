-- ----------------------------------------------------------------
-- web 계정 03  fk(외래키)
-- ----------------------------------------------------------------

-- 테이블 삭제
drop table author;
drop table book;

-- 테이블 리스트 보기
show tables;



-- 테이블 생성
-- 외래키의 본 집(?) 이 있는 테이블을 우선으로 만들어야한다.


create table author(
	author_id			int					primary key 		auto_increment
    ,author_name 	varchar(100) 		not null
    ,author_desc	 	varchar(500)	
);

create table book(
	book_id			int					primary key		auto_increment
    ,title				varchar(100) 		not null
    ,pubs			varchar(200) 		
    ,pub_date 		datetime
    ,author_id		int
    ,constraint book_fk foreign key(author_id) 
     references author(author_id)
     ON DELETE SET NULL
);

/
/*
- ON DELETE CASCADE: 해당하는 FK를 가진 참조행도 삭제
- ON DELETE SET NULL: 해당하는 FK를 NULL로 바꿈
 */ 




select * from author;
select * from book;


-- 작가 데이터 입력
insert into author
values(null, '이문열', '경북 영양');

insert into author
values(null, '박경리', '경상남도 통영');

insert into author
values(null, '유시민', '17대 국회의원');

insert into author
values(null, '기안84', '웹툰작가');


-- 전체조회
select *
from book bo, author au
where bo.author_id =au.author_id;



 




-- 책 데이터 입력
insert into book
values(null, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);

insert into book
values(null, '토지', '마로니에 북수', '1002-05-15', 1);

insert into book
values(null, '룰라라', '마카로니', '1002-05-15', 2);



-- 경북영양 --> 서울 수정
update	author 
set  		author_desc = '서울' 
where 	author_id = 1;


-- 우리들의 일그러진 영웅 책 삭제
delete from book
where book_id = 1;


-- 작가 박경리 삭제 안됨  why? 작가번호 2번을 책 테이블에서 fk로 사용하고 있음
delete from author
where author_id = 2;

-- 정우성을 삭제 됨. why? 책 테이블에 연결 되어 있지 않으니까.
insert into author
values(null, '정우성', '영화배우');

select *
from author;

delete from author
where author_id = 5;



-- ------------------------------------------------------------------------


-- 전체조회(코드)     컬럼명을 모두 명확하게 표기해준다. 실전에서는 '*' 이걸 잘 사용하지 않는다. 오류날 수 있음.
select   bo.book_id
			,bo.title
            ,bo.pubs
            ,bo.pub_date
            ,bo.author_id
            ,au.author_id
            ,au.author_name
            ,au.author_desc
from book bo, author au
where bo.author_id =au.author_id;