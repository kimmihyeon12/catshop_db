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

insert into product_catagory value(null,"강아지용품");
insert into product_catagory value(null,"고양이용품");

-- 서브상품카테고리 테이블
 -- 1 장난감 2 라이프용품 3 간식
create table sub_product_catagory(
sub_catagory_id int primary key auto_increment,  
sub_catagory_name char(100), -- 상품 카테고리 명
catagory_id int,
foreign key (catagory_id) references product_catagory(catagory_id)
);
insert into sub_product_catagory value(null,"장난감",2);
insert into sub_product_catagory value(null,"라이프용품",2);
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
 
-- 멍멍
insert into products value(null,1,1,"멍티슈 집들이 선물세트","휴지시리즈 멍티슈 장난감 3종을 모두 받아볼 수 있는 선물세트! 개린이 집들이 선물로도 추천해요",null,now(),now());
insert into product_detail value(null,1,"멍티슈 집들이 선물세트(멍티슈 장난감 3종&킁킁노즈워크 트릿)",71000,49000,0,10);
insert into product_img value(null,1,"https://npmp.co.kr/web/product/big/202104/554cb9aecffa7d4d332495c0932f5b98.jpg");
insert into product_img value(null,1,"https://npmp.co.kr/web/product/extra/big/202010/e612c135168ef32dfba98f84d54ffae1.jpg");
insert into product_img value(null,1,"https://npmp.co.kr/web/product/extra/big/202104/ab0b8ae49188511d8d207355a53390bf.jpg");
insert into product_img value(null,1,"https://npmp.co.kr/web/product/extra/big/202104/b6ffecc21d4430b04e40e6f2b3a6e435.jpg");
insert into products value(null,1,1,"멍티슈 두루마리","많은 개린이들의 요청으로 출시된 두루마리 모양의 멍티슈 시즌3 장난감!",null,now(),now());
insert into product_detail value(null,2,"멍티슈 두루마리",23900,18900,0,10);
insert into product_detail value(null,2,"멍티슈 집들이 선물세트",23900,18900,30000,7);
insert into product_img value(null,2,"https://npmp.co.kr/web/product/big/202104/7783dd3512e428d779e824cd7385caab.jpg");
insert into product_img value(null,2,"https://npmp.co.kr/web/product/extra/big/202104/25b3f84fac79737107333ce45c02ffa2.jpg");
insert into product_img value(null,2,"https://npmp.co.kr/web/product/extra/big/202104/2e2646ef3117420288e85c8ca17d79b6.jpg");
insert into product_img value(null,2,"https://npmp.co.kr/web/product/extra/big/202104/e2a77c3dd7115e16997f2e70c8100a77.jpg");
insert into products value(null,1,1,"멍티슈2 잘풀리는 댕댕이네","멍티슈보다 더 길~어지고 어려워진 각티슈.ver 노즈워크 장난감",null,now(),now());
insert into product_detail value(null,3,"멍티슈2 잘풀리는 댕댕이네",19900,14900,0,10);
insert into product_detail value(null,3,"멍티슈2 집들이 선물세트",19900,14900,34000,7);
insert into product_img value(null,3,"https://npmp.co.kr/web/product/big/202103/a59cdb9bfcba8773c99bbc5cf0518985.jpg");
insert into product_img value(null,3,"https://npmp.co.kr/web/product/extra/big/202010/e8e3da6ab5dfd548cb33a1b01abd5a4c.jpg");
insert into product_img value(null,3,"https://npmp.co.kr/web/product/extra/big/202010/dc1da7e5302e9432957ff663bb850617.jpg");
insert into product_img value(null,3,"https://npmp.co.kr/web/product/extra/big/202010/e612c135168ef32dfba98f84d54ffae1.jpg");

insert into products value(4,2,1,"멍멍 슬개골보호용 우다다매트","",null,now(),now());
insert into product_detail value(null,4,"우다다메트 2칸 120*140",90000,79000,0,10);
insert into product_detail value(null,4,"우다다메트 4칸 240*140",90000,79000,49100,10);
insert into product_img value(null,4,"https://npmp.co.kr/web/product/big/202103/7a694bf9b2f9dd9d42e1c3b3dd972224.jpg");
insert into product_img value(null,4,"https://npmp.co.kr/web/product/extra/big/202011/67a0f441b1cdd88bcc4012f2497c0e2c.jpg");
insert into product_img value(null,4,"https://npmp.co.kr/web/product/extra/big/202011/22949d7b94905d4fb170e59cffd07cc4.jpg");
insert into product_img value(null,4,"https://npmp.co.kr/web/product/extra/big/202011/ae627bbefae3b14a96c2a3bc5274819b.jpg");
insert into products value(5,2,1,"냥멍 쓰담브러쉬","",null,now(),now());
insert into product_detail value(null,5,"냥멍 쓰담브러쉬",24000,19800,0,10);
insert into product_img value(null,5,"https://npmp.co.kr/web/product/big/202103/3467055af2b6241f533ce86a6fb6b55f.jpg");
insert into product_img value(null,5,"https://npmp.co.kr/web/product/extra/big/201908/26ab8285139b36e340aa8683ec19cc97.jpg");
insert into product_img value(null,5,"https://npmp.co.kr/web/product/extra/big/201909/555aa111032ef3b5b58735581dc5093f.jpg");
insert into product_img value(null,5,"https://npmp.co.kr/web/product/extra/big/201908/09491b16274c164b8e1e65589bf2b045.jpg");
insert into products value(6,2,1,"냥멍 치카치약","",null,now(),now());
insert into product_detail value(null,6,"냥멍 치카치약",8900,7900,0,3);
insert into product_img value(null,6,"https://npmp.co.kr/web/product/big/202103/c4bc538d28c5c3e6d893ce30f1eb1d05.jpg");
insert into product_img value(null,6,"https://npmp.co.kr/web/product/extra/big/201909/43ab5346574db4e938b7ab958969ceaa.jpg");
insert into product_img value(null,6,"https://npmp.co.kr/web/product/extra/big/201909/51cdbc57907b8c3a0d7bcbb55ee5a3f3.jpg");
insert into product_img value(null,6,"https://npmp.co.kr/web/product/extra/big/201909/b3ac929b63c99e9ffded3ec55bf13e1f.jpg");

insert into products value(7,3,1,"멍멍 덴탈껌 맛있츄","",null,now(),now());
insert into product_detail value(null,7,"멍멍 덴탈껌 맛있츄(11개입)",19800,12800,0,10);
insert into product_detail value(null,7,"멍멍 덴탈껌 맛있츄(33개입)",19800,12800,21300,10);
insert into product_img value(null,7,"https://npmp.co.kr/web/product/big/202103/e64bf5c1bdbad9deae9634f8f31fabc4.jpg");
insert into product_img value(null,7,"https://npmp.co.kr/web/product/extra/big/20191115/a0cd2742849fc358aad9ec5575d51d3d.jpg");
insert into product_img value(null,7,"https://npmp.co.kr/web/product/extra/big/201909/2aa8edf617598e36979aa95bd3130043.jpg");
insert into product_img value(null,7,"https://npmp.co.kr/web/product/extra/big/201909/2aa8edf617598e36979aa95bd3130043.jpg");
insert into products value(8,3,1,"멍멍 건강식 십전개보탕","몸에 좋은 10가지 재료로 만든 특별 건강식 '십전개보탕'",null,now(),now());
insert into product_detail value(null,8,"전복삼계 십전개보탕",6900,4300,0,10);
insert into product_detail value(null,8,"홍합명태 십전개보탕",6900,4300,0,10);
insert into product_detail value(null,8,"사골소고기 십전개보탕",6900,4300,0,10);
insert into product_img value(null,8,"https://npmp.co.kr/web/product/big/202103/2d50c6d45a79a2f156871555df890f0c.jpg");
insert into product_img value(null,8,"https://npmp.co.kr/web/product/extra/big/202009/93f6e7b9be95674d355687583e7bd3fb.jpg");
insert into product_img value(null,8,"https://npmp.co.kr/web/product/extra/big/202009/094e33a4a36beef8558e202e3128c1f1.jpg");
 

-- 냥냥
insert into products value(9,4,1,"냥냥 월척낚시대(8/23 순차출고)","국내 최장신 2.4m 냥냥 월척낚시대",null,now(),now());
insert into product_detail value(null,9,"냥냥 월척낚시대(본품+미끼4종포함)",20000,18000,0,10);
insert into product_detail value(null,9,"월척낚시대 낚시줄 1개",20000,18000,-17500,10);
insert into product_img value(null,9,"https://npmp.co.kr/web/product/big/202103/a421263ab08aec66598109a6ee7e0de3.jpg");
insert into product_img value(null,9,"https://npmp.co.kr/web/product/extra/big/202107/9c8b21e83f4ae761adb4c11f72ae72a3.jpg");
insert into product_img value(null,9,"https://npmp.co.kr/web/product/extra/big/202103/1ef92f7c46630619a1e54f46c5deacf8.jpg");
insert into products value(10,4,1,"냥냥 펀치 토이볼","",null,now(),now());
insert into product_detail value(null,10,"냥냥펀치토이볼(본품1개_+기본 리필장난감 2개 포함)",42400,31800,0,10);
insert into product_img value(null,10,"https://npmp.co.kr/web/product/big/202103/452725f0aa631b4fc2409ea071878d30.jpg");
insert into product_img value(null,10,"https://npmp.co.kr/web/product/extra/big/20200114/39188c21781dc5db71a1138f3746ca9c.jpg");
insert into product_img value(null,10,"https://npmp.co.kr/web/product/extra/big/20200114/5a82f8f66122eb91dfe9b7531078f603.jpg");

insert into products value(11,5,1,"냥멍 쓰담샤워기","샤워와 브러싱을 동시에! 죽은 털 제거에 효과만점",null,now(),now());
insert into product_detail value(null,11,"쓰담샤워기 1개",34200,23900,0,10);
insert into product_img value(null,11,"https://npmp.co.kr/web/product/extra/big/20200114/5a82f8f66122eb91dfe9b7531078f603.jpg");
insert into product_img value(null,11,"https://npmp.co.kr/web/product/extra/big/201905/92f7f181c73560c0f8bfde28ade8469a.jpg");
insert into product_img value(null,11,"https://npmp.co.kr/web/product/extra/big/201905/d62e3953efd0246cb6231069de85467c.jpg");
insert into products value(12,5,1,"감자밭을부탁해 벤토나이트모래","",null,now(),now());
insert into product_detail value(null,12,"감자밭을부탁해 5kg",26900,19900,0,10);
insert into product_detail value(null,12,"감자밭을부탁해 5kg *4",26900,19900,50000,10);
insert into product_detail value(null,12,"감자밭을부탁해 5kg *8",26900,19900,117000,10);
insert into product_img value(null,12,"https://npmp.co.kr/web/product/big/202103/f383f456e9b91268e3867a86f33743db.jpg");
insert into product_img value(null,12,"https://npmp.co.kr/web/product/extra/big/202012/0140e5a56c58c8e7b8dc0c95c5cb2051.jpg");
insert into product_img value(null,12,"	https://npmp.co.kr/web/product/extra/big/202012/fa30956034fd13885dc62b241a095ba7.jpg");
select p.product_id,product_name,consumer_price,selling_price,i.img_url from (select pr.product_id,product_name,consumer_price,selling_price from (select product_id,p.sub_catagory_id,product_name from products p inner join sub_product_catagory sc on p.sub_catagory_id = sc.sub_catagory_id where p.sub_catagory_id=1) as pr inner join product_detail d on pr.product_id=d.product_id group by product_id) as p left outer join product_img i on p.product_id = i.product_id group by p.product_id;
