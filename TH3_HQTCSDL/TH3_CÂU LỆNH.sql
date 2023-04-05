CREATE VIEW viewHangsx
AS
SELECT * FROM viewHangsx;

CREATE VIEW viewNhanVien
AS
SELECT * FROM viewNhanVien;

CREATE VIEW viewNhap
AS
SELECT * FROM viewNhap;

CREATE VIEW viewSanpham
AS
SELECT * FROM viewSanpham;

CREATE VIEW viewXuat
AS
SELECT * FROM viewXuat;

CREATE VIEW GBgiam
as
select masp,tensp,mahangsx,soluong,mausac,giaban,donvitinh,mota
from SanPham;

select * from GBgiam
order by giaban DESC;


CREATE VIEW MAhangH01
AS
SELECT * FROM Sanpham WHERE mahangsx = 'H01';

select * from MAhangH01;

CREATE VIEW NVketoanN
AS
SELECT * FROM NhanVien 
WHERE gioitinh = N'Nữ' AND phong = N'Kế toán';

select * from NVketoanN;

CREATE VIEW SpNhap
AS
SELECT np.sohdn, sp.masp,
	sp.tensp, hsx.tenhang,
	np.soluongN, np.dongiaN,
	np.soluongN * np.dongiaN as tiennhap,
	sp.mausac, sp.donvitinh, np.ngaynhap,
	nv.tennv, nv.phong
	FROM Nhap np
	INNER JOIN Sanpham sp ON np.masp = sp.masp
	INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
	INNER JOIN Nhanvien nv ON np.manv = nv.manv;

select * from SpNhap;

CREATE VIEW Hdxuat
AS
SELECT hdx.sohdx, sp.masp, sp.tensp, hsx.tenhang, hdx.soluongX, sp.giaban, (hdx.soluongX * sp.giaban) as tienxuat, sp.mausac, sp.donvitinh, hdx.ngayxuat, nv.tennv, nv.phong
FROM Xuat hdx
INNER JOIN SanPham sp ON hdx.masp = sp.masp
INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
INNER JOIN NhanVien nv ON hdx.manv = nv.manv
WHERE MONTH(hdx.ngayxuat) = 12 AND YEAR(hdx.ngayxuat) = 2020;

SELECT * FROM Hdxuat
ORDER BY ngayxuat ASC;

CREATE VIEW SPNSamsung
AS
SELECT N.sohdn, N.masp, S.tensp, N.soluongN, N.dongiaN, N.ngaynhap, NV.tennv, NV.phong
FROM Nhap N
JOIN Sanpham S ON N.masp = S.masp
JOIN Nhanvien NV ON N.manv = NV.manv
JOIN Hangsx H ON S.mahangsx = H.mahangsx
WHERE YEAR(N.ngaynhap) = 2019 AND H.tenhang = 'Samsung';

SELECT * FROM SPNSamsung;

CREATE VIEW top10Xuat2019
AS
SELECT TOP 10 Xuat.sohdx, SanPham.tensp, Xuat.soluongX
FROM Xuat
INNER JOIN SanPham ON Xuat.masp = SanPham.masp
WHERE YEAR(Xuat.ngayxuat) = 2020;

SELECT * FROM top10Xuat2019
ORDER BY soluongX DESC;


CREATE VIEW top10Gia
AS
SELECT TOP 10 SanPham.masp, SanPham.tensp, SanPham.giaban
FROM SanPham;

select * from top10Gia
ORDER BY giaban DESC;

CREATE VIEW SamsungProducts AS
SELECT Sanpham.masp, Sanpham.tensp, Sanpham.giaban, Sanpham.donvitinh, Hangsx.tenhang
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND Sanpham.giaban >= 100000 AND Sanpham.giaban <= 500000;

SELECT * FROM SamsungProducts;

CREATE VIEW SamsungTotalImport AS
SELECT SUM(Nhap.soluongN * SanPham.giaban) AS TongTienNhap
FROM Nhap
JOIN SanPham ON Nhap.masp = SanPham.masp
JOIN Hangsx ON SanPham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND YEAR(Nhap.ngaynhap) = 2018;

SELECT * FROM SamsungTotalImport;

CREATE VIEW TotalExport AS
SELECT SUM(Xuat.soluongX * SanPham.giaban) AS TongTienXuat
FROM Xuat
JOIN SanPham ON Xuat.masp = SanPham.masp
WHERE Xuat.ngayxuat = '2018-09-02';

SELECT * FROM TotalExport;


CREATE VIEW TopImport AS
SELECT top 1 sohdn, ngaynhap
FROM Nhap
WHERE YEAR(ngaynhap) = 2018
ORDER BY soluongN * dongiaN DESC;

SELECT * FROM TopImport;

CREATE VIEW Top10ImportedProducts AS
SELECT TOP 10 SanPham.tensp, SUM(Nhap.soluongN) AS TongSoLuongNhap
FROM Nhap
JOIN SanPham ON Nhap.masp = SanPham.masp
WHERE YEAR(Nhap.ngaynhap) = 2019
GROUP BY SanPham.tensp
ORDER BY SUM(Nhap.soluongN) DESC;

SELECT * FROM Top10ImportedProducts;

CREATE VIEW SamsungProductsByNV01 AS
SELECT SanPham.masp, SanPham.tensp
FROM Nhap
JOIN SanPham ON Nhap.masp = SanPham.masp
JOIN Hangsx ON SanPham.mahangsx = Hangsx.mahangsx
JOIN NhanVien ON Nhap.manv = NhanVien.manv
WHERE Hangsx.tenhang = 'Samsung' AND NhanVien.manv = 'NV01';


SELECT * FROM SamsungProductsByNV01;

CREATE VIEW ImportExportSP02 AS
SELECT Nhap.sohdn, Nhap.masp, Nhap.soluongN, Nhap.ngaynhap
FROM Nhap
JOIN Xuat ON Nhap.masp = Xuat.masp AND Nhap.sohdn = Xuat.sohdx
WHERE Nhap.masp = 'SP02' AND Xuat.manv = 'NV02';

SELECT * FROM ImportExportSP02;

CREATE VIEW EmployeeExportSP02 AS
SELECT Nhanvien.manv, Nhanvien.tennv
FROM Nhanvien
JOIN Xuat ON Nhanvien.manv = Xuat.manv
WHERE Xuat.masp = 'SP02' AND Xuat.ngayxuat = '03-02-2020';

SELECT * FROM EmployeeExportSP02;

CREATE VIEW ProductCountByBrand AS
SELECT Hangsx.tenhang, COUNT(SanPham.masp) AS SoLuongSanPham
FROM Hangsx
LEFT JOIN SanPham ON Hangsx.mahangsx = SanPham.mahangsx
GROUP BY Hangsx.tenhang;

SELECT * FROM ProductCountByBrand;

CREATE VIEW TotalImportByProduct AS
SELECT SanPham.tensp, SUM(Nhap.soluongN * Nhap.dongiaN) AS TongTienNhap
FROM SanPham
INNER JOIN Nhap ON SanPham.masp = Nhap.masp
WHERE YEAR(Nhap.ngaynhap) = 2018
GROUP BY SanPham.tensp;

SELECT * FROM TotalImportByProduct
ORDER BY TongTienNhap DESC;

CREATE VIEW SamsungExport AS
SELECT SanPham.masp, SanPham.tensp, SUM(Xuat.soluongX) AS TongSoLuongXuat
FROM SanPham
INNER JOIN Xuat ON SanPham.masp = Xuat.masp
INNER JOIN Hangsx ON SanPham.mahangsx = Hangsx.mahangsx
WHERE YEAR(Xuat.ngayxuat) = 2018 AND Hangsx.tenhang = 'Samsung'
GROUP BY SanPham.masp, SanPham.tensp
HAVING SUM(Xuat.soluongX) > 10000;


SELECT * FROM SamsungExport ORDER BY TongSoLuongXuat DESC;

CREATE VIEW MaleEmployeeCountByDepartment AS
SELECT phong, COUNT(*) AS soluong_nam
FROM NhanVien
WHERE gioitinh = N'Nam'
GROUP BY phong;

SELECT * FROM MaleEmployeeCountByDepartment;

CREATE VIEW TotalImportByBrand AS
SELECT Hangsx.tenhang, SUM(Nhap.soluongN) AS tong_soluong_nhap
FROM Hangsx JOIN SanPham ON Hangsx.mahangsx = SanPham.mahangsx
             JOIN Nhap ON SanPham.masp = Nhap.masp
WHERE YEAR(Nhap.ngaynhap) = 2018
GROUP BY Hangsx.tenhang;

sELECT * FROM TotalImportByBrand;

CREATE VIEW TotalExportByEmployee AS
SELECT Nhanvien.manv, tennv, SUM(soluongX * giaban) AS tong_tien_xuat
FROM Xuat
JOIN SanPham ON Xuat.masp = SanPham.masp
JOIN NhanVien ON Xuat.manv = NhanVien.manv
WHERE YEAR(ngayxuat) = 2018
GROUP BY Nhanvien.manv, tennv;

SELECT * FROM TotalExportByEmployee;

CREATE VIEW TotalImportByEmployee AS
SELECT manv, SUM(soluongN*dongiaN) as TongTienNhap
FROM Nhap
WHERE MONTH(ngaynhap) = 8 AND YEAR(ngaynhap) = 2018
GROUP BY manv
HAVING SUM(soluongN*dongiaN) > 100000;

SELECT * FROM TotalImportByEmployee;

CREATE VIEW UnexportedProducts AS
SELECT *
FROM SanPham
WHERE masp NOT IN (
  SELECT masp
  FROM Xuat
);

SELECT * FROM UnexportedProducts;