--câu 2
CREATE TRIGGER DeleteOnXuat
ON Xuat
AFTER DELETE
AS
BEGIN
  DECLARE @masp NVARCHAR(10), @slnhap INT;

  SELECT @masp = d.masp, @slnhap = d.soluongX
  FROM deleted d;

  UPDATE Sanpham
  SET soluong = soluong + @slnhap
  WHERE masp = @masp;
END
--câu 3
CREATE TRIGGER UpdateSanPhamOnXuatDelete
ON Xuat
AFTER DELETE
AS
BEGIN
  DECLARE @masp NVARCHAR(10), @slnhap INT;

  SELECT @masp = d.masp, @slnhap = d.soluongX
  FROM deleted d;

  UPDATE Sanpham
  SET soluong = soluong + @slnhap
  WHERE masp = @masp;
END
-- câu 4 
CREATE TRIGGER UpdateSanPhamOnXuat
ON Xuat
AFTER UPDATE
AS
BEGIN
    DECLARE @Count INT, @masp NVARCHAR(10), @slNhap_new INT, @slNhap INT

    SELECT @Count = COUNT(*) FROM INSERTED

    IF @Count > 1
    BEGIN
        RAISERROR(N'Số bản ghi thay đổi > 1 bản ghi', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END

    SELECT @masp = i.masp, @slNhap_new = i.soluongX, @slNhap = d.soluongX
    FROM INSERTED i INNER JOIN DELETED d ON i.sohdx = d.sohdx AND i.masp = d.masp

    IF @slNhap_new < @slNhap
    BEGIN
        RAISERROR(N'Số lượng xuất thay đổi nhỏ hơn số lượng trong bảng sản phẩm', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END

    UPDATE Xuat SET soluongX = @slNhap_new WHERE sohdx = (SELECT sohdx FROM INSERTED)

    UPDATE Sanpham SET soluong = soluong + (@slNhap - @slNhap_new) WHERE masp = @masp

END
-- câu 5 
CREATE TRIGGER UpdateNhapOnSoluong
ON Nhap
AFTER UPDATE
AS
BEGIN
    IF (SELECT COUNT(*) FROM inserted) > 1
    BEGIN
        RAISERROR(N'Chỉ được phép cập nhật một bản ghi tại một thời điểm!', 16, 1)
        ROLLBACK TRANSACTION
    END
    ELSE
    BEGIN
        DECLARE @masp NVARCHAR(10), @slNhap INT, @slNhap_new INT
        
        SELECT @masp = i.masp, @slNhap = d.soluongN, @slNhap_new = i.soluongN
        FROM inserted i
        INNER JOIN deleted d ON i.masp = d.masp
        
        IF @slNhap_new < @slNhap
        BEGIN
            RAISERROR(N'Số lượng nhập mới phải lớn hơn số lượng cũ!', 16, 1)
            ROLLBACK TRANSACTION
        END
        ELSE
        BEGIN
            UPDATE Sanpham
            SET soluong = soluong + (@slNhap_new - @slNhap)
            WHERE masp = @masp
        END
    END
END
-- câu 6 
CREATE TRIGGER trg_XoaNhap
ON Nhap
AFTER DELETE
AS
BEGIN
    DECLARE @masp nvarchar(10), @sln int
    SELECT @masp = masp, @sln = soluongN FROM deleted
    UPDATE Sanpham SET soluong = soluong - @sln WHERE masp = @masp
END