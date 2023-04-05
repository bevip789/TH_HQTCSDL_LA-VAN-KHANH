--3
CREATE FUNCTION ThongKeSanPham(@TenSanPham NVARCHAR(255), @Nam INT)
RETURNS INT
AS
BEGIN
    DECLARE @TongSoLuong INT;
    SELECT @TongSoLuong = SUM(soluongN) - SUM(soluongX)
    FROM Nhap n
    INNER JOIN Xuat x ON n.masp = x.masp
    INNER JOIN Sanpham sp ON n.masp = sp.masp
    WHERE sp.tensp = @TenSanPham AND YEAR(n.ngaynhap) = @Nam AND YEAR(x.ngayxuat) = @Nam;
    RETURN @TongSoLuong;
END;

DECLARE @KetQua INT;
EXEC @KetQua = ThongKeSanPham 'Galaxy Note1', 2020;
SELECT @KetQua AS 'Tổng số lượng thay đổi';
--4
CREATE FUNCTION TongGiaTriNhap(@NgayNhapBatDau DATE, @NgayNhapKetThuc DATE)
RETURNS INT
AS
BEGIN
    DECLARE @TongGiaTri INT;
    SELECT @TongGiaTri = SUM(soluongN * dongiaN)
    FROM Nhap
    WHERE ngaynhap BETWEEN @NgayNhapBatDau AND @NgayNhapKetThuc;
    RETURN @TongGiaTri;
END;

DECLARE @KetQua INT;
EXEC @KetQua = TongGiaTriNhap '2019-05-02', '2020-07-07';
SELECT @KetQua AS 'Tổng giá trị nhập';
--5
CREATE FUNCTION TongGiaTriXuat(@x INT, @A NVARCHAR(20))
RETURNS INT
AS
BEGIN
	DECLARE @tong INT
	SELECT @tong = SUM(x.soluongX * sp.giaban)
	FROM Xuat x
	INNER JOIN Sanpham sp ON sp.masp = x.Masp
	INNER JOIN Hangsx sx ON sx.Mahangsx = sp.mahangsx
	WHERE sx.Tenhang = @A AND YEAR(x.Ngayxuat) = @x
	RETURN @tong
END;

DECLARE @KetQua INT;
EXEC @KetQua = TongGiaTriXuat 2020,'Samsung';
SELECT @KetQua AS 'Tổng giá trị xuất';

--6

CREATE FUNCTION ThongKeNhanVien(@TenPhong NVARCHAR(255))
RETURNS INT
AS
BEGIN
    DECLARE @SoLuongNhanVien INT;
    SELECT @SoLuongNhanVien = COUNT(*)
    FROM Nhanvien
    WHERE phong = @TenPhong;
    RETURN @SoLuongNhanVien;
END;
go
SELECT dbo.ThongKeNhanVien(N'Kế Toán') AS N'Số Lượng Nhân Viên'
--7

CREATE FUNCTION ThongKeSanPhamXuat(@TenSanPham NVARCHAR(255), @NgayXuat int)
RETURNS INT
AS
BEGIN
    DECLARE @SoLanXuat INT;
    SELECT @SoLanXuat =  SUM(x.soluongX) from Xuat x join Sanpham sp on sp.masp = x.masp where sp.tensp = @TenSanPham and DAY(x.ngayxuat) = @NgayXuat
    RETURN @SoLanXuat;
END;


SELECT dbo.ThongKeSanPhamXuat('F1 Plus', 14) AS 'Số lần xuất';

--8

	CREATE FUNCTION TimSoDienThoaiNhanVien(@SoHoaDonXuat NVARCHAR(255))
	RETURNS NVARCHAR(255)
	AS
	BEGIN
		DECLARE @SoDienThoai NVARCHAR(255);
		SELECT @SoDienThoai = nv.sodt
		FROM Xuat x
		INNER JOIN Nhanvien nv ON x.manv = nv.manv
		WHERE x.sohdx = @SoHoaDonXuat;
		RETURN @SoDienThoai;
	END;

	select dbo.TimSoDienThoaiNhanVien('X01') as N'số điện thoại nhân viên';

--9 

CREATE FUNCTION ThongKeTenSpSanPham(@TenSanPham NVARCHAR(255), @Nam INT)
RETURNS INT
AS
BEGIN
    DECLARE @TongSoLuong INT;
    SELECT @TongSoLuong = SUM(soluongN) - SUM(soluongX)
    FROM Nhap n
    INNER JOIN Xuat x ON n.masp = x.masp
    INNER JOIN Sanpham sp ON n.masp = sp.masp
    WHERE sp.tensp = @TenSanPham AND YEAR(n.ngaynhap) = @Nam AND YEAR(x.ngayxuat) = @Nam;
    RETURN @TongSoLuong;
END;

DECLARE @KetQua INT;
EXEC @KetQua = ThongKeTenSpSanPham 'F1 Plus', 2020;
SELECT @KetQua AS 'Tổng số lượng thay đổi';

--10

CREATE FUNCTION ThongKeSanPhamCuaHang(@TenHang NVARCHAR(255))
RETURNS TABLE
AS
RETURN
(
    SELECT sp.tensp
    FROM Sanpham sp
    INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
    WHERE hsx.tenhang = @TenHang
);

SELECT * FROM ThongKeSanPhamCuaHang('Samsung');