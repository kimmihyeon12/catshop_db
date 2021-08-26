show databases;
create database catshop;
use catshop;

-- 회원테이블
create table users(
id int auto_increment primary key,
user_id char(50) unique,  
password char(50) not null, 
name char(50) not null, 
phone_number char(50) not null unique, 
email char(50) not null unique, 
create_at datetime null,
update_at datetime null
);
  
-- 상품카테고리 테이블
 -- 1 강아지용품 2 고양이용품  / 나중에 subcatagory로 분류하기 
create table product_catagory(
catagory_id int primary key auto_increment, -- 상품 카테고리 코드
catagory_name char(100) -- 상품 카테고리 명
);

-- 서브상품카테고리 테이블
 -- 1 장난감 2 라이프용품 3 간식
create table sub_product_catagory(
sub_catagory_id int primary key auto_increment,  
sub_catagory_name char(100), -- 상품 카테고리 명
catagory_id int,
foreign key (catagory_id) references product_catagory(catagory_id)
);
insert into sub_product_catagory value(null,"간식",2);

-- 상품 테이블
create table products(
product_id int primary key auto_increment, -- 상품코드
sub_catagory_id int , -- 상품카테고리 외래키
shpping_id int , -- 배송테이블 외래키
product_name text , -- 상품명
product_explanation text, -- 상품설명
additional_component_products int, -- 상품 외래키 (자기자신 참조) 
create_at datetime,
update_at datetime,
foreign key (additional_component_products) references products(product_id),
foreign key (sub_catagory_id) references sub_product_catagory(sub_catagory_id),
foreign key (shpping_id) references product_shipping(shpping_id)
);

-- 배송관련테이블
 -- 1 택배(2500) 2 소포(4500) 3 등기(1000)
create table product_shipping(
shpping_id int primary key auto_increment,
shpping_method char(20) unique, -- 배송방법 -택배.등기..등
shpping_price int unique       -- 가격 - 2500 ~
);
  
-- 상품 이미지 테이블
create table product_img(
img_id int primary key auto_increment,
product_id int not null,
img_url char(100),
foreign key (product_id) references products(product_id)
);
  
-- 세부사항 테이블
create table product_detail(
detail_id  int primary key auto_increment,
product_id int not null,
product_detail_name text not null, -- 상품 상세명
consumer_price int, -- 소비자가격
selling_price int, -- 실제판매가격(할인가)
add_price int, -- 옵션에 따른 추가가격 
product_quantity int, -- 재고
foreign key (product_id) references products(product_id)
);
  
show tables;
select * from users;
select * from products;
select * from product_detail;
select * from product_img;
select * from product_shipping;
select * from product_catagory;
select * from sub_product_catagory;

drop table product_detail;

insert into products value(null,1,1,"멍티슈 집들이 선물세트","휴지시리즈 멍티슈 장난감 3종을 모두 받아볼 수 있는 선물세트! 개린이 집들이 선물로도 추천해요",null,now(),now());
insert into product_detail value(null,1,"멍티슈 집들이 선물세트(멍티슈 장난감 3종&킁킁노즈워크 트릿)",71000,49000,0,10);
insert into products value(null,1,1,"멍티슈 두루마리","많은 개린이들의 요청으로 출시된 두루마리 모양의 멍티슈 시즌3 장난감!",null,now(),now());
insert into product_detail value(null,2,"멍티슈 두루마리",23900,18900,0,10);
insert into product_detail value(null,2,"멍티슈 집들이 선물세트",23900,18900,30000,7);
insert into products value(null,1,1,"멍티슈2 잘풀리는 댕댕이네","멍티슈보다 더 길~어지고 어려워진 각티슈.ver 노즈워크 장난감",null,now(),now());
insert into product_detail value(null,3,"멍티슈2 잘풀리는 댕댕이네",19900,14900,0,10);
insert into product_detail value(null,3,"멍티슈2 집들이 선물세트",19900,14900,34000,7);