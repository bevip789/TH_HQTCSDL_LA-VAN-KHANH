create table NHANVIEN(
	MaNV varchar(9) not null  primary key ,
	HoNV nvarchar(15),
	TenLot nvarchar(30),
	TenNV nvarchar(30),
	NgSinh smalldatetime,
	DiaChi nvarchar(150),
	Phai nvarchar(3),
	Luong numeric(18,0),
	Phong varchar(2)
)
create table PHONGBAN(
	MaPhg varchar(2) not null primary key,
	TenPhg nvarchar(20)
)
create table DEAN(
	MaDA varchar(2) not null primary key,
	TenDA nvarchar(50),
	DDiemDA varchar(20)

)
CREATE TABLE PHANCONG (
    MaNV VARCHAR(9) NOT NULL,
    MaDA VARCHAR(2) NOT NULL,
    ThoiGian NUMERIC(18,0),
   
)

CREATE TABLE THANNHAN (
    MaNV VARCHAR(9) NOT NULL,
    TenTN VARCHAR(20) NOT NULL,
    NgaySinh SMALLDATETIME,
    Phai VARCHAR(3),
    QuanHe VARCHAR(15)
)

