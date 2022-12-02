--2000 �� ������ ������ �ּҰ����� ������
select min(s_price) from AUG30_SNACK where s_price <=2000;
--��� ������ ��հ���
select avg(s_price) from aug30_snack;
--������ �̸��� ������ 30% ���ε� �ݾ�
select s_name, s_price*0.7 from aug30_snack;
--3500���� ������ ������ �?
select count(s_price) from aug30_snack where s_price = 3500;
--3000�� ������ ������ �̸�,ȸ���̸�
select s_name,s_maker from aug30_snack where s_price <=3000;
--��� ���� �̸�, ����, ������� ��ȸ
select s_name, s_price , s_date from aug30_snack;
--��� ���� �̸�, ����, �ΰ��� ��ȸ 10%
select s_name , s_price , s_price*0.1 as �ΰ��� from aug30_snack;
--��� ���� �̸�, ����, �ǸŰ� ��ȸ 20%����
select s_name , s_price , s_price*0.8 as �ǸŰ� from aug30_snack;
--3000�� ���� ū �ݾ��� ���ڵ��� ��հ� ��ȸ
select avg(s_price) from aug30_snack where s_price > 3000;
--�ְ�,������,�� ���� ���� ������� ��ȸ
select max(s_price),min(s_price),count(s_name)from aug30_snack;
--3000�� �̻��� ������ ��ü ���� ��ȸ
select * from aug30_snack where s_price >= 3000;
--3000�� �̸��� ������ �̸�, ����, �ǸŰ� ��ȸ 20% ����
select s_name ,s_price , s_price*0.8 as �ǸŰ� from aug30_snack where s_price <3000;
--��Ϲ���Ĩ�� ���� ��ȸ
select s_price from aug30_snack where s_name='����Ŀ��';
--ũ��� ȸ���� ���� ���� ���� ��ȸ
select sum(s_price) from aug30_snack where s_maker ='ũ���';
--9�� ������ �Ծ�� �ϴ� ���� �̸�, ����, ������� ��ȸ
select s_name, s_price , s_date from aug30_snack where s_date < to_date('2022-10-01 00:00:00','YYYY-MM-DD HH24-MI-SS');
--'��'�� ���� ȸ�翡�� ���� ������ �̸� ��ȸ
select s_name from aug30_snack where s_maker like'%��%';
--'��' ������ ���ڵ� ��հ� ��ȸ
select avg(s_price) from aug30_snack where s_maker like'%��%';
--ũ�����ڰų�,����~�ΰ� �̸�,����ȸ��,���� ��ȸ
select s_name,s_maker,s_price from aug30_snack where s_maker='ũ���' or s_name like '%����%';
--������ �̸��� '���޴���'���� �����ϰų� '��' �� ������ ������ �̸�,������ ,���� ��ȸ 
select s_name, s_maker, s_price from aug30_snack where s_name like'���޴���%' or s_name like '%��';
--���� ������ �߿��� ȸ�簡 ũ����̰� ������ 1000�� �����̰ų� 3000�� �̻��� ���� ��ü���� ��ȸ
select * from aug30_snack where (s_maker ='ũ���') and (s_price <= 1000 or s_price >=3000);
--�Ե� �Ǵ� ���� ȸ���� ���� ��� ������ 1800 �� �̻��� �� �� ȸ���� ��� ���� ������ �� ����
select s_maker , round(avg(s_price)) from aug30_snack group by s_maker having avg(s_price) >= 1800 order by avg(s_price) desc;
--ȸ�纰�� �׷��� ��� ���� ��հ���, �ּҰ���, �ְ��� �� �˰������
select decode(s_maker,null,'��ü',s_maker)s_maker,sum(s_price)as �հ�,round(avg(s_price)) as ��հ�,min(s_price)as �ּҰ�,max(s_price)as �ְ� from aug30_snack group by rollup(s_maker);
--ȸ�� �̸�, ȸ�纰 ���� �� ���� �հ�� ��� ���ڵ��� �հ�
select decode(s_maker,null,'��ü',s_maker)s_maker,sum(s_price) as �հ� from aug30_snack group by rollup(s_maker);
--ȸ�纰�� ���� ��� ������ 2000�� �̻��� ȸ���� �̸��� ���� ��� ������ ��ȸ.
select decode(s_maker,null,'��ü',s_maker)s_maker,round(avg(s_price)) as ��հ���,count(s_name)as �������� from aug30_snack group by rollup(s_maker) having avg(s_price)>=2000 order by count(s_name)asc;

create table aug30_snack (
s_no number(5) primary key,
s_name varchar(10 char) not null,
s_maker varchar(10 char) not null,
s_price number(10)not null,
s_date date not null
);

create sequence aug30_snack_seq;

insert into aug30_snack values(aug30_snack_seq.nextval,'����Ŀ��','������',2000,sysdate);
insert into aug30_snack values(aug30_snack_seq.nextval,'������','�Ե�',2500,sysdate);
insert into aug30_snack values(aug30_snack_seq.nextval,'������','��ī�ݶ�',500,sysdate);
insert into aug30_snack values(aug30_snack_seq.nextval,'��ĵ��','�Ե�',3500,sysdate);
insert into aug30_snack values(aug30_snack_seq.nextval,'�����','������',1500,sysdate);
insert into aug30_snack values(aug30_snack_seq.nextval,'��������','����',1500,sysdate);
insert into aug30_snack values(aug30_snack_seq.nextval,'��¡���','ũ���',2000,sysdate);
insert into aug30_snack values(aug30_snack_seq.nextval,'��Ŭ����','ũ���',4000,sysdate);
insert into aug30_snack values(aug30_snack_seq.nextval,'���޴���','ũ���',3000,sysdate);
insert into aug30_snack values(aug30_snack_seq.nextval,'����','����',1000,sysdate);
insert into aug30_snack values(aug30_snack_seq.nextval,'�ٰ�Ʈ','ũ���',1000,sysdate);
insert into aug30_snack values(aug30_snack_seq.nextval,'Ŀ�ǻ���','����',5000,sysdate);
insert into aug30_snack values(aug30_snack_seq.nextval,'ġ������ũ','������',4500,sysdate);
insert into aug30_snack values(aug30_snack_seq.nextval,'����','����',2500,sysdate);
insert into aug30_snack values(aug30_snack_seq.nextval,'�Ұ�����','�Ե�',3000,sysdate);


------------------------------------------------------------------------------------------


1.���������� ����...snack ���̺� �̿��Ͽ� �������� �ۼ�

--���ڵ� �� �ְ�
select max(s_price)from snack;
--���Ϻ�� �����̸�,������,����
select s_name , s_maker , s_price from snack where s_price in (select max(s_price) from snack);
--���� �� ���ڴ� ��𿡼� ���峪��
select s_maker from snackwhere s_price = (select min(s_price)from snack);
--��հ����� ��� ���ڴ� �� ����?
select count(s_name) from snack where s_price > (select avg(s_price)from snack);
--��������� ���� �������� ������ ��ü����.
select * from snack where s_date = (select max(s_date)from snack);

create table snack (
s_no number(5) primary key,
s_name varchar(10 char) not null,
s_maker varchar(10 char) not null,
s_price number(10)not null,
s_date date not null
);

create sequence snack_seq;

insert into snack values(snack_seq.nextval,'����Ŀ��','������',2000,sysdate);
insert into snack values(snack_seq.nextval,'������','�Ե�',2500,sysdate);
insert into snack values(snack_seq.nextval,'������','��ī�ݶ�',500,sysdate);
insert into snack values(snack_seq.nextval,'��ĵ��','�Ե�',3500,sysdate);
insert into snack values(snack_seq.nextval,'�����','������',1500,sysdate);
insert into snack values(snack_seq.nextval,'��������','����',1500,sysdate);
insert into snack values(snack_seq.nextval,'��¡���','ũ���',1500,sysdate);
insert into snack values(snack_seq.nextval,'��Ŭ����','ũ���',1500,sysdate);
insert into snack values(snack_seq.nextval,'���޴���','ũ���',1500,sysdate);


------------------------------------------------------------------------
2.������ ���� snack table and maker table �� �̿��Ͽ� ���������� �ۼ�

--���� �� ���� ���� ȸ�翡�� ����� �����̸�, ����
select s_price , s_name from snack where s_maker=(select m_name from maker where m_staff = (select min(m_staff)from maker));
--���� ��� ���ڸ� ����� ȸ��� ��� �ִ���
select m_address from maker where m_name=(select s_maker from snack where s_price=(select max(s_price)from snack ))	;
--��õ�� �ִ� ȸ�翡�� ����� ������ ��հ�
select avg(s_price) from snack where s_maker = (select m_name from maker where m_address = '�Ϻ�'	);
--��հ� �̻��� ���ڸ� ����� ȸ���� �̸�,��ġ --error : single-row subquery ��¼�� ��¼�� in ����ؼ� �ذ�
select m_address,m_name from maker where m_name in (select s_maker from snack where s_price >= (select avg(s_price)from snack));

create table maker (
m_name varchar(20 char) primary key,
m_address varchar(30 char) not null,
m_staff number(3)not null
);

insert into maker values('������','ȭ��',56);
insert into maker values('�Ե�','�Ϻ�',20);
insert into maker values('��ī�ݶ�','�̱�',500);
insert into maker values('ũ���','ȣ��',450);
insert into maker values('����','���ѹα�',980);

select * from maker;
----------------------------------------------------------------------------------
1.���� ���̺�� ī�� ���̺��� �����
--���� ���̺� : ���� �̸�/ ���� / �Ǹ��ϴ� ī���� �̸�
--ī�����̺� : ī���̸� / ���� / �¼���
--���� �� ���̺��� Ŀ���̸�, ī���̸��� ������ ���� ���´�.

2.���ǿ� �´� ���̺� ����
--aī��� ���￡ ��ġ�ϰ� �¼��� 100�� �Ƹ޸�ī�� 2õ��, �� 3õ��, ���� 2500��.
--bī��� �Ǳ��� ��ġ�ϰ� �¼��� 80��  ȫ�� 2500��,	������ 3õ��, ���������� 4õ��.

3.������ �ۼ�
-- ��հ����� ��� ����� �� ���� ����
select count(d_name) from drink where d_price > (select avg(d_price)from drink);
-- ���� �� ���Ḧ �Ĵ� ī���� �̸���
select d_cafe from drink where d_price =(select min(d_price)from drink);
-- ���￡ �ִ� ī�信�� ����� ���� ��հ�����
select avg(d_price) from drink where d_cafe =(select c_name from cafe where c_location = '����');
-- �¼��� 90�� �̻��� ī�信�� �Ĵ� ������ �̸���
select d_name from drink where d_cafe = (select c_name from cafe where c_seat >= 90);
-- ��հ� ������ ������ �̸�
select d_name from drink where d_price <= (select avg(d_price)from drink);
-- ���� ��� ���Ḧ �Ĵ� ī��� ��� �ִ���
select d_cafe from drink where d_price =(select max(d_price)from drink);

create table drink (
d_name varchar2(30 char) primary key,
d_price number(8) not null,
d_cafe varchar2(30 char) not null
);
insert into drink values('�Ƹ޸�ī��',2000,'a');
insert into drink values('��',3000,'a');
insert into drink values('����',2500,'a');
insert into drink values('ȫ��',2500,'b');
insert into drink values('������',3000,'b');
insert into drink values('����������',4000,'b');

create table cafe (
c_name varchar2(30 char) primary key,
c_location varchar2(30 char) not null,
c_seat number(4) not null
);

select round(avg(d_price))from drink;
drop table cafe cascade constraint purge;
insert into cafe values('a','����',100);
insert into cafe values('b','�Ǳ�',80);
---------------------------------------------------------------------------------------



--�¼� �� ���� ���� �Ĵ� ��ϴ� ����� ��ü���� ��ȸ
--���������� �޴� ��ü�� �̸�, ������ ���� �������� ������ ���ٸ� �޴����� ������ ���� ���� (������ �������ϰ� �������� oredr by �÷��� asc/desc , ����)
--��ü ����Ե� �̸�,���� ��ȸ
--���������� �Ĵ� �� ��?
--���������� �޴� ��ü�� ��հ�
--���� ��� �޴� �̸�, ����
--�ֿ����� ������� �̸� ,����
--�¼� ���� ���� ���� �Ĵ��� �̸� ,������ ����,�¼���
--ȫ����� �Ǳ��� ��ϴ� ����� �̸�,����
--������ �� ������ ��𰡸� ���� �� �ֳ���
--�ֿ��� ����Գ� ���� �޴� �̸�,����
----------------------------���� Ȱ��---------------------------------------------------
-- ��ü �Ĵ� �̸�,������,����� �̸�, ����Ի���
-- ��ü �޴���, ����, �Ĵ��̸�, ������
-- �¼��� �� 50�� �̻��� �Ĵ��� �޴���,����,�Ĵ��̸�,������,�¼���
-- �Ը� ���� ū �Ĵ��� �޴���, ����, �Ĵ��̸�, ������, �¼���
-- �ֿ����� ����Գ� ��ü �޴���, ����, �Ĵ��̸�, ������ ,������̸�, ������ �޴��� - �����ټ�, �Ĵ��̸�- �����ټ�.

----------------------------�ο�� --------------------------------
�޴����̺� m_no (sequence ó���� ġ������ ������ �־  �����۾� �� ���)
--�޴� �̸��� ������ ������ �����ؼ� �޴� ��ü ������ ��ȸ�غ���.
--2~4 ���� �޴����̺� ������ �޴������� ������ ��
--�浿 �̸��� ���� ����Գ� �޴���,����,�Ĵ��,������,������̸� ���� �� �������� ������ ���ٸ� �޴����� �����ټ� 3~8��° ���� ��ȸ.
--�达 ���� ���� ����Գ� �޴���,����,������̸�,����� ���� �� ������ ������������ �������ؼ� 2~3�������� 





select [distinct] �÷���,������,����Լ�,from���̺�� where���ǽ� 
group by �׷��� �÷���
having �Լ����� ���ǽ�
order by ���Ĵ�� asc , desc

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
--��ľ� ����������

ȫ����� �Ǳ����� ȫ�浿�� ��ϰ� 100��
ȫ����� �������� ��浿�� ��ϰ� 80��
�ѽ����� �������� ȫ�浿�� ��ϰ� 150��
��õ���� ��õ���� �ֱ浿�� ��ϰ� 130��

create table store (
f_no number(3)primary key,
f_name varchar2 (30char) not null,
f_location varchar2 (30char)not null,
f_ceo number(3) not null,
f_seat number(5) not null
);
create sequence store_seq;


insert into store values(store_seq.nextval,'ȫ�����','�Ǳ�',1,100);
insert into store values(store_seq.nextval,'ȫ�����','����',2,80);
insert into store values(store_seq.nextval,'�ѽ�����','����',3,150);
insert into store values(store_seq.nextval,'��õ����','��õ',4,130);





ȫ�浿,1990�� 03�� 1�ϻ� ����
��浿,1992�� 02�� 1�ϻ� ����
ȫ�浿 1991�� 12�� 12�ϻ� ����
�ֱ浿 1989�� 09�� 1�ϻ� ����

create table ceo (
c_no number(3) primary key,
c_name varchar2(30char) not null,
c_birthday date not null,
c_gender varchar2 (10char) not null
);

create sequence ceo_seq;


insert into ceo values(ceo_seq.nextval,'ȫ�浿',to_date('1990-03-01','YYYY-MM-DD'),'����');
insert into ceo values(ceo_seq.nextval,'��浿',to_date('1992-02-01','YYYY-MM-DD'),'����');
insert into ceo values(ceo_seq.nextval,'ȫ�浿',to_date('1991-12-12','YYYY-MM-DD'),'����');
insert into ceo values(ceo_seq.nextval,'�ֱ浿',to_date('1989-09-01','YYYY-MM-DD'),'����');

select c_birthday from ceo where  c_name ='ȫ�浿' and c_no=1;

--���̺� �ϳ��������.. ¥���
create table menu(
m_no number (3) primary key,
m_name varchar2(20char) not null,
m_price number(6) not null,
m_f_no number(3) not null
);

create sequence menu_seq;

insert into menu values(menu_seq.nextval,'�����',4000,1);
insert into menu values(menu_seq.nextval,'«��',5000,1);
insert into menu values(menu_seq.nextval,'������',9000,1);
insert into menu values(menu_seq.nextval,'�����',4000,2);
insert into menu values(menu_seq.nextval,'«��',5000,2);
insert into menu values(menu_seq.nextval,'������',9000,2);
insert into menu values(menu_seq.nextval,'�����',4000,3);
insert into menu values(menu_seq.nextval,'«��',5000,3);
insert into menu values(menu_seq.nextval,'������',9000,3);
insert into menu values(menu_seq.nextval,'�����',4000,4);
insert into menu values(menu_seq.nextval,'«��',5000,4);
insert into menu values(menu_seq.nextval,'������',9000,4);


-------------------------------------------------------

join : �ϳ��� ��ɹ��� ���� ���� ���̺� ����� �����͸� �ѹ��� ��ȸ�� �� �ִ� ���.

create table tb1 (name varchar2(10char), age number(3));
create table tb2 (name varchar2(10char), age number(3));

insert into tb1 values ('����',30);
insert into tb1 values ('�ں��',35);
insert into tb1 values ('�ֺ��',40);
insert into tb1 values ('�����',40);

insert into tb2 values ('����',30);
insert into tb2 values ('�����',50);
insert into tb2 values ('�̺��',55);

--cross join : ������ ���� ���� �� ���̺� ���� ������ ��� ����� ��ȸ (��� ����� ��) ��ǻ� �Ⱦ�;
select * from tb1, tb2;
select * from tb1 cross join tb2;

--inner join : ���ǿ� �ش��ϴ� ���� ����.
select * from tb1 inner join tb2 on tb1.name = tb2.name;
select * from tb1 a, tb2 b where a.name = b.name;   --equi ����	: ���� ũ�ν� ���ο� ������ ���� ���ǿ��´°�ã�°�
select * from tb1 join tb2 using (name);			--equi ����2	: 
select * from tb1 natural join tb2;					--�ڿ����� 	: ������ ���� ���ʿ� ���� �̸��� ���� ������ �÷����� ��ȸ

--outer join : ������ �� ���̺��� �����Ͱ� ��� ��ȸ���ǰ� ��� ���̺��� �����Ͱ� �ִ°�� �ش� �÷��� ���� �������� ���ؼ����
--			1. left outer join : ���� ���̺� ���� ���� �� ������ ���̺��� ���ǿ� ���� �ʾƵ�(null)���� ����.
select * from tb1 left outer join tb2 on tb1.name = tb2.name;
select * from tb1,tb2 where tb1.name = tb2.name(+);

--			2. right outer join : ������ ���̺� ���� ���� �� ���� ���̺��� ���ǿ� ���� �ʾƵ�(null)���� ����. ����Ʈ�� �ַ� ����� �̰� �߾Ⱦ�.
select * from tb1 right outer join tb2 on tb1.name = tb2.name;
select * from tb1,tb2 where tb1.name(+) = tb2.name;

--			3. full outer join : ���� ���̺� ���� ���� �� , �ٸ��� ���̺��� ������ ���� �ʾƵ� ������ ����
select * from tb1 full outer join tb2 on tb1.name = tb2.name;

--self join ** �򰥸� : �ϳ��� ���̺� ���� �ִ� �÷����� �����ϴ� ������ �ʿ��� ���. 
-- ���� ���� .
-- �� ������Ʈ�� ȸ���� 5���� �ְ�, �����ڰ� 2���� �ִ�. 
-- ȸ���� �̸��� ���� ȸ�� 1~ 5, �������� �̸��� ������1,2 �̴�.
-- ȸ���� ���̵�� ���� member 1~5 , �������� ���̵�� manager1,2 �̴�.
-- ȸ�� 1~3�������� ������ 1�� �����ϰ� / �������� ������ 2�� �����Ѵ�.
create table member(
m_id varchar2(10 char) primary key,
m_name varchar2(10 char) not null,
m_manager varchar2(10char)
);

insert into member values('member1', 'ȸ��1','manager1');
insert into member values('member2', 'ȸ��2','manager1');
insert into member values('member3', 'ȸ��3','manager1');
insert into member values('member4', 'ȸ��4','manager2');
insert into member values('member5', 'ȸ��5','manager2');
insert into member values('manager1', '������1','null');
insert into member values('manager2', '������2','null');

--�� �����ڰ� � ȸ���� �����ϰ� �ִ��� ������ �ۼ��ض�..�������� �ΰ����ñ䰡��; ;
select a.m_id,a.m_name,b.m_id from member a join member b on a.m_id = b.m_manager;

���ñ��� S ���°� ������ DML �� ������Ʈ, ����Ʈ ������ DML �� ���� DB�� �ڹ� ���� ����..



