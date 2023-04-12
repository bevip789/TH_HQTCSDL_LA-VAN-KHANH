-- câu 1
CREATE FUNCTION find_sanpham
(
    @TenHang NVARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        sp.masp AS 'MaSP',
        sp.tensp AS 'TenSP',
        hs.tenhang AS 'TenHang',
        sp.soluong AS 'SoLuong',
        sp.mausac AS 'MauSac',
        sp.giaban AS 'GiaBan',
        sp.donvitinh AS 'DonViTinh',
        sp.mota AS 'MoTa'
    FROM
        Sanpham sp
    INNER JOIN
        Hangsx hs ON sp.mahangsx = hs.mahangsx
    WHERE
        hs.tenhang LIKE '%' + @TenHang + '%'
);


-- câu2
CREATE FUNCTION find_sanpham_hang
(
    @NgayBatDau DATE,
    @NgayKetThuc DATE
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        sp.masp AS 'MaSP',
        sp.tensp AS 'TenSP',
        hs.tenhang AS 'TenHang',
        sp.soluong AS 'SoLuong',
        sp.mausac AS 'MauSac',
        sp.giaban AS 'GiaBan',
        sp.donvitinh AS 'DonViTinh',
        sp.mota AS 'MoTa',
        np.ngaynhap AS 'NgayNhap'
    FROM
        Nhap np
    INNER JOIN
        Sanpham sp ON np.masp = sp.masp
    INNER JOIN
        Hangsx hs ON sp.mahangsx = hs.mahangsx
    WHERE
        np.ngaynhap BETWEEN @NgayBatDau AND @NgayKetThuc
);

-- câu 3
CREATE FUNCTION listSanPham
(
    @MaHangSX NCHAR(10),
    @LuaChon INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT Sanpham.masp, Sanpham.mahangsx, Sanpham.tensp, Sanpham.soluong, Sanpham.mausac, Sanpham.giaban, Sanpham.donvitinh, Sanpham.mota
    FROM Sanpham
    WHERE Sanpham.mahangsx = @MaHangSX
    AND (@LuaChon = 0 AND Sanpham.soluong = 0 OR @LuaChon = 1 AND Sanpham.soluong > 0)
);



--câu 4
CREATE FUNCTION listNhanvien
(
    @TenPhong NVARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT Nhanvien.manv, Nhanvien.tennv, Nhanvien.gioitinh, Nhanvien.diachi, Nhanvien.sodt, Nhanvien.email, Nhanvien.phong
    FROM Nhanvien
    WHERE Nhanvien.phong = @TenPhong
);


-- câu5
CREATE FUNCTION listHangsxLike
(
    @DiaChi NVARCHAR(255)
)
RETURNS TABLE
AS
RETURN
(
    SELECT Hangsx.mahangsx, Hangsx.tenhang, Hangsx.diachi, Hangsx.sodt, Hangsx.email
    FROM Hangsx
    WHERE Hangsx.diachi LIKE '%' + @DiaChi + '%'
);



-- câu 6
CREATE FUNCTION listsanpham_year
(
    @NamBatDau INT,
    @NamKetThuc INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT Sanpham.masp, Sanpham.mahangsx, Sanpham.tensp, Hangsx.tenhang
    FROM Sanpham
    INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
    INNER JOIN Nhap ON Sanpham.masp = Nhap.masp
	WHERE YEAR(Nhap.ngaynhap) BETWEEN @NamBatDau AND @NamKetThuc
);


-- câu 7
CREATE FUNCTION listNhapOrXuat
(
    @GiaBatDau DECIMAL(18, 2),
    @GiaKetThuc DECIMAL(18, 2),
    @TenHangSX NVARCHAR(100)
)
RETURNS TABLE
AS
RETURN
(
    SELECT Sanpham.masp, Sanpham.mahangsx, Sanpham.tensp, Sanpham.giaban
    FROM Sanpham
    INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
    WHERE Sanpham.giaban BETWEEN @GiaBatDau AND @GiaKetThuc
    AND Hangsx.tenhang = @TenHangSX
);

-- câu 8
CREATE FUNCTION listnhanvienN
(
    @NgayNhap DATE
)
RETURNS TABLE
AS
RETURN
(
    SELECT nhanvien.*
    FROM Nhap
    INNER JOIN Nhanvien ON Nhap.manv = Nhanvien.manv
    WHERE Nhap.ngaynhap = @NgayNhap
);

-- câu 9

CREATE FUNCTION listSanPhamXYZ
(
    @Min FLOAT,
    @Max FLOAT,
    @CongTySanXuat NVARCHAR(100)
)
RETURNS TABLE
AS
RETURN
(
    SELECT Sanpham.*, Hangsx.tenhang
    FROM Sanpham
    INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
    WHERE Sanpham.giaban BETWEEN @Min AND @Max
    AND Hangsx.tenhang = @CongTySanXuat
);


