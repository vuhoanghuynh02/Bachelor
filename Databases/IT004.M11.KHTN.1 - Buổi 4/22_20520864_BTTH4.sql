/*
	Huỳnh Hoàng Vũ - 20520864 - IT004.M11.KHTN.1
	Bài tập 2 - Cơ sở dữ liệu quản lý giáo vụ
*/
/*
	THỰC HÀNH 1
  - Làm Phần I Bài 1 -> 4
  - Kiểu chữ tiếng việt khi cần thiết
  - Set dateformat dmy 
  - Insert dữ liệu
*/
/*
	I. 1. Tạo quan hệ và khai báo tất cả các ràng buộc khóa chính, khóa ngoại.
	Thêm vào 3 thuộc tính GHICHU, DIEMTB, XEPLOAI cho quan hệ HOCVIEN.

	Insert dữ liệu
*/
CREATE DATABASE QLGV3;

USE QLGV3;

DROP DATABASE QLGV2;

-- Tạo các quan hệ và khóa chính
CREATE TABLE KHOA (
	MAKHOA			varchar(4),
	TENKHOA			nvarchar(40),
	NGTLAP			smalldatetime,
	TRGKHOA			char(4),
	CONSTRAINT PK_KHOA PRIMARY KEY(MAKHOA),
);
CREATE TABLE HOCVIEN (
	MAHV		char(5),
	HO			nvarchar(40),
	TEN			nvarchar(10),
	NGSINH		smalldatetime,
	GIOITINH	nvarchar(3),
	NOISINH		nvarchar(40),
	MALOP		char(3),
	CONSTRAINT PK_HOCVIEN PRIMARY KEY(MAHV),
);
CREATE TABLE MONHOC (
	MAMH		varchar(10),	
	TENMH		nvarchar(40),
	TCLT		tinyint,
	TCTH		tinyint,
	MAKHOA		varchar(4),
	CONSTRAINT PK_MONHOC PRIMARY KEY(MAMH),
);
CREATE TABLE DIEUKIEN (
	MAMH		varchar(10),
	MAMH_TRUOC	varchar(10),
	CONSTRAINT PK_DIEUKIEN PRIMARY KEY(MAMH,MAMH_TRUOC),
);
CREATE TABLE GIAOVIEN (
	MAGV			char(4),
	HOTEN			nvarchar(40),
	HOCVI			varchar(10),
	HOCHAM			varchar(10),
	GIOITINH		nvarchar(3),
	NGSINH			smalldatetime,
	NGVL			smalldatetime,
	HESO			numeric(4,2),
	MUCLUONG		money,
	MAKHOA			varchar(4),
	CONSTRAINT PK_GIAOVIEN PRIMARY KEY(MAGV),
);
CREATE TABLE LOP (
	MALOP			char(3),
	TENLOP			nvarchar(40),
	TRGLOP			char(5),
	SISO			tinyint,
	MAGVCN			char(4),
	CONSTRAINT PK_LOP PRIMARY KEY(MALOP),
);
CREATE TABLE GIANGDAY (
	MALOP		char(3),
	MAMH		varchar(10),
	MAGV		char(4),
	HOCKY		tinyint,
	NAM			smallint,
	TUNGAY		smalldatetime,
	DENNGAY		smalldatetime,
	CONSTRAINT PK_GIANGDAY PRIMARY KEY(MALOP,MAMH),
);
CREATE TABLE KETQUATHI (
	MAHV		char(5),
	MAMH		varchar(10),
	LANTHI		tinyint,
	NGTHI		smalldatetime,
	DIEM		numeric(4,2),
	KQUA		nvarchar(10),
	CONSTRAINT PK_KETQUATHI PRIMARY KEY(MAHV,MAMH,LANTHI),
);

-- Insert dữ liệu
SET DATEFORMAT dmy;
INSERT INTO KHOA (MAKHOA, TENKHOA, NGTLAP, TRGKHOA)
VALUES
	('KHMT', N'Khoa học máy tính', '7/6/2005', 'GV01'),
	('HTTT', N'Hệ thống thông tin', '7/6/2005', 'GV02'),
	('CNPM', N'Công nghệ phần mềm', '7/6/2005', 'GV04'),
	('MTT', N'Mạng và truyền thông', '20/10/2005', 'GV03'),
	('KTMT', N'Kỹ thuật máy tính', '20/12/2005', NULL);
INSERT INTO LOP (MALOP, TENLOP, TRGLOP, SISO, MAGVCN)
VALUES 
	('K11', N'Lớp 1 khóa 1', 'K1108', 11, 'GV07'),
	('K12', N'Lớp 2 khóa 1', 'K1205', 12, 'GV09'),
	('K13', N'Lớp 3 khóa 1', 'K1305', 12, 'GV14');
INSERT INTO DIEUKIEN (MAMH, MAMH_TRUOC)
VALUES 
	('CSDL', 'CTRR'),
	('CSDL', 'CTDLGT'),
	('CTDLGT', 'THDC'),
	('PTTKTT', 'THDC'),
	('PTTKTT', 'CTDLGT'),
	('DHMT', 'THDC'),
	('LTHDT', 'THDC'),
	('PTTKHTTT', 'CSDL');
INSERT INTO MONHOC (MAMH, TENMH, TCLT, TCTH, MAKHOA)
VALUES 
	('THDC', N'Tin học đại cương', 4, 1, 'KHMT'),
	('CTRR', N'Cấu trúc rời rạc', 5, 0, 'KHMT'),
	('CSDL', N'Cơ sở dữ liệu', 3, 1, 'HTTT'),
	('CTDLGT', N'Cấu trúc dữ liệu và giải thuật', 3, 1, 'KHMT'),
	('PTTKTT', N'Phân tích thiết kế thuật toán', 3, 0, 'KHMT'),
	('DHMT', N'Đồ họa máy tính', 3, 1, 'KHMT'),
	('KTMT', N'Kiến trúc máy tính', 3, 0, 'KHMT'),
	('TKCSDL', N'Thiết kế cơ sở dữ liệu', 3, 1, 'HTTT'),
	('PTTKHTTT', N'Phân tích thiết kế hệ thống thông tin', 4, 1, 'HTTT'),
	('HDH', N'Hệ điều hành', 4, 0, 'KHMT'),
	('NMCNPM', N'Nhập môn công nghệ phần mềm', 3, 0, 'CNPM'),
	('LTCFW', N'Lập trình C for win', 3, 1, 'CNPM'),
	('LTHDT', N'Lập trình hướng đối tượng', 3, 1, 'CNPM');
INSERT INTO GIANGDAY (MALOP, MAMH, MAGV, HOCKY, NAM, TUNGAY, DENNGAY)
VALUES 
	('K11', 'THDC', 'GV07', 1, 2006, '2/1/2006', '12/5/2006'),
	('K12', 'THDC', 'GV06', 1, 2006, '2/1/2006', '12/5/2006'),
	('K13', 'THDC', 'GV15', 1, 2006, '2/1/2006', '12/5/2006'),
	('K11', 'CTRR', 'GV02', 1, 2006, '9/1/2006', '17/5/2006'),
	('K12', 'CTRR', 'GV02', 1, 2006, '9/1/2006', '17/5/2006'),
	('K13', 'CTRR', 'GV08', 1, 2006, '9/1/2006', '17/5/2006'),
	('K11', 'CSDL', 'GV05', 2, 2006, '1/6/2006', '15/7/2006'),
	('K12', 'CSDL', 'GV09', 2, 2006, '1/6/2006', '15/7/2006'),
	('K13', 'CTDLGT', 'GV15', 2, 2006, '1/6/2006', '15/7/2006'),
	('K13', 'CSDL', 'GV05', 3, 2006, '1/8/2006', '15/12/2006'),
	('K13', 'DHMT', 'GV07', 3, 2006, '1/8/2006', '15/12/2006'),
	('K11', 'CTDLGT', 'GV15', 3, 2006, '1/8/2006', '15/12/2006'),
	('K12', 'CTDLGT', 'GV15', 3, 2006, '1/8/2006', '15/12/2006'),
	('K11', 'HDH', 'GV04', 1, 2007, '2/1/2007', '18/2/2007'),
	('K12', 'HDH', 'GV04', 1, 2007, '2/1/2007', '20/3/2007'),
	('K11', 'DHMT', 'GV07', 1, 2007, '18/2/2007', '20/3/2007');
INSERT INTO GIAOVIEN (MAGV, HOTEN, HOCVI, HOCHAM, GIOITINH, NGSINH, NGVL, HESO, MUCLUONG, MAKHOA)
VALUES 
	('GV01', N'Hồ Thanh Sơn', 'PTS', 'GS', N'Nam', '2/5/1950', '11/1/2004', 5.00, 2250000, 'KHMT'),
	('GV02', N'Trần Tâm Thành', 'TS', 'PGS', N'Nam', '17/12/1965', '20/4/2004', 4.50, 2025000, 'HTTT'),
	('GV03', N'Đỗ Nghiêm Phụng', 'TS', 'GS', N'Nữ', '1/8/1950', '23/9/2004', 4.00, 1800000, 'CNPM'),
	('GV04', N'Trần Nam Sơn', 'TS', 'PGS', N'Nam', '22/2/1961', '12/1/2005', 4.50, 2025000, 'KHMT'),
	('GV05', N'Mai Thành Danh', 'ThS', 'GV', N'Nam', '12/3/1958', '12/1/2005', 3.00, 1350000, 'HTTT'),
	('GV06', N'Trần Đoàn Hưng', 'TS', 'GV', N'Nam', '11/3/1953', '12/1/2005', 4.50, 2025000, 'KHMT'),
	('GV07', N'Nguyễn Minh Tiến', 'ThS', 'GV', N'Nam', '23/11/1971', '1/3/2005', 4.00, 1800000, 'KHMT'),
	('GV08', N'Lê Thị Trân', 'KS', NULL, N'Nữ', '26/3/1974', '1/3/2005', 1.69, 760500, 'KHMT'),
	('GV09', N'Nguyễn Tô Lân', 'ThS', 'GV', N'Nữ', '31/12/1966', '1/3/2005', 4.00, 1800000, 'HTTT'),
	('GV10', N'Lê Trần Anh Loan', 'KS', NULL, N'Nữ', '17/7/1972', '1/3/2005', 1.86, 837000, 'CNPM'),
	('GV11', N'Hồ Thanh Tùng', 'CN', 'GV', N'Nam', '12/1/1980', '15/5/2005', 2.67, 1201500, 'MTT'),
	('GV12', N'Trần Văn Anh', 'CN', NULL, N'Nữ', '29/3/1981', '15/5/2005', 1.69, 760500, 'CNPM'),
	('GV13', N'Nguyễn Linh Đan', 'CN', NULL, N'Nữ', '23/5/1980', '15/5/2005', 1.69, 760500, 'KHMT'),
	('GV14', N'Trương Minh Châu', 'ThS', 'GV', N'Nữ', '30/11/1976', '15/5/2005', 3.00, 1350000, 'MTT'),
	('GV15', N'Lê Hà Thành', 'ThS', 'GV', N'Nam', '4/5/1978', '15/5/2005', 3.00, 1350000, 'KHMT');
INSERT INTO KETQUATHI (MAHV, MAMH, LANTHI, NGTHI, DIEM, KQUA)
VALUES
	('K1101','CSDL',1,'20/7/2006',10.00,N'Đạt'),
	('K1101','CTDLGT',1,'28/12/2006',9.00,N'Đạt'),
	('K1101','THDC',1,'20/5/2006',9.00,N'Đạt'),
	('K1101','CTRR',1,'13/5/2006',9.50,N'Đạt'),
	('K1102','CSDL',1,'20/7/2006',4.00,N'Không đạt'),
	('K1102','CSDL',2,'27/7/2006',4.25,N'Không đạt'),
	('K1102','CSDL',3,'10/8/2006',4.50,N'Không đạt'),
	('K1102','CTDLGT',1,'28/12/2006',4.50,N'Không đạt'),
	('K1102','CTDLGT',2,'5/1/2007',4.00,N'Không đạt'),
	('K1102','CTDLGT',3,'15/1/2007',6.00,N'Đạt'),
	('K1102','THDC',1,'20/5/2006',5.00,N'Đạt'),
	('K1102','CTRR',1,'13/5/2006',7.00,N'Đạt'),
	('K1103','CSDL',1,'20/7/2006',3.50,N'Không đạt'),
	('K1103','CSDL',2,'27/7/2006',8.25,N'Đạt'),
	('K1103','CTDLGT',1,'28/12/2006',7.00,N'Đạt'),
	('K1103','THDC',1,'20/5/2006',8.00,N'Đạt'),
	('K1103','CTRR',1,'13/5/2006',6.50,N'Đạt'),
	('K1104','CSDL',1,'20/7/2006',3.75,N'Không đạt'),
	('K1104','CTDLGT',1,'28/12/2006',4.00,N'Không đạt'),
	('K1104','THDC',1,'20/5/2006',4.00,N'Không đạt'),
	('K1104','CTRR',1,'13/5/2006',4.00,N'Không đạt'),
	('K1104','CTRR',2,'20/5/2006',3.50,N'Không đạt'),
	('K1104','CTRR',3,'30/6/2006',4.00,N'Không đạt'),
	('K1201','CSDL',1,'20/7/2006',6.00,N'Đạt'),
	('K1201','CTDLGT',1,'28/12/2006',5.00,N'Đạt'),
	('K1201','THDC',1,'20/5/2006',8.50,N'Đạt'),
	('K1201','CTRR',1,'13/5/2006',9.00,N'Đạt'),
	('K1202','CSDL',1,'20/7/2006',8.00,N'Đạt'),
	('K1202','CTDLGT',1,'28/12/2006',4.00,N'Không đạt'),
	('K1202','CTDLGT',2,'5/1/2007',5.00,N'Đạt'),
	('K1202','THDC',1,'20/5/2006',4.00,N'Không đạt'),
	('K1202','THDC',2,'27/5/2006',4.00,N'Không đạt'),
	('K1202','CTRR',1,'13/5/2006',3.00,N'Không đạt'),
	('K1202','CTRR',2,'20/5/2006',4.00,N'Không đạt'),
	('K1202','CTRR',3,'30/6/2006',6.25,N'Đạt'),
	('K1203','CSDL',1,'20/7/2006',9.25,N'Đạt'),
	('K1203','CTDLGT',1,'28/12/2006',9.50,N'Đạt'),
	('K1203','THDC',1,'20/5/2006',10.00,N'Đạt'),
	('K1203','CTRR',1,'13/5/2006',10.00,N'Đạt'),
	('K1204','CSDL',1,'20/7/2006',8.50,N'Đạt'),
	('K1204','CTDLGT',1,'28/12/2006',6.75,N'Đạt'),
	('K1204','THDC',1,'20/5/2006',4.00,N'Không đạt'),
	('K1204','CTRR',1,'13/5/2006',6.00,N'Đạt'),
	('K1301','CSDL',1,'20/12/2006',4.25,N'Không đạt'),
	('K1301','CTDLGT',1,'25/7/2006',8.00,N'Đạt'),
	('K1301','THDC',1,'20/5/2006',7.75,N'Đạt'),
	('K1301','CTRR',1,'13/5/2006',8.00,N'Đạt'),
	('K1302','CSDL',1,'20/12/2006',6.75,N'Đạt'),
	('K1302','CTDLGT',1,'25/7/2006',5.00,N'Đạt'),
	('K1302','THDC',1,'20/5/2006',8.00,N'Đạt'),
	('K1302','CTRR',1,'13/5/2006',8.50,N'Đạt'),
	('K1303','CSDL',1,'20/12/2006',4.00,N'Không đạt'),
	('K1303','CTDLGT',1,'25/7/2006',4.50,N'Không đạt'),
	('K1303','CTDLGT',2,'7/8/2006',4.00,N'Không đạt'),
	('K1303','CTDLGT',3,'15/8/2006',4.25,N'Không đạt'),
	('K1303','THDC',1,'20/5/2006',4.50,N'Không đạt'),
	('K1303','CTRR',1,'13/5/2006',3.25,N'Không đạt'),
	('K1303','CTRR',2,'20/5/2006',5.00,N'Đạt'),
	('K1304','CSDL',1,'20/12/2006',7.75,N'Đạt'),
	('K1304','CTDLGT',1,'25/7/2006',9.75,N'Đạt'),
	('K1304','THDC',1,'20/5/2006',5.50,N'Đạt'),
	('K1304','CTRR',1,'13/5/2006',5.00,N'Đạt'),
	('K1305','CSDL',1,'20/12/2006',9.25,N'Đạt'),
	('K1305','CTDLGT',1,'25/7/2006',10.00,N'Đạt'),
	('K1305','THDC',1,'20/5/2006',8.00,N'Đạt'),
	('K1305','CTRR',1,'13/5/2006',10.00,N'Đạt');
INSERT INTO HOCVIEN (MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP)
VALUES
	('K1101',N'Nguyễn Văn',N'A','27/1/1986',N'Nam',N'TPHCM','K11'),
	('K1102',N'Trần Ngọc',N'Hân','1/3/1986',N'Nữ',N'Kiên Giang','K11'),
	('K1103',N'Hà Duy',N'Lập','18/4/1986',N'Nam',N'Nghệ An','K11'),
	('K1104',N'Trần Ngọc',N'Linh','30/3/1986',N'Nữ',N'Tây Ninh','K11'),
	('K1105',N'Trần Minh',N'Long','27/2/1986',N'Nam',N'TPHCM','K11'),
	('K1106',N'Lê Nhật',N'Minh','24/1/1986',N'Nam',N'TPHCM','K11'),
	('K1107',N'Nguyễn Như',N'Nhựt','27/1/1986',N'Nam',N'Hà Nội','K11'),
	('K1108',N'Nguyễn Mạnh',N'Tam','27/2/1986',N'Nam',N'Kiên Giang','K11'),
	('K1109',N'Phan Thị Thanh',N'Tâm','27/1/1986',N'Nữ',N'Vĩnh Long','K11'),
	('K1110',N'Lê Hoài',N'Thương','5/2/1986',N'Nữ',N'Cần Thơ','K11'),
	('K1111',N'Lê Hà',N'Vinh','25/12/1986',N'Nam',N'Vĩnh Long','K11'),
	('K1201',N'Nguyễn Văn',N'B','11/2/1986',N'Nam',N'TPHCM','K12'),
	('K1202',N'Nguyễn Thị Kim',N'Duyên','18/1/1986',N'Nữ',N'TPHCM','K12'),
	('K1203',N'Trần Thị Kim',N'Duyên','17/9/1986',N'Nữ',N'TPHCM','K12'),
	('K1204',N'Trương Mỹ',N'Hạnh','19/5/1986',N'Nữ',N'Đồng Nai','K12'),
	('K1205',N'Nguyễn Thành',N'Nam','17/4/1986',N'Nam',N'TPHCM','K12'),
	('K1206',N'Nguyễn Thị Trúc',N'Thanh','4/3/1986',N'Nữ',N'Kiên Giang','K12'),
	('K1207',N'Trần Thị Bích',N'Thuy','8/2/1986',N'Nữ',N'Nghệ An','K12'),
	('K1208',N'Huỳnh Thị Kim',N'Triệu','8/4/1986',N'Nữ',N'Tây Ninh','K12'),
	('K1209',N'Pham Thanh',N'Triệu','23/2/1986',N'Nam',N'TPHCM','K12'),
	('K1210',N'Ngô Thanh',N'Tuân','14/2/1986',N'Nam',N'TPHCM','K12'),
	('K1211',N'Đỗ Thị',N'Xuân','9/3/1986',N'Nữ',N'Hà Nội','K12'),
	('K1212',N'Lê Thị Phi',N'Yên','12/3/1986',N'Nữ',N'TPHCM','K12'),
	('K1301',N'Nguyễn Thị Kim',N'Cúc','9/6/1986',N'Nữ',N'Kiên Giang','K13'),
	('K1302',N'Trương Thị Mỹ',N'Hiền','18/3/1986',N'Nữ',N'Nghệ An','K13'),
	('K1303',N'Lê Đức',N'Hiển','12/3/1986',N'Nam',N'Tây Ninh','K13'),
	('K1304',N'Lê Quang',N'Hiển','18/4/1986',N'Nam',N'TPHCM','K13'),
	('K1305',N'Lê Thị',N'Hương','27/3/1986',N'Nữ',N'TPHCM','K13'),
	('K1306',N'Nguyễn Thái',N'Hữu','30/3/1986',N'Nam',N'Hà Nội','K13'),
	('K1307',N'Trần Minh',N'Mẫnn','28/5/1986',N'Nam',N'TPHCM','K13'),
	('K1308',N'Nguyễn Hiếu',N'Nghĩa','8/4/1986',N'Nam',N'Kiên Giang','K13'),
	('K1309',N'Nguyễn Trung',N'Nghĩa','18/1/1987',N'Nam',N'Nghệ An','K13'),
	('K1310',N'Trần Thị Hồng',N'Thắm','22/4/1986',N'Nữ',N'Tây Ninh','K13'),
	('K1311',N'Trần Minh',N'Thúc','4/4/1986',N'Nam',N'TPHCM','K13'),
	('K1312',N'Nguyễn Thị Kim',N'Yến','7/9/1986',N'Nữ',N'TPHCM','K13');

-- Thêm khóa ngoại
ALTER TABLE KHOA
ADD CONSTRAINT FK_TRGKHOAaK FOREIGN KEY(TRGKHOA) REFERENCES GIAOVIEN(MAGV);
ALTER TABLE HOCVIEN
ADD CONSTRAINT FK_MALOPHV FOREIGN KEY(MALOP) REFERENCES LOP(MALOP);
ALTER TABLE MONHOC
ADD CONSTRAINT FK_MAKHOAMH FOREIGN KEY(MAKHOA) REFERENCES KHOA(MAKHOA);
ALTER TABLE GIAOVIEN
ADD CONSTRAINT FK_MAKHOAGV FOREIGN KEY(MAKHOA) REFERENCES KHOA(MAKHOA);
ALTER TABLE DIEUKIEN
ADD 
	CONSTRAINT FK_MAMHDK FOREIGN KEY(MAMH) REFERENCES MONHOC(MAMH),
	CONSTRAINT FK_MAMH_TRUOCDK FOREIGN KEY(MAMH_TRUOC) REFERENCES MONHOC(MAMH);
ALTER TABLE LOP
ADD 
	CONSTRAINT FK_TRGLOPL FOREIGN KEY(TRGLOP) REFERENCES HOCVIEN(MAHV),
	CONSTRAINT FK_MAGVCNL FOREIGN KEY(MAGVCN) REFERENCES GIAOVIEN(MAGV);
ALTER TABLE GIANGDAY
ADD 
	CONSTRAINT FK_MALOPGD FOREIGN KEY(MALOP) REFERENCES LOP(MALOP),
	CONSTRAINT FK_MAMHGD FOREIGN KEY(MAMH) REFERENCES MONHOC(MAMH),
	CONSTRAINT FK_MAGVGD FOREIGN KEY(MAGV) REFERENCES GIAOVIEN(MAGV);
ALTER TABLE KETQUATHI
ADD 
	CONSTRAINT FK_MAHVKQT FOREIGN KEY(MAHV) REFERENCES HOCVIEN(MAHV),
	CONSTRAINT FK_MAMHKQT FOREIGN KEY(MAMH) REFERENCES MONHOC(MAMH);

-- Thêm thuộc tính GHICHU, XEPLOAI và DIEMTB cho quan hệ HOCVIEN
ALTER TABLE HOCVIEN
ADD
	GHICHU nvarchar(40),
	XEPLOAI nvarchar(10),
	DIEMTB numeric(4,2);

/*
	I. 2. Mã học viên là một chuỗi 5 ký tự, 3 ký tự đầu là mã lớp,
	2 ký tự cuối cùng là số thứ tự học viên trong lớp. VD: “K1101”.
*/
ALTER TABLE HOCVIEN
ADD CONSTRAINT CHK_MAHVHV CHECK (MAHV LIKE '___[0-9][0-9]' AND SUBSTRING(MAHV, 1, 3) = MALOP);

/*
	I. 3. Thuộc tính GIOITINH chỉ có giá trị là “Nam” hoặc “Nu”.
*/
ALTER TABLE HOCVIEN
ADD CONSTRAINT CHK_GIOITINHHV
CHECK (GIOITINH = N'Nam' OR GIOITINH = N'Nữ')
ALTER TABLE GIAOVIEN
ADD CONSTRAINT CHK_GIOITINHGV
CHECK (GIOITINH = N'Nam' OR GIOITINH = N'Nữ')

/*
	I. 4. Điểm số của một lần thi có giá trị từ 0 đến 10 và cần lưu đến 2 số lẽ (VD: 6.22).
*/
-- Điểm số đã lưu 2 số lẽ vì kiểu dữ liệu là numeric(4,2)
ALTER TABLE KETQUATHI
ADD CONSTRAINT CHK_DIEMKQT
CHECK (DIEM >= 0 AND DIEM <= 10)


---------------------------------------------------------------------------------------------------------------------------------
/*
	THỰC HÀNH 2
	- Phần II Câu 1 đến 4
	- Phần III Câu 1 đến 4
*/
/*
	II. 1. Tăng hệ số lương thêm 0.2 cho những giáo viên là trưởng khoa
*/
UPDATE GIAOVIEN
SET HESO = 0.2 + HESO
WHERE MAGV IN (SELECT TRGKHOA FROM KHOA);

/*
	II. 2. Cập nhật giá trị điểm trung bình tất cả các môn học (DIEMTB) của mỗi học viên
	(tất cả các môn học đều có hệ số 1 và nếu học viên thi một môn nhiều lần, chỉ lấy điểm của lần thi sau cùng)
*/
UPDATE HOCVIEN
SET DIEMTB =
	(SELECT AVG(DIEM)
	FROM KETQUATHI kqt
	WHERE LANTHI = 
		(SELECT MAX(LANTHI) 
		FROM KETQUATHI 
		WHERE MAHV = kqt.MAHV 
		GROUP BY MAHV)
	GROUP BY MAHV
	HAVING MAHV = HOCVIEN.MAHV)

/*
	II. 3. Cập nhật giá trị cho cột GHICHU là “Cam thi” đối
	với trường hợp: học viên có một môn bất kỳ thi lần thứ 3 dưới 5 điểm
*/
UPDATE HOCVIEN
SET GHICHU = N'Cấm thi'
WHERE MAHV IN 
	(SELECT MAHV
	FROM KETQUATHI
	WHERE LANTHI = 3 AND DIEM < 5)

/*
	II. 4. Cập nhật giá trị cho cột XEPLOAI trong quan hệ HOCVIEN như sau: 
	Nếu DIEMTB >= 9 thì XEPLOAI = ”XS”
	Nếu 8 <= DIEMTB < 9 thì XEPLOAI = “G”
	Nếu 6.5 <= DIEMTB < 8 thì XEPLOAI = “K”
	Nếu 5 <= DIEMTB < 6.5 thì XEPLOAI = “TB” 
	Nếu DIEMTB < 5 thì XEPLOAI = ”Y” 
*/
UPDATE HOCVIEN
SET XEPLOAI =
	(CASE 
		WHEN DIEMTB >= 9 THEN 'XS'
		WHEN DIEMTB >= 8 AND DIEMTB < 9 THEN 'G'
		WHEN DIEMTB >= 6.5 AND DIEMTB < 8 THEN 'K'
		WHEN DIEMTB >= 5 AND DIEMTB < 6.5 THEN 'TB'
		WHEN DIEMTB < 5 THEN 'Y'
	END)

/*
	III. 1. In ra danh sách (mã học viên, họ tên, ngày sinh, mã lớp) lớp trưởng của các lớp
*/
SELECT MAHV, (HO+' '+TEN) HOTEN, NGSINH, hv.MALOP
FROM HOCVIEN hv JOIN LOP l on hv.MAHV = l.TRGLOP

-- III.2 In ra bảng điểm khi thi (mã học viên, họ tên , lần thi, điểm số) môn CTRR của lớp “K12”, sắp xếp theo tên, họ học viên
SELECT 
	HOCVIEN.MAHV, (HO+' '+TEN) HOTEN, LANTHI, DIEM 
FROM 
	KETQUATHI, HOCVIEN
WHERE
	KETQUATHI.MAHV = HOCVIEN.MAHV
	AND MAMH = 'CTRR'
	AND MALOP = 'K12'
ORDER BY
	TEN, HO

-- III.3 In ra danh sách những học viên (mã học viên, họ tên) và những môn học mà học viên đó thi lần thứ nhất đã đạt
SELECT
	HOCVIEN.MAHV, (HO+' '+TEN) HOTEN, TenMH
FROM
	KETQUATHI, MONHOC, HOCVIEN
WHERE
	KETQUATHI.MAMH = MONHOC.MAMH
	AND KETQUATHI.MAHV = HOCVIEN.MAHV
	AND LANTHI = 1 AND KQua = 'Dat'

-- III.4 In ra danh sách học viên (mã học viên, họ tên) của lớp “K11” thi môn CTRR không đạt (ở lần thi 1)
SELECT
	HOCVIEN.MAHV, (HO+' '+TEN) HOTEN
FROM
	HOCVIEN, KETQUATHI
WHERE
	HOCVIEN.MAHV = KETQUATHI.MAHV
	AND MALOP = 'K11'
	AND MAMH = 'CTRR'
	AND KQua = 'Khong Dat'
	AND LANTHI = 1


--------------------------------------------------------------------------------------------------------------------------------
/*
	THỰC HÀNH 3
	- Phần III Câu 5 đến 18.
*/
/*
	III. 5. * Danh sách học viên (mã học viên, họ tên) của 
	lớp “K” thi môn CTRR không đạt (ở tất cả các lần thi).
*/
SELECT DISTINCT HV.MAHV, (HO + ' ' + TEN) HOTEN
FROM HOCVIEN HV
	JOIN KETQUATHI KQT ON KQT.MAHV = HV.MAHV
WHERE SUBSTRING(HV.MAHV,1,1)='K' AND HV.MAHV NOT IN
	(SELECT	MAHV
	FROM KETQUATHI
	WHERE MAMH = 'CTRR' AND KQUA = N'Đạt');

/*
	III. 6. Tìm tên những môn học mà giáo viên có tên 
	“Tran Tam Thanh” dạy trong học kỳ 1 năm 2006.
*/
SELECT DISTINCT TENMH
FROM MONHOC mh 
	JOIN GIANGDAY gd ON mh.MAMH = gd.MAMH 
	JOIN GIAOVIEN gv ON gd.MAGV = gv.MAGV
WHERE gv.HOTEN = N'Trần Tâm Thành' AND gd.HOCKY = 1 AND gd.NAM = 2006;

/*
	III. 7. Tìm những môn học (mã môn học, tên môn học) mà
	giáo viên chủ nhiệm lớp “K11” dạy trong học kỳ 1 năm 2006.
*/
SELECT DISTINCT mh.MAMH, TENMH
FROM MONHOC mh 
	JOIN GIANGDAY gd ON mh.MAMH = gd.MAMH 
	JOIN LOP l ON l.MAGVCN = gd.MAGV
WHERE l.MALOP = 'K11' AND gd.HOCKY = 1 AND gd.NAM = 2006;

/*
	III. 8. Tìm họ tên lớp trưởng của các lớp mà giáo viên có tên “Nguyen To Lan”
	dạy môn “Co So Du Lieu”.
*/
SELECT (HO + ' ' + TEN) HOTEN
FROM HOCVIEN HV
	JOIN LOP L ON L.TRGLOP = HV.MAHV
	JOIN GIAOVIEN GV ON GV.MAGV = L.MAGVCN
	JOIN GIANGDAY GD ON GD.MAGV = GV.MAGV
	JOIN MONHOC MH ON MH.MAMH = GD.MAMH
WHERE GV.HOTEN = N'Nguyễn Tô Lân' AND MH.TENMH = N'Cơ sở dữ liệu';


/*
	III. 9. In ra danh sách những môn học (mã môn học, tên môn học)
	phải học liền trước môn “Co So Du Lieu”.
*/
SELECT MHTRC.MAMH, MHTRC.TENMH
FROM MONHOC	MHTRC
	JOIN DIEUKIEN DK ON DK.MAMH_TRUOC = MHTRC.MAMH
	JOIN MONHOC MH ON MH.MAMH = DK.MAMH
WHERE MH.TENMH = N'Cơ sở dữ liệu';

/*
	III. 10. Môn “Cau Truc Roi Rac” là môn bắt buộc phải học liền trước
	những môn học (mã môn học, tên môn học) nào.
*/
SELECT MH.MAMH, MH.TENMH
FROM MONHOC MH
	JOIN DIEUKIEN DK ON DK.MAMH = MH.MAMH
	JOIN MONHOC MHTRC ON MHTRC.MAMH = DK.MAMH_TRUOC
WHERE MHTRC.TENMH = N'Cấu trúc rời rạc';

/*
	III. 11. Tìm họ tên giáo viên dạy môn CTRR cho cả
	hai lớp “K11” và “K12” trong cùng học kỳ 1 năm 2006.
*/
SELECT GV.HOTEN
FROM GIAOVIEN GV
	JOIN GIANGDAY GD ON GD.MAGV = GV.MAGV
	JOIN MONHOC MH ON MH.MAMH = GD.MAMH
	JOIN LOP L ON L.MALOP = GD.MALOP
WHERE MH.MAMH = 'CTRR' AND L.MALOP = 'K11'AND GD.HOCKY = 1 AND GD.NAM = 2006
	AND GV.MAGV IN (
		SELECT GV2.MAGV
		FROM GIAOVIEN GV2
			JOIN GIANGDAY GD ON GD.MAGV = GV2.MAGV
			JOIN MONHOC MH ON MH.MAMH = GD.MAMH
			JOIN LOP L ON L.MALOP = GD.MALOP
		WHERE MH.MAMH = 'CTRR' AND L.MALOP = 'K12'AND GD.HOCKY = 1 AND GD.NAM = 2006
		)

/*
	III. 12. Tìm những học viên (mã học viên, họ tên)
	thi không đạt môn CSDL ở lần thi thứ 1 nhưng chưa thi lại môn này.
*/
SELECT HV.MAHV, (HV.HO + ' ' + HV.TEN) HOTEN
FROM HOCVIEN HV
	JOIN KETQUATHI KQT ON KQT.MAHV = HV.MAHV
WHERE KQT.MAMH = 'CSDL' AND KQT.LANTHI = 1 AND KQT.KQUA = N'Không đạt'
	AND HV.MAHV NOT IN (
			SELECT HV2.MAHV
			FROM HOCVIEN HV2
				JOIN KETQUATHI KQT2 ON KQT2.MAHV = HV2.MAHV
			WHERE KQT2.MAMH = 'CSDL' AND KQT2.LANTHI = 2
		)
;

/*
	III. 13. Tìm giáo viên (mã giáo viên, họ tên)
	không được phân công giảng dạy bất kỳ môn học nào.
*/
SELECT MAGV, HOTEN
FROM GIAOVIEN GV
WHERE MAGV NOT IN (SELECT MAGV FROM GIANGDAY);

/*
	III. 14. Tìm giáo viên (mã giáo viên, họ tên)không được phân
	công giảng dạy bất kỳ môn học nào thuộc khoa giáo viên đó phụ trách.
*/
SELECT MAGV, HOTEN
FROM GIAOVIEN
EXCEPT
	SELECT GV.MAGV, HOTEN
	FROM GIAOVIEN GV
		JOIN GIANGDAY GD ON GD.MAGV = GV.MAGV
		JOIN MONHOC MH ON MH.MAMH = GD.MAMH
	WHERE GV.MAKHOA = MH.MAKHOA
;

/*
	III. 15. Tìm họ tên các học viên thuộc lớp “K11” thi một môn
	bất kỳ quá 3 lần vẫn “Khong dat” hoặc thi lần thứ 2 môn CTRR được 5 điểm.
*/
SELECT (HO + ' ' + TEN) HOTEN
FROM HOCVIEN HV
	JOIN KETQUATHI KQT ON KQT.MAHV = HV.MAHV
WHERE HV.MALOP = 'K11' AND ( (KQT.LANTHI = 2 AND KQT.MAMH = 'CTRR' AND KQT.DIEM = 5)
	OR (KQT.LANTHI > 3
		AND KQT.KQUA = N'Không đạt'
		AND KQT.LANTHI >= ALL (
			SELECT LANTHI
			FROM KETQUATHI
			WHERE MAHV = HV.MAHV
			)
	)
);

/*
	III. 16. Tìm họ tên giáo viên dạy môn CTRR cho ít nhất
	hai lớp trong cùng một học kỳ của một năm học.
*/
SELECT HOTEN
FROM GIAOVIEN GV
	JOIN GIANGDAY GD ON GD.MAGV = GV.MAGV
WHERE GD.MAMH = 'CTRR'
GROUP BY HOTEN, HOCKY, GV.MAGV
HAVING COUNT(GD.MALOP) >= 2;

/*
	III. 17. Danh sách học viên và điểm thi
	môn CSDL (chỉ lấy điểm của lần thi sau cùng).
*/
SELECT HV.*, KQT.DIEM
FROM HOCVIEN HV
	JOIN KETQUATHI KQT ON KQT.MAHV = HV.MAHV
WHERE KQT.MAMH = 'CSDL'
	AND KQT.LANTHI >= ALL (
			SELECT LANTHI
			FROM KETQUATHI
			WHERE MAMH = 'CSDL' AND MAHV = HV.MAHV
			);

/*
	III. 18. Danh sách học viên và điểm thi môn
	“Co So Du Lieu” (chỉ lấy điểm cao nhất của các lần thi).
*/
SELECT HV.*, KQT.DIEM
FROM HOCVIEN HV
	JOIN KETQUATHI KQT ON KQT.MAHV = HV.MAHV
	JOIN MONHOC MH ON MH.MAMH = KQT.MAMH
WHERE MH.TENMH = N'Cơ sở dữ liệu'
	AND KQT.DIEM >= ALL (
			SELECT KQT2.DIEM
			FROM KETQUATHI KQT2
				JOIN MONHOC MH2 ON MH2.MAMH = KQT2.MAMH
			WHERE MH.TENMH = N'Cơ sở dữ liệu' AND MAHV = HV.MAHV
			);

--------------------------------------------------------------------------------------------------------------------------------
/*
	THỰC HÀNH 4
	- Phần III Câu 19 đến 35.
*/
/*
	III. 19. Khoa nào (mã khoa, tên khoa) được thành lập sớm nhất.
	Bảng KHOA
	Dễ
*/
-- Cách 1
SELECT MAKHOA, TENKHOA
FROM KHOA
WHERE NGTLAP <= ALL (
	SELECT NGTLAP
	FROM KHOA
	);
-- Cách 2
SELECT MAKHOA, TENKHOA
FROM KHOA, (SELECT MIN(NGTLAP) NTL1 FROM KHOA) M
WHERE NGTLAP = NTL1
-- Cách 3
SELECT TOP 1 WITH TIES MAKHOA, TENKHOA
FROM KHOA
ORDER BY NGTLAP ASC

/*
	III. 20. Có bao nhiêu giáo viên có học hàm là “GS” hoặc “PGS”.
	BẢNG GIAOVIEN
	DỄ
*/
SELECT COUNT(MAGV) SOGV
FROM GIAOVIEN
WHERE HOCHAM = 'GS' OR HOCHAM = 'PGS'
GROUP BY HOCHAM

/*
	III. 21. Thống kê có bao nhiêu giáo viên có học vị
	là “CN”, “KS”, “Ths”, “TS”, “PTS” trong mỗi khoa.
*/
SELECT MAKHOA, HOCVI, COUNT(MAGV) SOGV
FROM GIAOVIEN
WHERE HOCVI = 'CN' OR HOCVI = 'KS' OR HOCVI = 'Ths' OR HOCVI = 'TS' OR HOCVI = 'PTS'
GROUP BY MAKHOA, HOCVI
ORDER BY MAKHOA ASC;

-- CẬP NHẬT TS THÀNH TSKH, PTS THÀNH TS
SELECT TOP 5 *
FROM GIAOVIEN;
UPDATE GIAOVIEN
SET HOCVI = 'TSKH'
WHERE HOCVI = 'TS';
UPDATE GIAOVIEN
SET HOCVI = 'TS'
WHERE HOCVI = 'PTS';
SELECT TOP 5 *
FROM GIAOVIEN;

/*
	III. 22. Mỗi môn học thống kê số lượng học viên theo kết quả (đạt và không đạt).
	BẢNG: GIANGDAY, MONHOC
	ĐÁNH GIÁ: TRUNG BÌNH
*/
SELECT KQT.MAMH, TENMH, KQUA, COUNT(DISTINCT MAHV) SLHV
FROM KETQUATHI KQT JOIN MONHOC MH ON MH.MAMH = KQT.MAMH
WHERE KQT.KQUA IN (N'Đạt', N'Không đạt')
GROUP BY KQT.MAMH, TENMH, KQUA
ORDER BY KQT.MAMH;

-- III. 23. Tìm giáo viên (mã giáo viên, họ tên) là giáo viên chủ nhiệm của một lớp,
-- đồng thời dạy cho lớp đó ít nhất một môn học.-- BẢNG: GIAOVIEN, LOP, GIANGDAY
-- ĐÁNH GIÁ: DỄ
-- CÁCH 1
SELECT DISTINCT GV.MAGV, GV.HOTEN
FROM GIAOVIEN GV
	JOIN LOP L ON L.MAGVCN = GV.MAGV
	JOIN GIANGDAY GD ON GD.MAGV = GV.MAGV
WHERE GD.MALOP = L.MALOP 
-- CÁCH 2
SELECT DISTINCT GV.MAGV, GV.HOTEN
FROM GIAOVIEN GV
WHERE GV.MAGV IN (
	SELECT L.MAGVCN
	FROM LOP L
	WHERE L.MALOP IN (
		SELECT GD.MALOP
		FROM GIANGDAY GD
		WHERE GD.MAGV = GV.MAGV
		)
	);


-- III. 24. Tìm họ tên lớp trưởng của lớp có sỉ số cao nhất.
-- BẢNG: LOP, HOCVIEN
-- DỄ
SELECT (HO + ' ' + TEN) HOTEN
FROM LOP L JOIN HOCVIEN HV ON HV.MAHV = L.TRGLOP,
	(SELECT MAX(SISO) MAXSISO FROM LOP) MSS
WHERE SISO = MAXSISO;

-- III. 25. * Tìm họ tên những LOPTRG thi không đạt
-- quá 3 môn (mỗi môn đều thi không đạt ở tất cả các lần thi).
-- BẢNG: HOCVIEN, KETQUATHI, LOP
-- TRUNG BÌNH
-- không đạt quá 3 môn là KHÔNG đạt quá 3 môn
SELECT (HO + ' ' + TEN) HOTEN
FROM HOCVIEN HV, LOP L
WHERE HV.MAHV = L.TRGLOP AND NOT EXISTS (
	SELECT *
	FROM KETQUATHI KQT
	WHERE KQUA = N'Đạt' AND KQT.MAHV = HV.MAHV
	HAVING COUNT(DISTINCT MAMH) > 3
	);

-- SỬA LẠI TÌM HẾT CÁC HỌC VIÊN
SELECT (HO + ' ' + TEN) HOTEN
FROM HOCVIEN HV
WHERE NOT EXISTS (
	SELECT *
	FROM KETQUATHI KQT
	WHERE KQUA = N'Đạt' AND KQT.MAHV = HV.MAHV
	HAVING COUNT(DISTINCT MAMH) > 3
	);

-- III. 26. Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
-- BẢNG: HOCVIEN, KETQUATHI
-- DỄ
SELECT HV.MAHV, CONCAT(HO,' ',TEN) HOTEN
FROM HOCVIEN HV JOIN KETQUATHI KQT ON KQT.MAHV = HV.MAHV
WHERE DIEM IN (9, 10)
GROUP BY HV.MAHV, HO, TEN
HAVING COUNT(DISTINCT MAMH) >= ALL (
	SELECT COUNT(DISTINCT MAMH)
	FROM KETQUATHI
	WHERE DIEM IN (9, 10)
	GROUP BY MAHV
	);

-- III. 27. Trong từng lớp, tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
-- BẢNG: HOCVIEN, KETQUATHI, LOP
-- ĐÁNH GIÁ: TRÊN DỄ
SELECT HV.MAHV, CONCAT(HO,' ',TEN) HOTEN
FROM HOCVIEN HV
	JOIN KETQUATHI KQT ON KQT.MAHV = HV.MAHV
	JOIN LOP L ON L.MALOP = HV.MALOP
WHERE DIEM IN (9, 10)
GROUP BY HV.MALOP, HV.MAHV, HO, TEN
HAVING COUNT(DISTINCT KQT.MAMH) >= ALL (
	SELECT COUNT(DISTINCT KQT2.MAMH)
	FROM HOCVIEN HV2
		JOIN KETQUATHI KQT2 ON KQT2.MAHV = HV2.MAHV
		JOIN LOP L2 ON L2.MALOP = HV2.MALOP
	WHERE DIEM IN (9, 10) AND L2.MALOP = HV.MALOP
	GROUP BY HV2.MALOP, HV2.MAHV
	);

-- III. 28. Trong từng học kỳ của từng năm, mỗi giáo viên
-- phân công dạy bao nhiêu môn học, bao nhiêu lớp.-- BẢNG: GIANGDAY, GIAOVIEN-- ĐÁNH GIÁ: DỄSELECT GD.NAM, GD.HOCKY, GV.MAGV, GV.HOTEN, COUNT(DISTINCT GD.MALOP) SOLOP, COUNT(DISTINCT GD.MAMH) SOMONFROM GIANGDAY GD JOIN GIAOVIEN GV ON GV.MAGV = GD.MAGVGROUP BY GD.NAM, GD.HOCKY, GV.MAGV, GV.HOTEN-- III. 29. Trong từng học kỳ của từng năm, tìm giáo viên-- (mã giáo viên, họ tên) giảng dạy nhiều nhất.-- BẢNG: GIANGDAY, GIAOVIEN-- ĐÁNH GIÁ: DỄSELECT GD.NAM, GD.HOCKY, GV.MAGV, GV.HOTENFROM GIANGDAY GD JOIN GIAOVIEN GV ON GV.MAGV = GD.MAGVGROUP BY GD.NAM, GD.HOCKY, GV.MAGV, GV.HOTENHAVING COUNT(GD.MALOP) >= ALL (	SELECT COUNT(GD2.MALOP)	FROM GIANGDAY GD2	WHERE GD2.NAM = GD.NAM AND GD2.HOCKY = GD.HOCKY	GROUP BY GD2.NAM, GD2.HOCKY, GD2.MAGV	);-- III. 30. Tìm môn học (mã môn học, tên môn học) có 
-- nhiều học viên thi không đạt (ở lần thi thứ 1) nhất.
-- BẢNG: KETQUATHI, MONHOC
-- ĐÁNH GIÁ: TRÊN DỄ
SELECT MH.MAMH, MH.TENMH
FROM MONHOC MH, (
	SELECT TOP 1 KQT.MAMH
	FROM KETQUATHI KQT
	WHERE KQT.LANTHI = 1 AND KQT.KQUA = N'Không đạt'
	GROUP BY KQT.MAHV, KQT.MAMH
	ORDER BY COUNT(KQT.MAHV) DESC
) TEMP
WHERE MH.MAMH = TEMP.MAMH;

-- III. 31. Tìm học viên (mã học viên, họ tên) -- thi môn nào cũng đạt (chỉ xét lần thi thứ 1).-- BẢNG: HOCVIEN, KETQUATHI-- ĐÁNH GIÁ: DỄSELECT DISTINCT HV.MAHV, CONCAT(HV.HO, ' ', HV.TEN) HOTENFROM HOCVIEN HV JOIN KETQUATHI KQT ON KQT.MAHV = HV.MAHVWHERE KQT.LANTHI = 1 AND NOT EXISTS (	SELECT *	FROM KETQUATHI KQT2	WHERE HV.MAHV = KQT2.MAHV AND KQT2.LANTHI = 1 AND KQT2.KQUA = N'Không đạt');-- III. 32. * Tìm học viên (mã học viên, họ tên) -- thi môn nào cũng đạt (chỉ xét lần thi sau cùng).-- BẢNG: HOCVIEN, KETQUATHI-- ĐÁNH GIÁ: TRÊN DỄSELECT DISTINCT HV.MAHV, CONCAT(HV.HO, ' ', HV.TEN) HOTENFROM HOCVIEN HV JOIN KETQUATHI KQT ON KQT.MAHV = HV.MAHVWHERE KQT.LANTHI = ( 	SELECT MAX(KQT2.LANTHI)	FROM KETQUATHI KQT2	WHERE HV.MAHV = KQT2.MAHV	GROUP BY KQT2.MAHV)AND NOT EXISTS (	SELECT *	FROM KETQUATHI KQT2	WHERE HV.MAHV = KQT2.MAHV AND KQT2.LANTHI = KQT.LANTHI AND KQT2.KQUA = N'Không đạt');-- 33. * Tìm học viên (mã học viên, họ tên) đã thi -- tất cả các môn đều đạt (chỉ xét lần thi thứ 1).-- BẢNG: MONHOC, HOCVIEN, KETQUATHI-- ĐÁNH GIÁ: KHÔNG HIỂU ĐỀSELECT DISTINCT HV.MAHV, CONCAT(HV.HO, ' ', HV.TEN) HOTENFROM HOCVIEN HV JOIN KETQUATHI KQT ON KQT.MAHV = HV.MAHVWHERE KQT.LANTHI = 1 AND NOT EXISTS (	SELECT *	FROM KETQUATHI KQT2	WHERE HV.MAHV = KQT2.MAHV AND KQT2.LANTHI = 1 AND KQT2.KQUA = N'Không đạt')GROUP BY HV.MAHV, HV.HO, HV.TENHAVING COUNT(DISTINCT KQT.MAMH) = 4(SELECT COUNT(MAMH) FROM MONHOC)-- 34. * Tìm học viên (mã học viên, họ tên) đã thi -- tất cả các môn đều đạt (chỉ xét lần thi thứ sau cùng).-- BẢNG: MONHOC, HOCVIEN, KETQUATHI-- ĐÁNH GIÁ: KHÔNG HIỂU ĐỀSELECT DISTINCT HV.MAHV, CONCAT(HV.HO, ' ', HV.TEN) HOTENFROM HOCVIEN HV JOIN KETQUATHI KQT ON KQT.MAHV = HV.MAHVWHERE KQT.LANTHI = ( 	SELECT MAX(KQT2.LANTHI)	FROM KETQUATHI KQT2	WHERE HV.MAHV = KQT2.MAHV	GROUP BY KQT2.MAHV)AND NOT EXISTS (	SELECT *	FROM KETQUATHI KQT2	WHERE HV.MAHV = KQT2.MAHV AND KQT2.LANTHI = KQT.LANTHI AND KQT2.KQUA = N'Không đạt')GROUP BY HV.MAHV, HV.HO, HV.TENHAVING COUNT(DISTINCT KQT.MAMH) = (SELECT COUNT(MAMH) FROM MONHOC)-- III. 35. ** Tìm học viên (mã học viên, họ tên) có điểm thi 
-- cao nhất trong từng môn (lấy điểm ở lầN thi sau cùng).
-- BẢNG: HOCVIEN, KETQUATHI
-- ĐÁNH GIÁ: TRUNG BÌNH
SELECT DISTINCT HV.MAHV, CONCAT(HV.HO, ' ', HV.TEN) HOTEN
FROM HOCVIEN HV JOIN KETQUATHI KQT ON KQT.MAHV = HV.MAHV
WHERE KQT.LANTHI = ( 	SELECT MAX(KQT2.LANTHI)	FROM KETQUATHI KQT2	WHERE HV.MAHV = KQT2.MAHV	GROUP BY KQT2.MAHV)GROUP BY HV.MAHV, HV.HO, HV.TEN, KQT.MAMH, KQT.DIEMHAVING KQT.DIEM = MAX(KQT.DIEM)/* LÀM THÊM */-- Thống kê sinh viên đạt, không đạt theo từng lớp-- BẢNG: KETQUATHI, HOCVIEN-- ĐÁNH GIÁ: TRUNG BÌNHSELECT DAT.MALOP, SOSVDAT, KODAT.SOSVKODATFROM	(SELECT HV.MALOP, COUNT(DISTINCT HV.MAHV) SOSVKODAT	FROM KETQUATHI KQT JOIN HOCVIEN HV ON HV.MAHV = KQT.MAHV	WHERE KQT.KQUA = N'Không đạt'	GROUP BY HV.MALOP) KODAT	FULL OUTER JOIN 	(SELECT HV.MALOP, COUNT(DISTINCT HV.MAHV) SOSVDAT	FROM KETQUATHI KQT JOIN HOCVIEN HV ON HV.MAHV = KQT.MAHV	WHERE KQT.KQUA = N'Đạt'	GROUP BY HV.MALOP) DAT	ON DAT.MALOP = KODAT.MALOP-- Mỗi môn học (tên môn), thống kê sinh viên đạt, không đạt theo từng lớpSELECT D.TENMH, D.MALOP, KD.SOSVKODAT, D.SOSVDATFROM	(SELECT MH.TENMH, HV.MALOP, COUNT(DISTINCT HV.MAHV) SOSVDAT	FROM KETQUATHI KQT		JOIN HOCVIEN HV ON HV.MAHV = KQT.MAHV		JOIN MONHOC MH ON MH.MAMH = KQT.MAMH	WHERE KQT.KQUA = N'Đạt'	GROUP BY HV.MALOP, MH.MAMH, MH.TENMH) D	FULL OUTER JOIN	(SELECT MH.TENMH, HV.MALOP, COUNT(DISTINCT HV.MAHV) SOSVKODAT	FROM KETQUATHI KQT		JOIN HOCVIEN HV ON HV.MAHV = KQT.MAHV		JOIN MONHOC MH ON MH.MAMH = KQT.MAMH	WHERE KQT.KQUA = N'Không đạt'	GROUP BY HV.MALOP, MH.MAMH, MH.TENMH) KD	ON KD.MALOP = D.MALOP AND KD.TENMH = D.TENMHORDER BY D.MALOP ASC