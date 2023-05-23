drop database QuanLyBanHang;
create database QuanLyBanHang;
use QuanLyBanHang;

create table Customer (
	cID int primary key auto_increment,
    Name varchar(25),
    cAge tinyint
);

create table `Order` (
	oID int primary key auto_increment,
    cID int,
    oDate date,
    oTotalPrice int default null,
    foreign key (cID) references Customer(cID)
);

create table Product (
	pID int primary key auto_increment,
    pName varchar(25),
    pPrice int
);

create table OrderDetail (
	oID int,
    pID int,
    odQTY int,
    foreign key (oID) references `Order`(oID),
    foreign key (pID) references Product(pID)
);

insert into Customer (Name, cAge)
values	('Minh Quan', 10),
		('Ngoc Oanh', 20),
        ('Hong Ha', 50);

insert into `Order` (cID, oDate)
values	(1, '2006-03-21'),
		(2, '2006-03-23'),
        (1, '2006-03-16');

insert into Product (pName, pPrice)
values	('May Giat', 3),
		('Tu Lanh', 5),
        ('Dieu Hoa', 7),
		('Quat', 1),
        ('Bep Dien', 2);

insert into OrderDetail (oID, pID, odQTY)
values	(1,1,3),
		(1,3,7),
        (1,4,2),
        (2,1,1),
        (3,1,8),
        (2,5,4),
        (2,3,3);

-- select * from Customer;
-- select * from `Order`;
-- select * from Product;
-- select * from OrderDetail;

select oID, oDate, oTotalPrice from `Order`;

select Customer.Name, Product.pName
from Customer 
join `Order` on Customer.cID = `Order`.cID
join OrderDetail on `Order`.oID = OrderDetail.oID
join Product on OrderDetail.pID = Product.pID;

select *
from Customer
where cID not in (select cID from `Order`);

select o.oID as MaHoaDon, o.oDate as NgayBan, sum(od.odQTY * p.pPrice) as GiaTien
from `Order` as o
join OrderDetail as od on o.oID = od.oID
join Product as p on od.pID = p.pID
group by o.oID, o.oDate;