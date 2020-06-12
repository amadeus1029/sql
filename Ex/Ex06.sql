-- 테이블 생성
create table book(
                     book_id number(5),
                     title   varchar2(50),
                     author  varchar2(10),
                     pub_date    date
);

--테이블 컬럼 추가
alter table book add(
    pubs    varchar2(50)
    );

--테이블 컬럼 요구값 변경
alter table book modify(
    title varchar2(100)
    );

-- 테이블 컬럼 이름 변경
alter table book rename column title to subject;


-- 테이블 컬럼 삭제
alter table book drop(
                      author
    );

-- 테이블 이름 변경
rename book to article;

-- 테이블 삭제
drop table article;


--테이블 생성 + 핵심키 지정
create table author (
                        author_id   number(10),
                        author_name varchar2(100)   not null,
                        author_desc varchar2(500),
                        primary key(author_id)
);


-- 테이블 생성 + 핵심키 지정 + 참조키 지정
create table books (
                       book_id number(10),
                       title   varchar2(100)   not null,
                       pubs    varchar2(100),
                       pub_date    date,
                       author_id   number(10),
                       primary key(book_id),
                       constraint c_book_fk FOREIGN KEY(author_id) --fk지정
                           REFERENCES author(author_id) -- 참조대상
);


-- 인서트 방식 2가지
insert into author
values (1, '박경리', '토지 말고도 유명한거 많으신 분');

insert into author(author_id, author_name)
values (2, '이문열');

insert into author
values (3, '기안84','');


-- 업데이트
update
    author
set
    author_desc = '웹툰작가'
where
        author_id = 3;


-- 삭제
delete from author;

INSERT into author
values (4,'홍길동','ㅁㄴㅇㄹ');


-- 시퀀스 생성
create SEQUENCE seq_author_id
    INCREMENT by 1
    start with 1;

-- 시퀀스 참조하여 값 넣기
insert into author
values (seq_author_id.nextval, '박경리', '토지 말고도 유명한거 많으신 분');

insert into author(author_id, author_name)
values (seq_author_id.nextval, '이문열');

insert into author
values (seq_author_id.nextval, '기안84','');

insert into author
values(seq_author_id.nextval, '이웅희', '어쩌고 저쩌고');


select * from user_sequences;

select seq_author_id.currval from dual;
select seq_author_id.nextval from dual;

insert into books
values(1, '책책 책책','채채채책',sysdate,'24');


-- 연습해보자

-- 전부 날려버리기
drop table books;
drop table author;
drop sequence seq_author_id;
drop sequence seq_book_id;


-- author 테이블 생성
create table author(
                       author_id   number(10),
                       author_name varchar2(100) not null,
                       author_desc varchar2(500),
                       PRIMARY key(author_id)
);

-- books 테이블 생성
create table books(
                      book_id number(10),
                      title   varchar2(100) not null,
                      pubs    varchar2(100),
                      pub_date    date,
                      author_id   number(10),
                      PRIMARY key(book_id),
                      CONSTRAINT c_book_fk FOREIGN key(author_id)
                          REFERENCES author(author_id)
);

-- author 시퀀스 생성
create SEQUENCE seq_author_id
    INCREMENT by 1
    start with 1;
-- books 시퀀스 생성
create SEQUENCE seq_book_id
    INCREMENT by 1
    start with 1;

-- author 값 넣기
insert into author
values(seq_author_id.nextVal, '이문열', '경북 영양');
insert into author
values(seq_author_id.nextVal, '박경리', '경상남도 통영');
insert into author
values(seq_author_id.nextVal, '유시민', '17대 국회의원');
insert into author
values(seq_author_id.nextVal, '기안84', '기안동에서 산 84년생');
insert into author
values(seq_author_id.nextVal, '강풀', '온라인 만화가 1세대');
insert into author
values(seq_author_id.nextVal, '김영하', '알쓸신잡');


-- books 값 넣기
insert into books
values(seq_book_id.nextVal,'우리들의 일그러진 영웅','다림','1998-02-02','1');
insert into books
values(seq_book_id.nextVal,'삼국지','민음사','2002-03-01','1');
insert into books
values(seq_book_id.nextVal,'토지','마로니에북스','2012-08-15','2');
insert into books
values(seq_book_id.nextVal,'유시민의 글쓰기 특강','생각의 길','2015-04-01','3');
insert into books
values(seq_book_id.nextVal,'패션왕','중앙북스(books)','2012-02-22','4');
insert into books
values(seq_book_id.nextVal,'순정만화','재미주의','2011-08-03','5');
insert into books
values(seq_book_id.nextVal,'오직두사람','문학동네','2017-05-04','6');
insert into books
values(seq_book_id.nextVal,'26년','재미주의','2012-02-04','5');

commit;

-- 뽑아보자
select  *
from    books b, author a
where   b.author_id = a.author_id;