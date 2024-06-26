/*
	Huỳnh Hoàng Vũ - 20520864 - IT004.M11.KHTN.1
	Cơ sở dữ liệu quản lý giáo vụ
*/
/*
	YÊU CẦU BUỔI THỰC HÀNH 1
  - Làm Bài tập 2 Phần I Bài 1 -> 4
  - Kiểu chữ tiếng việt khi cần thiết
  - Set dateformat dmy 
  - Insert dữ liệu
*/
/*
	1. Tạo quan hệ và khai báo tất cả các ràng buộc khóa chính, khóa ngoại.
	Thêm vào 3 thuộc tính GHICHU, DIEMTB, XEPLOAI cho quan hệ HOCVIEN.
*/
-- DROP DATABASE QuanLyGiaoVu;
-- CREATE DATABASE QuanLyGiaoVu;
USE QuanLyGiaoVu;
SET DATEFORMAT dmy;
-- Tạo các quan hệ
CREATE TABLE Khoa (
	MaKhoa			varchar(4),
	TenKhoa			nvarchar(40),
	NgayThanhLap	smalldatetime,
	TruongKhoa		char(4),
	CONSTRAINT PK_Khoa PRIMARY KEY(MaKhoa),
	-- Trưởng khoa là giáo viên thuộc khoa
	-- Thêm sau vì chưa có GiaoVien
);
CREATE TABLE HocVien (
	MaHV		char(5),
	Ho			nvarchar(40),
	Ten			nvarchar(10),
	NgaySinh	smalldatetime,
	GioiTinh	nvarchar(3),
	NoiSinh		nvarchar(40),
	MaLop		char(3),
	CONSTRAINT PK_HocVien PRIMARY KEY(MaHV),
	-- Khóa ngoại cho MaLop, thêm vào sau vì chưa có Lop
);
CREATE TABLE MonHoc (
	MaMH				varchar(10),	
	TenMonHoc			nvarchar(40),
	SoTinChiLyThuyet	tinyint,
	SoTinChiThucHanh	tinyint,
	MaKhoa				varchar(4),
	CONSTRAINT PK_MonHoc PRIMARY KEY(MaMH),
	CONSTRAINT FK_MaKhoa FOREIGN KEY(MaKhoa) REFERENCES Khoa(MaKhoa),
);
CREATE TABLE DieuKien (
	MaMH		varchar(10),
	MaMHTruoc	varchar(10),
	CONSTRAINT PK_DieuKien PRIMARY KEY(MaMH,MaMHTruoc),
	CONSTRAINT FK_MaMH FOREIGN KEY(MaMH) REFERENCES MonHoc(MaMH),
	CONSTRAINT FK_MaMHTruoc FOREIGN KEY(MaMHTruoc) REFERENCES MonHoc(MaMH),
);
CREATE TABLE GiaoVien (
	MaGV			char(4),
	HoTen			nvarchar(40),
	Ten				nvarchar(10),
	HocVi			varchar(10),
	HocHam			varchar(10),
	GioiTinh		nvarchar(3),
	NgaySinh		smalldatetime,
	NgayVaoLam		smalldatetime,
	HeSo			numeric(4,2),
	MucLuong		money,
	MaKhoa			varchar(4),
	CONSTRAINT PK_GiaoVien PRIMARY KEY(MaGV),
	CONSTRAINT FK_MaKhoa FOREIGN KEY(MaKhoa) REFERENCES Khoa(MaKhoa),
);
CREATE TABLE Lop (
	MaLop			char(3),
	TenLop			nvarchar(40),
	LopTruong		char(5),
	SiSo			tinyint,
	MaGVCN			char(4),
	CONSTRAINT PK_LOP PRIMARY KEY(MaLop),
	CONSTRAINT FK_LopTruong FOREIGN KEY(LopTruong) REFERENCES HocVien(MaHV),
	CONSTRAINT FK_MaGVCN FOREIGN KEY(MaGVCN) REFERENCES GiaoVien(MaGV),
);
CREATE TABLE GiangDay (
	MaLop		char(3),
	MaMH		varchar(10),
	MaGV		char(4),
	HocKy		tinyint,
	Nam			smallint,
	TuNgay		smalldatetime,
	DenNgay		smalldatetime,
	CONSTRAINT PK_GiangDay PRIMARY KEY(MaLop,MaMH),
	CONSTRAINT FK_MaLop FOREIGN KEY(MaLop) REFERENCES Lop(MaLop),
	CONSTRAINT FK_MaMH FOREIGN KEY(MaMH) REFERENCES MonHoc(MaMH),
	CONSTRAINT FK_MaGV FOREIGN KEY(MaGV) REFERENCES GiaoVien(MaGV),
);
CREATE TABLE KetQuaThi (
	MaHV		char(5),
	MaMH		varchar(10),
	LanThi		tinyint,
	NgayThi		smalldatetime,
	Diem		numeric(4,2),
	KetQua		varchar(10),
	CONSTRAINT PK_KetQuaThi PRIMARY KEY(MaHV,MaMH,LanThi),
	CONSTRAINT FK_MaHV FOREIGN KEY(MaHV) REFERENCES HocVien(MaHV),
	CONSTRAINT FK_MaMH FOREIGN KEY(MaMH) REFERENCES MonHoc(MaMH),
);
-- Thêm trưởng khoa là giáo viên thuộc khoa
/* Chưa biết thêm *trưởng khoa phải thuộc khoa* */
ALTER TABLE Khoa
ADD CONSTRAINT FK_TruongKhoa
FOREIGN KEY(TruongKhoa) REFERENCES GiaoVien(MaGV);
-- Thêm khóa ngoại cho MaLop
ALTER TABLE HocVien
ADD CONSTRAINT FK_MaLop
FOREIGN KEY(MaLop) REFERENCES Lop(MaLop);
-- Thêm thuộc tính GhiChu, XepLoai và DiemTB cho quan hệ HocVien
ALTER TABLE HOCVIEN
ADD GhiChu nvarchar(40);
/* Chưa có điều kiện xếp loại => Chưa xếp loại tự động */
ALTER TABLE HOCVIEN
ADD XepLoai nvarchar(10);
/* Chưa có yêu cầu tính điểm trung bình => Chưa tính điểm tự động */
ALTER TABLE HOCVIEN
ADD DiemTB numeric(4,2);
/*
	2. Mã học viên là một chuỗi 5 ký tự, 3 ký tự đầu là mã lớp,
	2 ký tự cuối cùng là số thứ tự học viên trong lớp. VD: “K1101”.
*/
ALTER TABLE HocVien
ADD CONSTRAINT CHK_MaHV
CHECK (MaHV LIKE '___[0-9][0-9]' AND SUBSTRING(MaHV, 1, 3) = MaLop);
/*
	3. Thuộc tính GIOITINH chỉ có giá trị là “Nam” hoặc “Nu”.
*/
ALTER TABLE HocVien
ADD CONSTRAINT CHK_GioiTinh
CHECK (GioiTinh = 'Nam' OR GioiTinh = 'Nữ')
ALTER TABLE GiaoVien
ADD CONSTRAINT CHK_GioiTinh
CHECK (GioiTinh = 'Nam' OR GioiTinh = 'Nữ')
/*
	4. Điểm số của một lần thi có giá trị từ 0 đến 10 và cần lưu đến 2 số lẽ (VD: 6.22).
*/
-- Điểm số đã lưu 2 số lẽ vì kiểu dữ liệu là numeric(4,2)
ALTER TABLE KetQuaThi
ADD CONSTRAINT CHK_Diem
CHECK (Diem >= 0 AND Diem <= 10)
/*
	INSERT DỮ LIỆU
*/
-- Khoa Table
INSERT INTO Khoa (MaKhoa, TenKhoa, NgayThanhLap, TruongKhoa)
VALUES ('KHMT', 'Khoa học máy tính', 7/6/2005, 'GV01');
INSERT INTO Khoa (MaKhoa, TenKhoa, NgayThanhLap, TruongKhoa)
VALUES ('HTTT', 'Hệ thống thông tin', 7/6/2005, 'GV02');
INSERT INTO Khoa (MaKhoa, TenKhoa, NgayThanhLap, TruongKhoa)
VALUES ('CNPM', 'Công nghệ phần mềm', 7/6/2005, 'GV04');
INSERT INTO Khoa (MaKhoa, TenKhoa, NgayThanhLap, TruongKhoa)
VALUES ('MTT', 'Mạng và truyền thông', 20/10/2005, 'GV03');
INSERT INTO Khoa (MaKhoa, TenKhoa, NgayThanhLap, TruongKhoa)
VALUES ('KTMT', 'Kỹ thuật máy tính', 20/12/2005, NULL);
-- Lop Table
INSERT INTO Lop (MaLop, TenLop, LopTruong, SiSo, MaGVCN)
VALUES ('K11', 'Lớp 1 khóa 1', 'K1108', 11, 'GV07');
INSERT INTO Lop (MaLop, TenLop, LopTruong, SiSo, MaGVCN)
VALUES ('K12', 'Lớp 2 khóa 1', 'K1205', 12, 'GV09');
INSERT INTO Lop (MaLop, TenLop, LopTruong, SiSo, MaGVCN)
VALUES ('K13', 'Lớp 3 khóa 1', 'K1305', 12, 'GV14');
-- DieuKien Table
INSERT INTO DieuKien (MaMH, MaMHTruoc)
VALUES ('CSDL', 'CTRR');
INSERT INTO DieuKien (MaMH, MaMHTruoc)
VALUES ('CSDL', 'CTDLGT');
INSERT INTO DieuKien (MaMH, MaMHTruoc)
VALUES ('CTDLGT', 'THDC');
INSERT INTO DieuKien (MaMH, MaMHTruoc)
VALUES ('PTTKTT', 'THDC');
INSERT INTO DieuKien (MaMH, MaMHTruoc)
VALUES ('PTTKTT', 'CTDLGT');
INSERT INTO DieuKien (MaMH, MaMHTruoc)
VALUES ('DHMT', 'THDC');
INSERT INTO DieuKien (MaMH, MaMHTruoc)
VALUES ('LTHDT', 'THDC');
INSERT INTO DieuKien (MaMH, MaMHTruoc)
VALUES ('PTTKHTTT', 'CSDL');
-- MonHoc Table
INSERT INTO MonHoc (MaMH, TenMonHoc, SoTinChiLyThuyet, SoTinChiThucHanh, MaKhoa)
VALUES ('THDC', 'Tin học đại cương', 4, 1, 'KHMT');
INSERT INTO MonHoc (MaMH, TenMonHoc, SoTinChiLyThuyet, SoTinChiThucHanh, MaKhoa)
VALUES ('CTRR', 'Cấu trúc rời rạc', 5, 0, 'KHMT');
INSERT INTO MonHoc (MaMH, TenMonHoc, SoTinChiLyThuyet, SoTinChiThucHanh, MaKhoa)
VALUES ('CSDL', 'Cơ sở dữ liệu', 3, 1, 'HTTT');
INSERT INTO MonHoc (MaMH, TenMonHoc, SoTinChiLyThuyet, SoTinChiThucHanh, MaKhoa)
VALUES ('CTDLGT', 'Cấu trúc dữ liệu và giải thuật', 3, 1, 'KHMT');
INSERT INTO MonHoc (MaMH, TenMonHoc, SoTinChiLyThuyet, SoTinChiThucHanh, MaKhoa)
VALUES ('PTTKTT', 'Phân tích thiết kế thuật toán', 3, 0, 'KHMT');
INSERT INTO MonHoc (MaMH, TenMonHoc, SoTinChiLyThuyet, SoTinChiThucHanh, MaKhoa)
VALUES ('DHMT', 'Đồ họa máy tính', 3, 1, 'KHMT');
INSERT INTO MonHoc (MaMH, TenMonHoc, SoTinChiLyThuyet, SoTinChiThucHanh, MaKhoa)
VALUES ('KTMT', 'Kiến trúc máy tính', 3, 0, 'KHMT');
INSERT INTO MonHoc (MaMH, TenMonHoc, SoTinChiLyThuyet, SoTinChiThucHanh, MaKhoa)
VALUES ('TKCSDL', 'Thiết kế cơ sở dữ liệu', 3, 1, 'HTTT');
INSERT INTO MonHoc (MaMH, TenMonHoc, SoTinChiLyThuyet, SoTinChiThucHanh, MaKhoa)
VALUES ('PTTKHTTT', 'Phân tích thiết kế hệ thống thông tin', 4, 1, 'HTTT');
INSERT INTO MonHoc (MaMH, TenMonHoc, SoTinChiLyThuyet, SoTinChiThucHanh, MaKhoa)
VALUES ('HDH', 'Hệ điều hành', 4, 0, 'KHMT');
INSERT INTO MonHoc (MaMH, TenMonHoc, SoTinChiLyThuyet, SoTinChiThucHanh, MaKhoa)
VALUES ('NMCNPM', 'Nhập môn công nghệ phần mềm', 3, 0, 'CNPM');
INSERT INTO MonHoc (MaMH, TenMonHoc, SoTinChiLyThuyet, SoTinChiThucHanh, MaKhoa)
VALUES ('LTCFW', 'Lập trình C for win', 3, 1, 'CNPM');
INSERT INTO MonHoc (MaMH, TenMonHoc, SoTinChiLyThuyet, SoTinChiThucHanh, MaKhoa)
VALUES ('LTHDT', 'Lập trình hướng đối tượng', 3, 1, 'CNPM');
-- GiangDay Table
INSERT INTO GiangDay (MaLop, MaMH, MaGV, HocKy, Nam, TuNgay, DenNgay)
VALUES ('K11', 'THDC', 'GV07', 1, 2006, 2/1/2006, 12/5/2006);
INSERT INTO GiangDay (MaLop, MaMH, MaGV, HocKy, Nam, TuNgay, DenNgay)
VALUES ('K12', 'THDC', 'GV06', 1, 2006, 2/1/2006, 12/5/2006);
INSERT INTO GiangDay (MaLop, MaMH, MaGV, HocKy, Nam, TuNgay, DenNgay)
VALUES ('K13', 'THDC', 'GV15', 1, 2006, 2/1/2006, 12/5/2006);
INSERT INTO GiangDay (MaLop, MaMH, MaGV, HocKy, Nam, TuNgay, DenNgay)
VALUES ('K11', 'CTRR', 'GV02', 1, 2006, 9/1/2006, 17/5/2006);
INSERT INTO GiangDay (MaLop, MaMH, MaGV, HocKy, Nam, TuNgay, DenNgay)
VALUES ('K12', 'CTRR', 'GV02', 1, 2006, 9/1/2006, 17/5/2006);
INSERT INTO GiangDay (MaLop, MaMH, MaGV, HocKy, Nam, TuNgay, DenNgay)
VALUES ('K13', 'CTRR', 'GV08', 1, 2006, 9/1/2006, 17/5/2006);
INSERT INTO GiangDay (MaLop, MaMH, MaGV, HocKy, Nam, TuNgay, DenNgay)
VALUES ('K11', 'CSDL', 'GV05', 2, 2006, 1/6/2006, 15/7/2006);
INSERT INTO GiangDay (MaLop, MaMH, MaGV, HocKy, Nam, TuNgay, DenNgay)
VALUES ('K12', 'CSDL', 'GV09', 2, 2006, 1/6/2006, 15/7/2006);
INSERT INTO GiangDay (MaLop, MaMH, MaGV, HocKy, Nam, TuNgay, DenNgay)
VALUES ('K13', 'CTDLGT', 'GV15', 2, 2006, 1/6/2006, 15/7/2006);
INSERT INTO GiangDay (MaLop, MaMH, MaGV, HocKy, Nam, TuNgay, DenNgay)
VALUES ('K13', 'CSDL', 'GV05', 3, 2006, 1/8/2006, 15/12/2006);
INSERT INTO GiangDay (MaLop, MaMH, MaGV, HocKy, Nam, TuNgay, DenNgay)
VALUES ('K13', 'DHMT', 'GV07', 3, 2006, 1/8/2006, 15/12/2006);
INSERT INTO GiangDay (MaLop, MaMH, MaGV, HocKy, Nam, TuNgay, DenNgay)
VALUES ('K11', 'CTDLGT', 'GV15', 3, 2006, 1/8/2006, 15/12/2006);
INSERT INTO GiangDay (MaLop, MaMH, MaGV, HocKy, Nam, TuNgay, DenNgay)
VALUES ('K12', 'CTDLGT', 'GV15', 3, 2006, 1/8/2006, 15/12/2006);
INSERT INTO GiangDay (MaLop, MaMH, MaGV, HocKy, Nam, TuNgay, DenNgay)
VALUES ('K11', 'HDH', 'GV04', 1, 2007, 2/1/2007, 18/2/2007);
INSERT INTO GiangDay (MaLop, MaMH, MaGV, HocKy, Nam, TuNgay, DenNgay)
VALUES ('K12', 'HDH', 'GV04', 1, 2007, 2/1/2007, 20/3/2007);
INSERT INTO GiangDay (MaLop, MaMH, MaGV, HocKy, Nam, TuNgay, DenNgay)
VALUES ('K11', 'DHMT', 'GV07', 1, 2007, 18/2/2007, 20/3/2007);
-- GiaoVien Table
INSERT INTO GiaoVien (MaGV, HoTen, HocVi, HocHam, GioiTinh, NgaySinh, NgayVaoLam, HeSo, MucLuong, MaKhoa)
VALUES ('GV01', 'Hồ Thanh Sơn', 'PTS', 'GS', 'Nam', 2/5/1950, 11/1/2004, 5.00, 2250000, 'KHMT');
INSERT INTO GiaoVien (MaGV, HoTen, HocVi, HocHam, GioiTinh, NgaySinh, NgayVaoLam, HeSo, MucLuong, MaKhoa)
VALUES ('GV02', 'Trần Tâm Thành', 'TS', 'PGS', 'Nam', 17/12/1965, 20/4/2004, 4.50, 2025000, 'HTTT');
INSERT INTO GiaoVien (MaGV, HoTen, HocVi, HocHam, GioiTinh, NgaySinh, NgayVaoLam, HeSo, MucLuong, MaKhoa)
VALUES ('GV03', 'Đỗ Nghiêm Phụng', 'TS', 'GS', 'Nữ', 1/8/1950, 23/9/2004, 4.00, 1800000, 'CNPM');
INSERT INTO GiaoVien (MaGV, HoTen, HocVi, HocHam, GioiTinh, NgaySinh, NgayVaoLam, HeSo, MucLuong, MaKhoa)
VALUES ('GV04', 'Trần Nam Sơn', 'TS', 'PGS', 'Nam', 22/2/1961, 12/1/2005, 4.50, 2025000, 'KHMT');
INSERT INTO GiaoVien (MaGV, HoTen, HocVi, HocHam, GioiTinh, NgaySinh, NgayVaoLam, HeSo, MucLuong, MaKhoa)
VALUES ('GV05', 'Mai Thành Danh', 'ThS', 'GV', 'Nam', 12/3/1958, 12/1/2005, 3.00, 1350000, 'HTTT');
INSERT INTO GiaoVien (MaGV, HoTen, HocVi, HocHam, GioiTinh, NgaySinh, NgayVaoLam, HeSo, MucLuong, MaKhoa)
VALUES ('GV06', 'Trần Đoàn Hưng', 'TS', 'GV', 'Nam', 11/3/1953, 12/1/2005, 4.50, 2025000, 'KHMT');
INSERT INTO GiaoVien (MaGV, HoTen, HocVi, HocHam, GioiTinh, NgaySinh, NgayVaoLam, HeSo, MucLuong, MaKhoa)
VALUES ('GV07', 'Nguyễn Minh Tiến', 'ThS', 'GV', 'Nam', 23/11/1971, 1/3/2005, 4.00, 1800000, 'KHMT');
INSERT INTO GiaoVien (MaGV, HoTen, HocVi, HocHam, GioiTinh, NgaySinh, NgayVaoLam, HeSo, MucLuong, MaKhoa)
VALUES ('GV08', 'Lê Thị Trân', 'KS', NULL, 'Nữ', 26/3/1974, 1/3/2005, 1.69, 760500, 'KHMT');
INSERT INTO GiaoVien (MaGV, HoTen, HocVi, HocHam, GioiTinh, NgaySinh, NgayVaoLam, HeSo, MucLuong, MaKhoa)
VALUES ('GV09', 'Nguyễn Tô Lân', 'ThS', 'GV', 'Nữ', 31/12/1966, 1/3/2005, 4.00, 1800000, 'HTTT');
INSERT INTO GiaoVien (MaGV, HoTen, HocVi, HocHam, GioiTinh, NgaySinh, NgayVaoLam, HeSo, MucLuong, MaKhoa)
VALUES ('GV10', 'Lê Trần Anh Loan', 'KS', NULL, 'Nữ', 17/7/1972, 1/3/2005, 1.86, 837000, 'CNPM');
INSERT INTO GiaoVien (MaGV, HoTen, HocVi, HocHam, GioiTinh, NgaySinh, NgayVaoLam, HeSo, MucLuong, MaKhoa)
VALUES ('GV11', 'Hồ Thanh Tùng', 'CN', 'GV', 'Nam', 12/1/1980, 15/5/2005, 2.67, 1201500, 'MTT');
INSERT INTO GiaoVien (MaGV, HoTen, HocVi, HocHam, GioiTinh, NgaySinh, NgayVaoLam, HeSo, MucLuong, MaKhoa)
VALUES ('GV12', 'Trần Văn Anh', 'CN', NULL, 'Nữ', 29/3/1981, 15/5/2005, 1.69, 760500, 'CNPM');
INSERT INTO GiaoVien (MaGV, HoTen, HocVi, HocHam, GioiTinh, NgaySinh, NgayVaoLam, HeSo, MucLuong, MaKhoa)
VALUES ('GV13', 'Nguyễn Linh Đan', 'CN', NULL, 'Nữ', 23/5/1980, 15/5/2005, 1.69, 760500, 'KHMT');
INSERT INTO GiaoVien (MaGV, HoTen, HocVi, HocHam, GioiTinh, NgaySinh, NgayVaoLam, HeSo, MucLuong, MaKhoa)
VALUES ('GV14', 'Trương Minh Châu', 'ThS', 'GV', 'Nữ', 30/11/1976, 15/5/2005, 3.00, 1350000, 'MTT');
INSERT INTO GiaoVien (MaGV, HoTen, HocVi, HocHam, GioiTinh, NgaySinh, NgayVaoLam, HeSo, MucLuong, MaKhoa)
VALUES ('GV15', 'Lê Hà Thành', 'ThS', 'GV', 'Nam', 4/5/1978, 15/5/2005, 3.00, 1350000, 'KHMT');
-- Chưa insert KetQuaThi và HocVien
-- đang nghiên cứu insert bằng file