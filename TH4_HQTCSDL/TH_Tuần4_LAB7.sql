-- câu 1
CREATE PROCEDURE InsertHangsx
    @mahangsx NCHAR(10),
    @tenhang NVARCHAR(20),
    @diachi NVARCHAR(30),
    @sodt NVARCHAR(20),
    @email NVARCHAR(30)
AS
BEGIN
    IF EXISTS (SELECT * FROM Hangsx WHERE tenhang = @tenhang)
    BEGIN
        PRINT 'Tên hàng dã tồn tại trên cơ sở dữ liệu'
    END
    ELSE
    BEGIN
        INSERT INTO Hangsx (mahangsx, tenhang, diachi, sodt, email)
        VALUES (@mahangsx, @tenhang, @diachi, @sodt, @email)
    END
END

-- câu 2
CREATE PROCEDURE InsertOrUpdateSanPham
    @masp NCHAR(10),
    @mahangsx NCHAR(10),
    @tensp NVARCHAR(20),
    @soluong INT,
    @mausac NVARCHAR(20),
    @giaban MONEY,
    @donvitinh NCHAR(10),
    @mota NVARCHAR(MAX)
AS
BEGIN
    IF EXISTS (SELECT * FROM SanPham WHERE masp = @masp)
    BEGIN
        UPDATE SanPham
        SET mahangsx = @mahangsx,
            tensp = @tensp,
            soluong = @soluong,
            mausac = @mausac,
            giaban = @giaban,
            donvitinh = @donvitinh,
            mota = @mota
        WHERE masp = @masp
    END
    ELSE
    BEGIN
        INSERT INTO SanPham (masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota)
        VALUES (@masp, @mahangsx, @tensp, @soluong, @mausac, @giaban, @donvitinh, @mota)
    END
END

-- câu3
CREATE PROCEDURE DeleteHangsx
    @tenhang NVARCHAR(20)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Hangsx WHERE tenhang = @tenhang)
    BEGIN
        PRINT N'Ten hang không tồn tại'
    END
    ELSE
    BEGIN
        DELETE FROM SanPham WHERE mahangsx IN (SELECT mahangsx FROM Hangsx WHERE tenhang = @tenhang)
        DELETE FROM Hangsx WHERE tenhang = @tenhang
    END
END

-- câu4
CREATE PROCEDURE InsertOrUpdateNhanVien
    @manv NCHAR(10),
    @tennv NVARCHAR(20),
    @gioitinh NCHAR(10),
    @diachi NVARCHAR(30),
    @sodt NVARCHAR(20),
    @email NVARCHAR(30),
    @phong NVARCHAR(30),
    @Flag BIT
AS
BEGIN
    IF @Flag = 0
    BEGIN
        UPDATE NhanVien
        SET tennv = @tennv,
            gioitinh = @gioitinh,
            diachi = @diachi,
            sodt = @sodt,
            email = @email,
            phong = @phong
        WHERE manv = @manv
    END
    ELSE
    BEGIN
        INSERT INTO NhanVien (manv, tennv, gioitinh, diachi, sodt, email, phong)
        VALUES (@manv, @tennv, @gioitinh, @diachi, @sodt, @email, @phong)
    END
END

--câu5
CREATE PROCEDURE InsertOrUpdateNhap
    @sohdn NCHAR(10),
    @masp NCHAR(10),
    @manv NCHAR(10),
    @ngaynhap DATE,
    @soluongN INT,
    @dongiaN MONEY
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM SanPham WHERE masp = @masp)
    BEGIN
        PRINT N'mã sản phẩm không tồn tại trong bảng SanPham '
    END
    ELSE IF NOT EXISTS (SELECT * FROM NhanVien WHERE manv = @manv)
    BEGIN
        PRINT N'mã nhân viên không tồn tại trong bảng NhanVien '
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT * FROM Nhap WHERE sohdn = @sohdn)
        BEGIN
            UPDATE Nhap
            SET masp = @masp,
                manv = @manv,
                ngaynhap = @ngaynhap,
                soluongN = @soluongN,
                dongiaN = @dongiaN
            WHERE sohdn = @sohdn
        END
        ELSE
        BEGIN
            INSERT INTO Nhap (sohdn, masp, manv, ngaynhap, soluongN, dongiaN)
            VALUES (@sohdn, @masp, @manv, @ngaynhap, @soluongN, @dongiaN)
        END
    END
END

-- câu 6
CREATE PROCEDURE InsertOrUpdateHoaDonXuat
    @sohdx NCHAR(10),
    @masp NCHAR(10),
    @manv NCHAR(10),
    @ngayxuat DATE,
    @soluongX INT
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM SanPham WHERE masp = @masp)
    BEGIN
        PRINT 'mã sản phẩm không tồn tại trong bảng SanPham '
    END
    ELSE IF NOT EXISTS (SELECT * FROM NhanVien WHERE manv = @manv)
    BEGIN
        PRINT N'mã nhân viên không tồn tại trong bảng NhanVien '
    END
    ELSE IF NOT EXISTS (SELECT * FROM SanPham WHERE masp = @masp AND soluong >= @soluongX)
    BEGIN
        PRINT N'Số lượng xuất lớn hơn số lượng có trong bảng SanPham'
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT * FROM Xuat WHERE sohdx = @sohdx)
        BEGIN
            UPDATE Xuat
            SET masp = @masp,
                manv = @manv,
                ngayxuat = @ngayxuat,
                soluongX = @soluongX
            WHERE sohdx = @sohdx
        END
        ELSE
        BEGIN
            INSERT INTO Xuat (sohdx, masp, manv, ngayxuat, soluongX)
            VALUES (@sohdx, @masp, @manv, @ngayxuat, @soluongX)
        END
    END
END

-- câu 7
CREATE PROCEDURE DeleteNhanVien
    @manv NCHAR(10)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM NhanVien WHERE manv = @manv)
    BEGIN
        PRINT N'Manv không tồn tại'
    END
    ELSE
    BEGIN
        DELETE FROM Nhap WHERE manv = @manv
        DELETE FROM Xuat WHERE manv = @manv
        DELETE FROM NhanVien WHERE manv = @manv
    END
END


-- câu 8
CREATE PROCEDURE DeleteSanPham
    @masp NCHAR(10)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM SanPham WHERE masp = @masp)
    BEGIN
        PRINT N'Masp không tồn tại'
    END
    ELSE
    BEGIN
        DELETE FROM Nhap WHERE masp = @masp
        DELETE FROM Xuat WHERE masp = @masp
        DELETE FROM SanPham WHERE masp = @masp
    END
END