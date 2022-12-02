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
--�¼� �� ���� ���� �Ĵ� ��ϴ� ����� ��ü���� ��ȸ
select *from ceo where c_no =(select f_ceo from STORE where f_seat=(select max(f_seat)from STORE));
--���������� �޴� ��ü�� �̸�, ������ ���� �������� ������ ���ٸ� �޴����� ������ ���� ���� (������ �������ϰ� �������� oredr by �÷��� asc/desc , ����)
select m_name,m_price from menu order by m_price asc ,m_name desc;
--��ü ����Ե� �̸�,���� ��ȸ
select c_name,c_birthday from ceo;
--���������� �Ĵ� �� ��?
select distinct(count(f_name)) from store;
--���������� �޴� ��ü�� ��հ�
select avg(m_price) from menu;
--���� ��� �޴� �̸�, ����
select m_name, m_price from menu where m_price = (select max(m_price)from menu);
--�ֿ����� ������� �̸� ,����
select c_name, c_birthday from ceo where c_birthday =(select max(c_birthday)from ceo);
--�¼� ���� ���� ���� �Ĵ��� �̸� ,������ ����,�¼���
select f_name,f_location,f_seat from store where f_seat=(select min(f_seat)from store);
--ȫ����� �Ǳ��� ��ϴ� ����� �̸�,����
select c_name , c_birthday from ceo where c_no = (select f_ceo from STORE where f_location='�Ǳ�');
--������ �� ������ ��𰡸� ���� �� �ֳ���
select f_name,f_location from STORE where f_no in (select m_f_no from menu where m_name like '%����%');
--�ֿ��� ����Գ� ���� �޴� �̸�,����
select m_name,m_price from menu where m_f_no = (select f_no from store where f_no =    (select c_no from ceo where c_birthday=(select max(c_birthday) from ceo))); 
select m_name,m_price from menu where m_f_no in(select f_no from  store where f_ceo in (select c_no from ceo where c_birthday=(select max(c_birthday) from CEO)));


----------------------------������ �⺻ ����---------------------------------------------------
select * from store,ceo;
select * from store,ceo where f_ceo=c_no;

-- ��ü �Ĵ� �̸�,������,����� �̸�, ����Ի���
select f_name,f_location,c_name,c_birthday from store,ceo where f_no = c_no order by m_name,f_name asc;
-- ��ü �޴���, ����, �Ĵ��̸�, ������
select m_name,m_price,f_name,f_location from menu,store where f_no=m_f_no order by m_name,f_name asc;
-- �¼��� �� 50�� �̻��� �Ĵ��� �޴���,����,�Ĵ��̸�,������,�¼���
select m_name,m_price,f_name,f_location,f_seat from menu,store where f_seat >= 50 and f_no = m_f_no order by m_name,f_name asc;
-- �Ը� ���� ū �Ĵ��� �޴���, ����, �Ĵ��̸�, ������, �¼���
select m_name,m_price,f_name,f_location,f_seat from menu,store where f_seat = (select max(f_seat)from store) and f_no = m_f_no order by m_name,f_name asc;
-- �ֿ����� ����Գ� ��ü �޴���, ����, �Ĵ��̸�, ������ ,������̸�, ���� 
select m_name ,m_price,f_name,f_location,c_name,c_birthday from menu,store,ceo where c_birthday = (select min(c_birthday)from ceo) and f_no = m_f_no and m_f_no=c_no order by m_name,f_name asc;
-- 			�� �޴��� - �����ټ�, �Ĵ��̸�- �����ټ�.

------------------------------������ ������--------------------------------
�޴� ���̺� ���� ���� �������� ���̰��ϱ�.
--�޴����̺� m_no (sequence ó���� ġ������ ������ �־  �����۾� �� ���)
���� ������ ���� ó����� 
- rownum(�����ʵ�):����Ʈ �Ҷ����� �ڵ����� �ο��ǰ�, * ���� ���� ����� �� ����, order by ���� ���� �ο����ǰ�,������ 1������ ��ȸ�ؾ� �Ѵ�.
--�޴� �̸��� ������ ������ �����ؼ� �޴� ��ü ������ ��ȸ�غ���.
select rownum,m_no, m_name,m_price,m_f_no from menu order by m_name;
--�޴� �̸��� ������ ������ �����ؼ� menu���̺� rownum 1~3���� ��ü ������ ��ȸ.
select rownum,m_no, m_name,m_price,m_f_no from menu where rownum >=1 and rownum <=3 order by m_name;
--��ó�� �ϸ� order by ���� �ο���� ���� �����ǰ� order by�� �ڼ��� ������ �޶��� �׷� ������ �ٲ� �Ẹ��.
select rownum,m_no, m_name,m_price,m_f_no from menu order by n_name asc where rownum >=1 and rownum <=3;
--��ó�� �������̸� ���� ���� ���� ���� �߻� . . �ذ���.
select rownum,m_no,m_name,m_price from ( 
select m_no,m_name,m_price from menu order by m_name)  --������ ������ ������ �÷����� ���̺�ó�� �����.
where  rownum >=1 and rownum <=3;
--2~4 ���� �޴����̺� ������ �޴������� ������ ��
select * from(select rownum as �ο�ѹ� ,m_no,m_name,m_price from (select m_no,m_name,m_price from menu order by m_name))where �ο�ѹ� >=2 and �ο�ѹ� <=4;


--------------------------------------------------------------------------------
--�浿 �̸��� ���� ����Գ� 
--		�޴���,����,�Ĵ��,������,������̸�
--		���� �� �������� ������ ���ٸ� �޴����� �����ټ�
--		3~8��° ���� ��ȸ.

select * from (select rownum rn,m_name,m_price,f_name,f_location,c_name from (select m_name,m_price,f_name,f_location,c_name from menu,store,ceo  where m_f_no=f_no and f_no = c_no and c_name like '%�浿%' order by m_price desc,m_name )) where rn >= 3 and rn <=8;

select * from (select rownum rn ,m_name,m_price,f_name,f_location,c_name from (select m_name, m_price, f_name, f_location,c_name from menu,store,ceo where m_f_no=f_no and f_ceo = c_no and c_name like'%�浿%' order by m_price desc,m_name))where rn between 3 and 8;



--�达 ���� ���� ����Գ� �޴���,����,������̸�,����� ���� �� ������ ������������ �������ؼ� 2~3�������� 

select * from (select rownum rn , m_name,m_price,c_name,c_gender from(select m_name,m_price,C_name,c_gender from menu,ceo,store where m_f_no = c_no and c_no=f_ceo and c_name like '%��%' order by m_price asc )) where rn >=2 and rn <=3;
select * from (select rownum rn , m_name,m_price,c_name,c_gender from(select m_name,m_price,C_name,c_gender from menu,ceo,store where m_f_no = c_no and c_no=f_ceo and c_name like '%��%' order by m_price asc )) where rn between 2 and 3;













