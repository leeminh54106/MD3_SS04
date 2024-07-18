create database chuen_doi_ERD;
use chuen_doi_ERD;
create table phieuxuat(
sopx int primary key auto_increment,
ngayxuat datetime);

create table vattu(
mavt int primary key auto_increment,
tenvt varchar(255));

CREATE TABLE phieuxuatchitiet (
    sopx INT,
    FOREIGN KEY (sopx)
        REFERENCES phieuxuat (sopx),
    mavt INT,
    FOREIGN KEY (mavt)
        REFERENCES vattu (mavt),
    dongiaxuat DOUBLE,
    soluongxuat int
);

CREATE TABLE phieunhap (
    sopn INT,
    ngaynhap DATETIME
);

alter table phieunhap add constraint pk_phieunhap primary key auto_increment (sopn);
CREATE TABLE phieunhapchitiet (
    sopn INT,
    FOREIGN KEY (sopn)
        REFERENCES phieunhap (sopn),
    mavt INT,
    FOREIGN KEY (mavt)
        REFERENCES vattu (mavt),
    dongianhap DOUBLE,
    soluongnhap INT 
);

create table ngacungcap(
manccc int primary key auto_increment,
tenncc varchar(255),
diachi varchar(255),
sodienthoai varchar(11));

CREATE TABLE dondathang (
    sodh INT PRIMARY KEY AUTO_INCREMENT,
    manccc INT,
    FOREIGN KEY (manccc)
        REFERENCES ngacungcap (manccc),
    ngaydh DATETIME
);
CREATE TABLE chitietdonhang (
    mavt INT,
    FOREIGN KEY (mavt)
        REFERENCES vattu (mavt),
    sodh INT,
    FOREIGN KEY (sodh)
        REFERENCES dondathang (sodh)
);

select * from phieuxuat;
insert into phieuxuat (ngayxuat) values ('2024-7-10'),
('2024-6-11'),
('2024-5-23'),
('2024-4-12'),
('2024-3-26'),
('2024-2-27');
insert into phieuxuat (ngayxuat) values ('2024-3-10'),
('2024-1-18');
select * from vattu;
insert into vattu (tenvt) values('gạch'),
('ngói'),
('mái tôn'),
('xi măng'),
('thép hòa phát'),
('cát');

select * from phieuxuatchitiet;
insert into phieuxuatchitiet (sopx,mavt,dongiaxuat,soluongxuat) values(1,1,10000,10),(2,2,20000,12),(3,3,30000,30),(4,4,40000,40),(5,5,50000,50);
INSERT INTO phieuxuatchitiet (sopx,mavt,dongiaxuat,soluongxuat) VALUE(6,1,20000,70);
select * from ngacungcap;
insert into ngacungcap (tenncc,diachi,sodienthoai) values('thái dương','hà nội',09812553344),
('hòa phát','hải phòng',09813456677),('điện máy xanh','thạch bàn',0987788665),('tân dược','nam đinh',098625897),('bến che group','bến tre',098334461),
('sen group','vũng tàu',09814457846);

select * from dondathang;
insert into dondathang(manccc,ngaydh) values (1,'2024-4-11'),(2,'2024-4-13'),(3,'2024-3-15'),(4,'2024-7-09'),(5,'2024-1-01'),(1,'2024-6-20');
insert into dondathang(manccc,ngaydh) values (1,'2024-6-20'), (2,'2024-7-13');

select * from chitietdonhang;
insert into chitietdonhang (mavt,sodh) values(1,3),(3,2),(1,5),(2,4),(5,1),(4,1),(2,5);

select * from phieunhap;
insert into phieunhap(sopn,ngaynhap) values(1,'2024-5-10'),(2,'2024-4-24'),(3,'2024-3-26'),(4,'2024-6-12'),(5,'2024-7-11'),(6,'2024-2-17');

select * from phieunhapchitiet;
insert into phieunhapchitiet (sopn,mavt,dongianhap,soluongnhap) values(1,1,20000,10),(2,1,40000,20),(5,2,50000,10),(4,5,15000,50),(2,2,30000,15);

select vt.*,sum(pxc.soluongxuat) as tong_soluong_xuat  from vattu vt
join phieuxuatchitiet pxc on pxc.mavt = vt.mavt
group by vt.mavt, vt.tenvt
order by tong_soluong_xuat  desc;

select vt.*, sum(pnc.soluongnhap) as kho from vattu vt
join phieunhapchitiet pnc on pnc.mavt = vt.mavt
group by vt.mavt, vt.tenvt
order by kho desc;

select ncc.*,ddh.ngaydh from ngacungcap ncc
join dondathang ddh on ddh.manccc = ncc.manccc
where ddh.ngaydh between '2024-02-12' and '2024-04-22';

select vt.*,ddh.ngaydh,ncc.tenncc from ngacungcap ncc
join dondathang ddh on ddh.manccc = ncc.manccc
join chitietdonhang ctdh on ctdh.sodh = ddh.sodh
join vattu vt on vt.mavt = ctdh.mavt
where ddh.ngaydh between '2024-1-11' and '2024-5-22';

-- Hiển thị tất cả vật tự dựa vào phiếu xuất có số lượng lớn hơn 10
select * from vattu vt 
join phieuxuatchitiet pxc on pxc.mavt = vt.mavt
where pxc.soluongxuat >10;

-- Hiển thị tất cả vật tư mua vào ngày 12/2/2023
select * from vattu vt join phieunhapchitiet pnc on pnc.mavt = vt.mavt
join phieunhap pn on pn.sopn = pnc.sopn
where pn.ngaynhap = '2024-07-11';

-- Hiển thị tất cả vật tư được nhập vào với đơn giá lớn hơn 1.200.000
SELECT vt.mavt, vt.tenvt, SUM(pnc.dongianhap * pnc.soluongnhap) AS tong
FROM vattu vt
JOIN phieunhapchitiet pnc ON vt.mavt = pnc.mavt
GROUP BY vt.mavt, vt.tenvt
HAVING SUM(pnc.dongianhap * pnc.soluongnhap) > 900000;

-- Hiển thị tất cả vật tư được dựa vào phiếu xuất có số lượng lớn hơn 5
select vt.*, pxc.soluongxuat from vattu vt join phieuxuatchitiet pxc on pxc.mavt = vt.mavt where pxc.soluongxuat >= 50;

-- Hiển thị tất cả nhà cung cấp ở long biên có SoDienThoai bắt đầu với 09
insert into ngacungcap values (7,'châm anh group','long biên','0912546635'), (8,'hà linh group','long biên','09125467846'), (9,'lan anh group','long biên','0312546635');
select * from ngacungcap ncc where ncc.diachi = 'long biên'and ncc.sodienthoai like '09%'; 

