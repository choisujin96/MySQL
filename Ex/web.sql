-- ----------------------------------------------------------------
-- web 계정 01
-- ----------------------------------------------------------------

-- #테이블 만들기
create table book(
	book_id int,
    title varchar(50), 
    author varchar(20), 
    pub_date datetime
);


-- #테이블에 컬럼 추가
alter table book add pub varchar(50);


-- #테이블 컬럼 수정
alter table book modify title varchar(100);   -- varchar(50)  --> varchar(100)

alter table book rename column title to subject;


-- #테이블 컬럼 삭제
alter table book drop author;


-- #테이블 명(이름) 수정
rename table book to article;


-- # 테이블 삭제
drop table article;



-- 테이블 조회
select *
from article;


-- #작가 테이블 만들기
create table author(
	 author_id	 	 	int	 					primary key,
     author_name 	varchar(100)          not null,
	 author_desc  	varchar(500)			
);


-- #작가 테이블 데이터 insert
-- insert 문
insert into author 
values(1, '박경이', '토지작가');


insert into author 
values(2, '이문열');    --  컬럼 수와 데이터 수가 맞지 않음

insert into author   -- 데이터 갯수를 맞춰야 함
values(2, '이문열');   -- 작가 설명에 '' 가짜글자 데이터를 입력한 것임



insert into author      	 -- 데이터 갯수를 맞춰야 함
values(8, '박명수', null);  -- 작가설명에 null  실제 데이터가 없는 값



insert into author
values(3, '최수진', '학생');


insert into author
values(4, '신재평', 'ㅇㅇ'); -- 얘는 수정하는 문법이 따로 있음


-- 컬럼 명을 표시하면 데이터가 컬럼명, 컬럼의 조건과 일치해야 한다.
insert into author(author_id, author_name)  -- 정상
values(5, '정우성');


insert into author(author_id, author_desc)  -- 오류 author_name --> not null
values(6, '유재석');  -- > 테이블 만들 때 이름은 not null 이라고 했는데 이름값이 없으므로 실행되지 않음. ( author_name 데이터 꼭 있어야함)


insert into author(author_name, author_desc)  -- 오류 author_id --> pk (unique + not null)
values('유재석', '런닝맨');  -- 프라이머리 키는 절대 비어져서는 안된다.  pk 는 unique+not null 이 기본적으로 깔려있다. (비거나 겹치면 안된다.)
										-- author_id 의 데이터가 꼭 있어야 한다.


insert into author(author_desc, author_name, author_id)  	-- insert 문에 나열한 컬럼명의 순서대로 
values('제주도', '이효리', '7');											-- 데이터를 나열해야한다.




select *
from author;


-- --------------------------------------------------------------------------------------------------------------

-- #책 테이블 만들기
create table book(
	book_id 	int 					primary key,
    title			varchar(100)		not null,
   pubs 			varchar(100),
   pub_date 	datetime
);


-- #책 테이블 데이터 insert
-- insert 문
insert into book
values (1, '해리포터', '문학수첩', '2024/08/28');


insert into book
values (2, '홀로롤', '니나니니ㅏ', '2012-04-10 23:40:22' );

insert into book (book_id, title, pubs)
values (3, '피터맨과 후크선장의 저주', '요한출판');


insert into book(pubs, book_id, title, pub_date)
value ('믿음사', 4, '노르웨이 숲', '2005/03/23 09:05:23');


-- #테이블 컬럼 삭제
alter table book drop pubs;


-- #테이블 명(이름) 수정
rename table book to paper;


-- #테이블 컬럼 수정
alter table paper rename column book_id to number;



-- # 테이블 삭제
drop table paper;


-- #테이블 조회
show tables;

select *
from book;





