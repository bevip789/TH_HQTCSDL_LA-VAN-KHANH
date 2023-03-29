--phần 1 
/*1*/
select * from dbo.Hangsx;
select * from dbo.NhanVien;
select * from dbo.Nhap;
select * from dbo.SanPham;
select * from dbo.Xuat;
/*2*/
select masp,tensp,mahangsx,soluong,mausac,giaban,donvitinh,mota
from SanPham
order by giaban DESC;
/*3*/
SELECT * FROM Sanpham WHERE mahangsx = 'H01';

/*4*/
SELECT * FROM NhanVien 
WHERE gioitinh = N'Nữ' AND phong = N'Kế toán'

/*5*/

SELECT np.sohdn, sp.masp,
	sp.tensp, hsx.tenhang,
	np.soluongN, np.dongiaN,
	np.soluongN * np.dongiaN as tiennhap,
	sp.mausac, sp.donvitinh, np.ngaynhap,
	nv.tennv, nv.phong
	FROM Nhap np
	INNER JOIN Sanpham sp ON np.masp = sp.masp
	INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
	INNER JOIN Nhanvien nv ON np.manv = nv.manv
	ORDER BY tiennhap ASC;

/*6*/

SELECT hdx.sohdx, sp.masp, sp.tensp, hsx.tenhang, hdx.soluongX, sp.giaban, (hdx.soluongX * sp.giaban) as tienxuat, sp.mausac, sp.donvitinh, hdx.ngayxuat, nv.tennv, nv.phong
FROM Xuat hdx
INNER JOIN SanPham sp ON hdx.masp = sp.masp
INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
INNER JOIN NhanVien nv ON hdx.manv = nv.manv
WHERE MONTH(hdx.ngayxuat) = 10 AND YEAR(hdx.ngayxuat) = 2018
ORDER BY hdx.ngayxuat ASC



/*7*/

SELECT N.sohdn, N.masp, S.tensp, N.soluongN, N.dongiaN, N.ngaynhap, NV.tennv, NV.phong
FROM Nhap N
JOIN Sanpham S ON N.masp = S.masp
JOIN Nhanvien NV ON N.manv = NV.manv
JOIN Hangsx H ON S.mahangsx = H.mahangsx
WHERE YEAR(N.ngaynhap) = 2017 AND H.tenhang = 'Samsung';

/*8*/

SELECT TOP 10 Xuat.sohdx, SanPham.tensp, Xuat.soluongX
FROM Xuat
INNER JOIN SanPham ON Xuat.masp = SanPham.masp
WHERE YEAR(Xuat.ngayxuat) = 2020
ORDER BY Xuat.soluongX DESC

/*9*/

SELECT TOP 10 SanPham.masp, SanPham.tensp, SanPham.giaban
FROM SanPham
ORDER BY SanPham.giaban DESC

/*10*/

SELECT Sanpham.masp, Sanpham.tensp, Sanpham.giaban, Sanpham.donvitinh, Hangsx.tenhang
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND Sanpham.giaban >= 100000 AND Sanpham.giaban <= 500000;

/*11*/

SELECT SUM(Nhap.soluongN * SanPham.giaban) AS TongTienNhap
FROM Nhap
JOIN SanPham ON Nhap.masp = SanPham.masp
JOIN Hangsx ON SanPham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND YEAR(Nhap.ngaynhap) = 2018

/*12*/

SELECT SUM(Xuat.soluongX * SanPham.giaban) AS TongTienXuat
FROM Xuat
JOIN SanPham ON Xuat.masp = SanPham.masp
WHERE Xuat.ngayxuat = '2018-09-02'

/*13*/

SELECT top 1 sohdn, ngaynhap
FROM Nhap
WHERE YEAR(ngaynhap) = 2018
ORDER BY soluongN * dongiaN DESC


/*14*/

SELECT TOP 10 SanPham.tensp, SUM(Nhap.soluongN) AS TongSoLuongNhap
FROM Nhap
JOIN SanPham ON Nhap.masp = SanPham.masp
WHERE YEAR(Nhap.ngaynhap) = 2019
GROUP BY SanPham.tensp
ORDER BY SUM(Nhap.soluongN) DESC

/*15*/

SELECT SanPham.masp, SanPham.tensp
FROM Nhap
JOIN SanPham ON Nhap.masp = SanPham.masp
JOIN Hangsx ON SanPham.mahangsx = Hangsx.mahangsx
JOIN NhanVien ON Nhap.manv = NhanVien.manv
WHERE Hangsx.tenhang = 'Samsung' AND NhanVien.manv = 'NV01'

/*16*/

SELECT Nhap.sohdn, Nhap.masp, Nhap.soluongN, Nhap.ngaynhap
FROM Nhap
JOIN Xuat ON Nhap.masp = Xuat.masp AND Nhap.sohdn = Xuat.sohdx
WHERE Nhap.masp = 'SP02' AND Xuat.manv = 'NV02';

/*17*/

SELECT Nhanvien.manv, Nhanvien.tennv
FROM Nhanvien
JOIN Xuat ON Nhanvien.manv = Xuat.manv
WHERE Xuat.masp = 'SP02' AND Xuat.ngayxuat = '03-02-2020';
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--phần 2 

/*1*/

SELECT Hangsx.tenhang, COUNT(SanPham.masp) AS SoLuongSanPham
FROM Hangsx
LEFT JOIN SanPham ON Hangsx.mahangsx = SanPham.mahangsx
GROUP BY Hangsx.tenhang

/*2*/

SELECT SanPham.tensp, SUM(Nhap.soluongN * Nhap.dongiaN) AS TongTienNhap
FROM SanPham
INNER JOIN Nhap ON SanPham.masp = Nhap.masp
WHERE YEAR(Nhap.ngaynhap) = 2018
GROUP BY SanPham.tensp
ORDER BY TongTienNhap DESC

/*3*/

SELECT SanPham.masp, SanPham.tensp, SUM(Xuat.soluongX) AS TongSoLuongXuat
FROM SanPham
INNER JOIN Xuat ON SanPham.masp = Xuat.masp
INNER JOIN Hangsx ON SanPham.mahangsx = Hangsx.mahangsx
WHERE YEAR(Xuat.ngayxuat) = 2018 AND Hangsx.tenhang = 'Samsung'
GROUP BY SanPham.masp, SanPham.tensp
HAVING SUM(Xuat.soluongX) > 10000
ORDER BY TongSoLuongXuat DESC

/*4*/

SELECT phong, COUNT(*) AS soluong_nam
FROM NhanVien
WHERE gioitinh = N'Nam'
GROUP BY phong

/*5*/

SELECT Hangsx.tenhang, SUM(Nhap.soluongN) AS tong_soluong_nhap
FROM Hangsx JOIN SanPham ON Hangsx.mahangsx = SanPham.mahangsx
             JOIN Nhap ON SanPham.masp = Nhap.masp
WHERE YEAR(Nhap.ngaynhap) = 2018
GROUP BY Hangsx.tenhang


/*6*/

SELECT Nhanvien.manv, tennv, SUM(soluongX * giaban) AS tong_tien_xuat
FROM Xuat
JOIN SanPham ON Xuat.masp = SanPham.masp
JOIN NhanVien ON Xuat.manv = NhanVien.manv
WHERE YEAR(ngayxuat) = 2018
GROUP BY Nhanvien.manv, tennv

/*7*/

SELECT manv, SUM(soluongN*dongiaN) as TongTienNhap
FROM Nhap
WHERE MONTH(ngaynhap) = 8 AND YEAR(ngaynhap) = 2018
GROUP BY manv
HAVING SUM(soluongN*dongiaN) > 100000

/*8*/

SELECT *
FROM SanPham
WHERE masp NOT IN (
  SELECT masp
  FROM Xuat
)

/*9*/

SELECT sp.*
FROM SanPham sp
INNER JOIN Xuat hd ON sp.masp = hd.masp
WHERE YEAR(sp.mota) = 2018 AND YEAR(hd.ngayxuat) = 2018

/*10*/

SELECT DISTINCT manv, tennv
FROM (
  SELECT manv, tennv, 'Nhap' AS HoatDong
  FROM Nhap
  JOIN NhanVien ON Nhap.manv = NhanVien.manv
  UNION
  SELECT manv, tennv, 'Xuat' AS HoatDong
  FROM Xuat
  JOIN NhanVien ON Xuat.manv = NhanVien.manv
) AS HoatDongNhanVien
ORDER BY manv

/*11*/


SELECT tennv
FROM Nhap n JOIN Xuat x ON n.manv = x.manv JOIN Nhanvien nv ON n.manv = nv.manv
WHERE n.manv NOT IN (SELECT DISTINCT manv FROM Nhap)
AND x.manv NOT IN (SELECT DISTINCT manv FROM Xuat)
GROUP BY nv.manv, NV.tennv