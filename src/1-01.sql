select [distinct] 컬럼명,연산자,통계함수,from테이블명 where조건식 
group by 그룹대상 컬럼명
having 함수포함 조건식
order by 정렬대상 asc , desc

SELECT * FROM USER_SEQUENCES;

drop table store cascade constraint purge;
drop table ceo cascade constraint purge;
drop table menu cascade constraint purge;
drop sequence store_seq;
drop sequence ceo_seq;
drop sequence menu_seq;

drop sequence  AUG30_SNACK_SEQ;
drop sequence  comments_SEQ;
drop sequence  gym_SEQ;
drop sequence  snack_SEQ;
drop sequence  store_SEQ;
--요식업 프랜차이즈

홍콩반점 판교점은 홍길동이 운영하고 100석
홍콩반점 종로점은 김길동이 운영하고 80석
한신포차 강남점은 홍길동이 운영하고 150석
부천포차 부천점은 최길동이 운영하고 130석

create table store (
f_no number(3)primary key,
f_name varchar2 (30char) not null,
f_location varchar2 (30char)not null,
f_ceo number(3) not null,
f_seat number(5) not null
);
create sequence store_seq;


insert into store values(store_seq.nextval,'홍콩반점','판교',1,100);
insert into store values(store_seq.nextval,'홍콩반점','종로',2,80);
insert into store values(store_seq.nextval,'한신포차','강남',3,150);
insert into store values(store_seq.nextval,'부천포차','부천',4,130);





홍길동,1990년 03월 1일생 남자
김길동,1992년 02월 1일생 여자
홍길동 1991년 12월 12일생 여자
최길동 1989년 09월 1일생 남자

create table ceo (
c_no number(3) primary key,
c_name varchar2(30char) not null,
c_birthday date not null,
c_gender varchar2 (10char) not null
);

create sequence ceo_seq;


insert into ceo values(ceo_seq.nextval,'홍길동',to_date('1990-03-01','YYYY-MM-DD'),'남자');
insert into ceo values(ceo_seq.nextval,'김길동',to_date('1992-02-01','YYYY-MM-DD'),'여자');
insert into ceo values(ceo_seq.nextval,'홍길동',to_date('1991-12-12','YYYY-MM-DD'),'여자');
insert into ceo values(ceo_seq.nextval,'최길동',to_date('1989-09-01','YYYY-MM-DD'),'남자');

select c_birthday from ceo where  c_name ='홍길동' and c_no=1;

--테이블 하나더만든다.. 짜장면
create table menu(
m_no number (3) primary key,
m_name varchar2(20char) not null,
m_price number(6) not null,
m_f_no number(3) not null
);

create sequence menu_seq;

insert into menu values(menu_seq.nextval,'자장면',4000,1);
insert into menu values(menu_seq.nextval,'짬뽕',5000,1);
insert into menu values(menu_seq.nextval,'탕수육',9000,1);
insert into menu values(menu_seq.nextval,'자장면',4000,2);
insert into menu values(menu_seq.nextval,'짬뽕',5000,2);
insert into menu values(menu_seq.nextval,'탕수육',9000,2);
insert into menu values(menu_seq.nextval,'자장면',4000,3);
insert into menu values(menu_seq.nextval,'짬뽕',5000,3);
insert into menu values(menu_seq.nextval,'탕수육',9000,3);
insert into menu values(menu_seq.nextval,'자장면',4000,4);
insert into menu values(menu_seq.nextval,'짬뽕',5000,4);
insert into menu values(menu_seq.nextval,'탕수육',9000,4);


-------------------------------------------------------
--좌석 수 제일 많은 식당 운영하는 사람의 전체정보 조회
select *from ceo where c_no =(select f_ceo from STORE where f_seat=(select max(f_seat)from STORE));
--프렌차이즈 메뉴 전체의 이름, 가격을 가격 오름차순 가격이 같다면 메뉴명을 가나다 역순 정렬 (정렬을 여러번하고 싶을때는 oredr by 컬럼명 asc/desc , 연결)
select m_name,m_price from menu order by m_price asc ,m_name desc;
--전체 사장님들 이름,생일 조회
select c_name,c_birthday from ceo;
--프랜차이즈 식당 몇 개?
select distinct(count(f_name)) from store;
--프랜차이즈 메뉴 전체의 평균가
select avg(m_price) from menu;
--제일 비싼 메뉴 이름, 가격
select m_name, m_price from menu where m_price = (select max(m_price)from menu);
--최연장자 사장님의 이름 ,생일
select c_name, c_birthday from ceo where c_birthday =(select max(c_birthday)from ceo);
--좌석 수가 제일 적은 식당의 이름 ,지점의 지역,좌석수
select f_name,f_location,f_seat from store where f_seat=(select min(f_seat)from store);
--홍콩반점 판교점 운영하는 사람의 이름,생일
select c_name , c_birthday from ceo where c_no = (select f_ceo from STORE where f_location='판교');
--자장이 들어간 음식은 어디가면 먹을 수 있나요
select f_name,f_location from STORE where f_no in (select m_f_no from menu where m_name like '%자장%');
--최연소 사장님네 가게 메뉴 이름,가격
select m_name,m_price from menu where m_f_no = (select f_no from store where f_no =    (select c_no from ceo where c_birthday=(select max(c_birthday) from ceo))); 
select m_name,m_price from menu where m_f_no in(select f_no from  store where f_ceo in (select c_no from ceo where c_birthday=(select max(c_birthday) from CEO)));


----------------------------조인의 기본 형태---------------------------------------------------
select * from store,ceo;
select * from store,ceo where f_ceo=c_no;

-- 전체 식당 이름,지점명,사장님 이름, 사장님생일
select f_name,f_location,c_name,c_birthday from store,ceo where f_no = c_no order by m_name,f_name asc;
-- 전체 메뉴명, 가격, 식당이름, 지점명
select m_name,m_price,f_name,f_location from menu,store where f_no=m_f_no order by m_name,f_name asc;
-- 좌석수 가 50개 이상인 식당의 메뉴명,가격,식당이름,지점명,좌석수
select m_name,m_price,f_name,f_location,f_seat from menu,store where f_seat >= 50 and f_no = m_f_no order by m_name,f_name asc;
-- 규모가 제일 큰 식당의 메뉴명, 가격, 식당이름, 지점명, 좌석수
select m_name,m_price,f_name,f_location,f_seat from menu,store where f_seat = (select max(f_seat)from store) and f_no = m_f_no order by m_name,f_name asc;
-- 최연장자 사장님네 전체 메뉴명, 가격, 식당이름, 지점명 ,사장님이름, 생일 
select m_name ,m_price,f_name,f_location,c_name,c_birthday from menu,store,ceo where c_birthday = (select min(c_birthday)from ceo) and f_no = m_f_no and m_f_no=c_no order by m_name,f_name asc;
-- 			을 메뉴명 - 가나다순, 식당이름- 가나다순.

------------------------------페이지 나누기--------------------------------
메뉴 테이블 개수 나눠 페이지로 보이게하기.
--메뉴테이블에 m_no (sequence 처리된 치명적인 단점이 있어서  보완작업 후 사용)
먼저 시퀀스 보완 처리방법 
- rownum(가상필드):셀렉트 할때마다 자동으로 부여되고, * 랑은 같이 사용할 수 없고, order by 보다 먼저 부여가되고,무조건 1번부터 조회해야 한다.
--메뉴 이름을 가나다 순으로 정렬해서 메뉴 전체 정보를 조회해보자.
select rownum,m_no, m_name,m_price,m_f_no from menu order by m_name;
--메뉴 이름을 가나다 순으로 정렬해서 menu테이블 rownum 1~3까지 전체 정보를 조회.
select rownum,m_no, m_name,m_price,m_f_no from menu where rownum >=1 and rownum <=3 order by m_name;
--위처럼 하면 order by 전에 로우넘이 먼저 설정되고 order by로 뒤섞여 순서가 달라짐 그럼 순서를 바꿔 써보자.
select rownum,m_no, m_name,m_price,m_f_no from menu order by n_name asc where rownum >=1 and rownum <=3;
--위처럼 오더바이를 먼저 쓰면 문법 오류 발생 . . 해결방법.
select rownum,m_no,m_name,m_price from ( 
select m_no,m_name,m_price from menu order by m_name)  --데이터 정렬한 상테의 컬럼들을 테이블처럼 사용함.
where  rownum >=1 and rownum <=3;
--2~4 까지 메뉴테이블 정보를 메뉴명으로 가나다 순
select * from(select rownum as 로우넘버 ,m_no,m_name,m_price from (select m_no,m_name,m_price from menu order by m_name))where 로우넘버 >=2 and 로우넘버 <=4;


--------------------------------------------------------------------------------
--길동 이름을 가진 사장님네 
--		메뉴명,가격,식당명,지점명,사장님이름
--		가격 은 내림차순 가격이 같다면 메뉴명은 가나다순
--		3~8번째 까지 조회.

select * from (select rownum rn,m_name,m_price,f_name,f_location,c_name from (select m_name,m_price,f_name,f_location,c_name from menu,store,ceo  where m_f_no=f_no and f_no = c_no and c_name like '%길동%' order by m_price desc,m_name )) where rn >= 3 and rn <=8;

select * from (select rownum rn ,m_name,m_price,f_name,f_location,c_name from (select m_name, m_price, f_name, f_location,c_name from menu,store,ceo where m_f_no=f_no and f_ceo = c_no and c_name like'%길동%' order by m_price desc,m_name))where rn between 3 and 8;



--김씨 성을 가진 사장님네 메뉴명,가격,사장님이름,사장님 성별 을 가격이 오름차순으로 정렬을해서 2~3번까지만 

select * from (select rownum rn , m_name,m_price,c_name,c_gender from(select m_name,m_price,C_name,c_gender from menu,ceo,store where m_f_no = c_no and c_no=f_ceo and c_name like '%김%' order by m_price asc )) where rn >=2 and rn <=3;
select * from (select rownum rn , m_name,m_price,c_name,c_gender from(select m_name,m_price,C_name,c_gender from menu,ceo,store where m_f_no = c_no and c_no=f_ceo and c_name like '%김%' order by m_price asc )) where rn between 2 and 3;













