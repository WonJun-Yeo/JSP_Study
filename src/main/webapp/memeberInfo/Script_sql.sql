-- 회원 정보를 저장하는 테이블
create table mbTbl (
    idx number not null,                -- 시퀀스 부착, 자동 증가 컬럼
    id varchar2(100) not null,
    pass varchar2(100) not null,
    name varchar2(100) not null,
    email varchar2(100) not null,
    city varchar2(100) null,
    phone varchar2 (100) null
);

select * from mbTbl;

alter table mbTbl
add constraint mbTbl_id_PK primary key(id);

create sequence seq_mbTbl_idx
increment by 1
start with 1
nocache;

-- 더미 데이터 입력
insert into mbTbl
values (seq_mbTbl_idx.nextval, 'admin', '1234', '관리자', 'kosmo@kosmo.com', 'SEOUL', '010-1111-1111');