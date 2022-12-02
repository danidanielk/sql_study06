join : 하나의 명령문에 의해 여러 테이블에 저장된 데이터를 한번에 조회할 수 있는 기능.

create table tb1 (name varchar2(10char), age number(3));
create table tb2 (name varchar2(10char), age number(3));

insert into tb1 values ('김비버',30);
insert into tb1 values ('박비버',35);
insert into tb1 values ('최비버',40);
insert into tb1 values ('오비버',40);

insert into tb2 values ('김비버',30);
insert into tb2 values ('정비버',50);
insert into tb2 values ('이비버',55);

--cross join : 별도의 조건 없이 두 테이블 간의 가능한 모든 결과를 조회 (모든 경우의 수) 사실상 안씀;
select * from tb1, tb2;
select * from tb1 cross join tb2;

--inner join : 조건에 해당하는 값만 나옴.
select * from tb1 inner join tb2 on tb1.name = tb2.name;
select * from tb1 a, tb2 b where a.name = b.name;   --equi 조인	: 위에 크로스 조인에 웨얼절 붙혀 조건에맞는값찾는거
select * from tb1 join tb2 using (name);			--equi 조인2	: 
select * from tb1 natural join tb2;					--자연조인 	: 조건절 없이 양쪽에 같은 이름을 가진 동일한 컬럼만을 조회

--outer join : 기준이 될 테이블의 데이터가 모두 조회가되고 대상 테이블의 데이터가 있는경우 해당 컬럼의 값을 가져오기 위해서사용
--			1. left outer join : 왼쪽 테이블에 값이 있을 시 오른쪽 테이블이 조건에 맞지 않아도(null)값이 나옴.
select * from tb1 left outer join tb2 on tb1.name = tb2.name;
select * from tb1,tb2 where tb1.name = tb2.name(+);

--			2. right outer join : 오른쪽 테이블에 값이 있을 시 왼쪽 테이블이 조건에 맞지 않아도(null)값이 나옴. 레프트를 주로 사용함 이거 잘안씀.
select * from tb1 right outer join tb2 on tb1.name = tb2.name;
select * from tb1,tb2 where tb1.name(+) = tb2.name;

--			3. full outer join : 한쪽 테이블에 값이 있을 시 , 다른족 테이블이 조건이 맞지 않아도 내용이 나옴
select * from tb1 full outer join tb2 on tb1.name = tb2.name;

--self join ** 헷갈림 : 하나의 테이블 내에 있는 컬럼끼리 연결하는 조인이 필요한 경우. 
-- 예를 들어보자 .
-- 한 웹사이트에 회원이 5명이 있고, 관리자가 2명이 있다. 
-- 회원의 이름은 각각 회원 1~ 5, 관리자의 이름은 관리자1,2 이다.
-- 회원의 아이디는 각각 member 1~5 , 관리자의 아이디는 manager1,2 이다.
-- 회원 1~3번까지는 관리자 1이 관리하고 / 나머지는 관리자 2가 관리한다.
create table member(
m_id varchar2(10 char) primary key,
m_name varchar2(10 char) not null,
m_manager varchar2(10char)
);

insert into member values('member1', '회원1','manager1');
insert into member values('member2', '회원2','manager1');
insert into member values('member3', '회원3','manager1');
insert into member values('member4', '회원4','manager2');
insert into member values('member5', '회원5','manager2');
insert into member values('manager1', '관리자1','null');
insert into member values('manager2', '관리자2','null');

--각 관리자가 어떤 회원을 관리하고 있는지 쿼리문 작성해라..셀프조인 인가뭐시긴가로; ;
select a.m_id,a.m_name,b.m_id from member a join member b on a.m_id = b.m_manager;

오늘까지 S 끝냈고 다음주 DML 중 업데이트, 딜리트 끝나면 DML 끝 이후 DB와 자바 연동 시작..