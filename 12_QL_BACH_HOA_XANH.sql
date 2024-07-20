-- NHÓM 12 QUẢN LÝ CỬA HÀNG BÁCH HÓA XANH
CREATE DATABASE QL_BACH_HOA_XANH12
GO

USE QL_BACH_HOA_XANH12
GO

CREATE TABLE KHACHHANG
(
	MAKH CHAR(10) NOT NULL,
	TENKH NVARCHAR(40),
	GIOITINH NVARCHAR(3),
	CONSTRAINT PK_KHACHHANG PRIMARY KEY(MAKH)
)


CREATE TABLE KHO
(
	MAKHO CHAR(10) NOT NULL,
	DIENTICH FLOAT,
	DIACHI NVARCHAR(100),
	CONSTRAINT PK_KHO PRIMARY KEY(MAKHO)
)

CREATE TABLE CUAHANG
(
	MACH CHAR(10) NOT NULL,
	MAQL CHAR(10),
	TEN NVARCHAR(50),
	DIACHI NVARCHAR(100),
	SDT INT,
	CONSTRAINT PK_CUAHANG PRIMARY KEY(MACH),
)

CREATE TABLE QUANLY
(
	MAQL CHAR(10) NOT NULL,
	MACH CHAR(10),
	HOTEN NVARCHAR(40),
	NGAYSINH DATE,
	SDT INT,
	CONSTRAINT PK_QUANLY PRIMARY KEY(MAQL),
	CONSTRAINT FK_QUANLY_CUAHANG FOREIGN KEY(MACH) REFERENCES CUAHANG(MACH)
)

CREATE TABLE NHANVIEN
(
	MANV CHAR(10) NOT NULL,
	MAQL CHAR(10),--N
	HOTEN NVARCHAR(40),
	NGAYSINH DATE,
	DIACHI NVARCHAR(100),
	SDT INT,
	CONSTRAINT PK_NHANVIEN PRIMARY KEY(MANV),
	CONSTRAINT FK_NHANVIEN_QUANLY FOREIGN KEY(MAQL) REFERENCES QUANLY(MAQL)
)

CREATE TABLE SANPHAM
(
	MASP CHAR(10) NOT NULL,
	MACH CHAR(10),
	TENSP NVARCHAR(40),
	GIABAN FLOAT,
	MOTA NVARCHAR(50),
	CONSTRAINT PK_SANPHAM PRIMARY KEY(MASP),
	CONSTRAINT FK_SANPHAM_CUAHANG FOREIGN KEY(MACH) REFERENCES CUAHANG(MACH)
)

CREATE TABLE KHUYENMAI
(
	MAKM CHAR(10) NOT NULL,
	MASP CHAR(10),
	TENKM NVARCHAR(100),
	THOIGIAN NVARCHAR(30),
	NGAYBD DATE,
	NGAYKT DATE,
	CONSTRAINT PK_KHUYENMAI PRIMARY KEY(MAKM),
	CONSTRAINT FK_KHUYENMAI_SANPHAM FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP),
)

CREATE TABLE PHIEUNHAP
(
	MAPN CHAR(10) NOT NULL,
	MAKHO CHAR(10),
	NGAYLAP DATE,
	CONSTRAINT PK_PHIEUNHAP PRIMARY KEY(MAPN),
	CONSTRAINT FK_PHIEUNHAP_KHO FOREIGN KEY(MAKHO) REFERENCES KHO(MAKHO)
)

CREATE TABLE NHACUNGCAP
(
	MANCC CHAR(10) NOT NULL,
	TENNCC NVARCHAR(40),
	MAPN CHAR(10),
	CONSTRAINT PK_NHACUNGCAP PRIMARY KEY(MANCC),
	CONSTRAINT FK_NHACUNGCAP_PHIEUNHAP FOREIGN KEY(MAPN) REFERENCES PHIEUNHAP(MAPN)
)

CREATE TABLE PHIEUXUAT
(
	MAPX CHAR(10) NOT NULL,
	MAQL CHAR(10),
	MAKHO CHAR(10),
	NGAYLAP DATE,
	CONSTRAINT PK_PHIEUXUAT PRIMARY KEY(MAPX, MAQL, MAKHO),
	CONSTRAINT FK_PHIEUXUAT_QUANLY FOREIGN KEY(MAQL) REFERENCES QUANLY(MAQL),
	CONSTRAINT FK_PHIEUXUAT_KHO FOREIGN KEY(MAKHO) REFERENCES KHO(MAKHO)
)

CREATE TABLE HOADON
(
	MAHD CHAR(10) NOT NULL,
	MAKH CHAR(10),
	NGAYLAP DATE,
	TONGTIEN FLOAT,
	CONSTRAINT PK_HOADON PRIMARY KEY(MAHD, MAKH),
	CONSTRAINT FK_HOADON_KHACHHANG FOREIGN KEY(MAKH) REFERENCES KHACHHANG(MAKH)
)

CREATE TABLE PHIEUTICHDIEM
(
	MAPTD CHAR(10) NOT NULL,
	MAKH CHAR(10),
	NGAYLAP DATE,
	SODIEM INT,
	CONSTRAINT PK_PHIEUTICHDIEM PRIMARY KEY(MAPTD, MAKH),
	CONSTRAINT FK_PHIEUTICHDIEM_KHACHHANG FOREIGN KEY(MAKH) REFERENCES KHACHHANG(MAKH)
)

CREATE TABLE SANPHAM_NHACC
(
	MASP CHAR(10) NOT NULL,
	MANCC CHAR(10) NOT NULL,
	CONSTRAINT PK_SANPHAM_NHACC PRIMARY KEY(MASP, MANCC),
	CONSTRAINT FK_SPNCC_SANPHAM FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP),
	CONSTRAINT FK_SPNCC_NHACC FOREIGN KEY(MANCC) REFERENCES NHACUNGCAP(MANCC)
)

CREATE TABLE QUANLY_KHO
(
	MAQL CHAR(10) NOT NULL,
	MAKHO CHAR(10) NOT NULL,
	CONSTRAINT PK_QUANLY_KHO PRIMARY KEY(MAQL, MAKHO),
	CONSTRAINT FK_QLK_QUANLY FOREIGN KEY(MAQL) REFERENCES QUANLY(MAQL),
	CONSTRAINT FK_QLK_KHO FOREIGN KEY(MAKHO) REFERENCES KHO(MAKHO)
)

CREATE TABLE NHANVIEN_KHACHHANG
(
	MANV CHAR(10) NOT NULL,
	MAKH CHAR(10) NOT NULL,
	CONSTRAINT PK_NHANVIEN_KHACHHANG PRIMARY KEY(MANV, MAKH),
	CONSTRAINT FK_NVKH_NHANVIEN FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV),
	CONSTRAINT FK_NVKH_KHACHHANG FOREIGN KEY(MAKH) REFERENCES KHACHHANG(MAKH)
)

-- KHÓA NGOẠI
	ALTER TABLE CUAHANG ADD CONSTRAINT FK_CUAHANG_QUANLY FOREIGN KEY(MAQL) REFERENCES QUANLY(MAQL)
--=========================== NHẬP LIỆU ===========================
	INSERT INTO KHACHHANG VALUES('KH001',N'Cao Hoàng Khánh Băng',N'Nam')

	SET DATEFORMAT DMY
	INSERT INTO KHACHHANG 
	VALUES
	('KH002',N'Huỳnh Kim Ánh',N'Nữ'),
	('KH003',N'Nguyễn Văn Công',N'Nam'),
	('KH004',N'Nguyễn Lê Mai Thảo',N'Nữ'),
	('KH005',N'Lê Huỳnh Như',N'Nữ'),
	('KH006',N'Trịnh Công Lý',N'Nam'),
	('KH007',N'Nguyễn Quốc Nguyên',N'Nam'),
	('KH008',N'Đoàn Trọng Khang',N'Nam'),
	('KH009',N'Nguyễn Thị Kim Duyên',N'Nữ'),
	('KH010',N'Nguyễn Thị Hương Trang',N'Nữ')

	INSERT INTO KHACHHANG 
	VALUES
	('KH011',N'Huỳnh Trọng Thưởng',N'Nam'),
	('KH012',N'Huỳnh Trọng Tuyển',N'Nam'),
	('KH013',N'Nguyễn Lê Quốc Hộ',N'Nam'),
	('KH014',N'Nguyễn Ngọc Phương Thảo',N'Nữ'),
	('KH015',N'Uyển Lý Ngọc Nhi',N'Nữ'),
	('KH016',N'Trần Phương Lan',N'Nữ'),
	('KH017',N'Đặng Thị Thành',N'Nữ'),
	('KH018',N'Đoàn Nguyễn Thùy Linh',N'Nữ'),
	('KH019',N'Trương Thảo Vi',N'Nữ'),
	('KH020',N'Lê Bảo Hưng',N'Nam')
INSERT INTO KHACHHANG 
VALUES
	('KH021',N'Cao Hoàng Khánh Băng',N'Nam'),
	('KH022',N'Lê Thị Mỹ Linh',N'Nữ'),
	('KH023',N'Nguyễn Văn Phúc',N'Nam'),
	('KH024',N'Phạm Thị Phương Anh',N'Nữ'),
	('KH025',N'Huỳnh Trường Thọ',N'Nam'),
	('KH026',N'Trần Minh Tâm',N'Nam'),
	('KH027',N'Nguyễn Thị Thanh Trúc',N'Nữ'),
	('KH028',N'Nguyễn Văn Sơn',N'Nam'),
	('KH029',N'Trần Thế Anh',N'Nam'),
	('KH030',N'Nguyễn Thị Vân Anh',N'Nữ')

	INSERT INTO KHO
	VALUES
	('K001', 1000, N'221 Nguyễn Phúc Chu, Phường 15, Tân Bình'),
	('K002', 1300, N'28 Trương Công Định, Phường 14, Tân Bình'),
	('K003', 2000, N'146C Tân Kỳ Tân Quý, P. Phú Thuận, Tân Phú'),
	('K004', 1500, N'Y12 Hồng Lĩnh, Phường 15, Quận 10'),
	('K005', 2700, N'45 Nguyễn Văn Bảo, Phường 4, Gò Vấp'),
	('K006', 3000, N'233B Bùi Thị Xuân, Phường 1, Tân Bình'),
	('K007', 1500, N'74 Trương Quốc Dung, Phường 10, Phú Nhuận'),
	('K008', 2300, N'86 Thành Mỹ, Phường 08, Tân Bình'),
	('K009', 3500, N'11 ấp 3, Xuân Thới Thượng, Hóc Môn'),
	('K010', 2900, N'19A Đ. Trần Văn Giàu, Lê Minh Xuân, Bình Chánh')
INSERT INTO KHO 
VALUES
	('K011', 200, N'123 đường ABC, Quận XYZ'),
	('K012', 500, N'123 đường DEF, Quận GHI'),
	('K013', 800, N'123 đường HIJ, Quận KLM'),
	('K014', 300, N'123 đường NOP, Quận QRS'),
	('K015', 700, N'123 đường TUV, Quận WXY'),
	('K016', 1000, N'123 đường ZAB, Quận CDE'),
	('K017', 400, N'123 đường FGH, Quận IJK'),
	('K018', 600, N'123 đường LMN, Quận OPQ'),
	('K019', 900, N'123 đường RST, Quận UVW'),
	('K020', 250, N'123 đường XYZ, Quận ABC')
	INSERT INTO KHO
	VALUES
	('K021', 1216, N'Đường số 10, Phường 10, Q.Gò Vấp'),
	('K022', 1417, N'78C Hòa Bình, Phường 5,Q.11'),
	('K023', 2328, N'454 Đường Võ Chí Công, Khu phố 2,Phường Phú Hữu, TP.Thủ Đức'),
	('K024', 1500, N'09 Nguyễn Quý Yêm, Khu phố 4,Phường An Lạc,Q.Bình Tân'),
	('K025', 1900, N'78-80-82 Tản Đà, Phường 11, Q.5'),
	('K026', 1000, N'63 Bùi Văn Ba, Tân Thuận Đông, Q.7'),
	('K027', 950, N'G16/37, ấp 7, xã Lê Minh Xuân, Q.Bình Chánh'),
	('K028', 1200, N'E2/40A, ấp 5, Vĩnh Lộc A, Q.Bình Chánh'),
	('K029', 1800, N'88-90 Vườn Lài Nối Dài, Phường An Phú Đông, Q.12'),
	('K030', 2324, N'63 Nguyễn Đỗ Cung, Phường Tây Thạnh, Q.Tân Phú')

	INSERT INTO CUAHANG
	VALUES
	('CH001', NULL, N'Cửa hàng số 1', N'25 Nguyễn Đỗ Cung, Phường Tây Thạnh, Tân Phú', 0359012178),
	('CH002', NULL, N'Cửa hàng số 2', N'22A Cộng Hòa, Phường 4, Tân Bình', 0989751723),
	('CH003', NULL, N'Cửa hàng số 3', N'334/3C Đường Số 5, Phường 5, Gò Vấp', 0918234654),
	('CH004', NULL, N'Cửa hàng số 4', N'363 Phan Văn Trị, Phường 11, Bình Thạnh', 0978123765),
	('CH005', NULL, N'Cửa hàng số 5', N'227 Lê Đức Thọ, Phường 5, Gò Vấp', 0909456768),
	('CH006', NULL, N'Cửa hàng số 6', N'675 Vườn Lài, An Phú Đông, Quận 12', 0984737135),
	('CH007', NULL, N'Cửa hàng số 7', N'311 Nguyễn Văn Trỗi, Phường 1, Tân Bình', 0359378291),
	('CH008', NULL, N'Cửa hàng số 8', N'52 Thành Thái, Phường 12, Quận 10', 0934023848),
	('CH009', NULL, N'Cửa hàng số 9', N'307 Huỳnh Thị Na, Ấp 6, Hóc Môn', 0359383474),
	('CH010', NULL, N'Cửa hàng số 10', N'07 Lê Minh Xuân, Phường 7, Tân Bình', 0354020359)
	

INSERT INTO CUAHANG
	VALUES
	('CH011', NULL, N'Cửa hàng số 11', N'93 Phạm Ngọc Thảo, Phường Tây Thạnh, Q.Tân Phú', 0397810632),
	('CH012', NULL, N'Cửa hàng số 12', N'29 Bàu Cát 6,Phường 14, Q.Tân Bình', 0338458223),
	('CH013', NULL, N'Cửa hàng số 13', N'26/42 Tân Sơn Nhì, Q.Tân Phú', 0948585953),
	('CH014', NULL, N'Cửa hàng số 14', N'15/28, Đường Cộng Hòa, Phường 13, Q.Tân Bình', 0376083995),
	('CH015', NULL, N'Cửa hàng số 15', N'24,Đường Hoàng Văn Thụ, Phương 9, Q.Phú Nhuận', 0326971125), 
	('CH016', NULL, N'Cửa hàng số 16', N'60/7, Đường Thới An 18, Phường Thới An, Quận 12', 0733510688),
	('CH017', NULL, N'Cửa hàng số 17', N'101/34 Đường Thành Thái, Phường 14, Q.10', 0354638598),
	('CH018', NULL, N'Cửa hàng số 18', N'Đường Bùi Xương Trạch, Phường Phước Long A, TP.Thủ Đức', 0827246649),
	('CH019', NULL, N'Cửa hàng số 19', N'162/24 Nguyễn Duy Cung,Q.Gò Vấp', 0309786545),
	('CH020', NULL, N'Cửa hàng số 20', N'126A,Đường Huỳnh Tấn Phát, Phường Phú Mỹ,Q.7', 0997312862)
INSERT INTO CUAHANG 
VALUES
	('CH021', NULL, N'Cửa hàng số 21', N'123 đường ABC, Quận XYZ', 123456789),
	('CH022', NULL, N'Cửa hàng số 22', N'123 đường DEF, Quận GHI', 453219876),
	('CH023', NULL, N'Cửa hàng số 23', N'123 đường HIJ, Quận KLM', 789456123),
	('CH024', NULL, N'Cửa hàng số 24', N'123 đường NOP, Quận QRS', 963852741),
	('CH025', NULL, N'Cửa hàng số 25', N'123 đường TUV, Quận WXY', 987654321),
	('CH026', NULL, N'Cửa hàng số 26', N'123 đường ZAB, Quận CDE', 159753468),
	('CH027', NULL, N'Cửa hàng số 27', N'123 đường FGH, Quận IJK', 369852147),
	('CH028', NULL, N'Cửa hàng số 28', N'123 đường LMN, Quận OPQ', 753951864),
	('CH029', NULL, N'Cửa hàng số 29', N'123 đường RST, Quận UVW', 258741369),
	('CH030', NULL, N'Cửa hàng số 30', N'123 đường XYZ, Quận ABC', 147852369)

	INSERT INTO QUANLY
	VALUES
	('QL001', 'CH001', N'Nguyễn Văn Bình', '02/10/1997', 0359012178),
	('QL002', 'CH002', N'Cao Kỳ Khôi', '16/07/1996', 0989751723),
	('QL003', 'CH003', N'Nguyễn Bình Nguyên', '03/12/1994', 0918234654),
	('QL004', 'CH004', N'Lê Thảo Nguyên', '05/09/1994', 0978123765),
	('QL005', 'CH005', N'Hoàng Đức Quân', '22/12/1995', 0909456768),
	('QL006', 'CH006', N'Nguyễn Thị Thu Trang', '29/10/1996', 0984737135),
	('QL007', 'CH007', N'Nguyễn Ngọc Hoa', '18/03/1993', 0359378291),
	('QL008', 'CH008', N'Lê Công Định', '12/01/1993', 0934023848),
	('QL009', 'CH009', N'Trịnh Văn Nam', '23/06/1991', 0359383474),
	('QL010', 'CH010', N'Nguyễn Hoàng Thế Quân', '14/02/1996', 0354020359)
	INSERT INTO QUANLY 
VALUES
	('QL011', 'CH011', N'Phạm Văn Anh', '08/12/1990', 123456789),
	('QL012', 'CH013', N'Nguyễn Thị Thu', '03/5/1992', 789456123),
	('QL013', 'CH015', N'Trần Văn Đức', '10/10/1995', 987654321),
	('QL014', 'CH017', N'Nguyễn Trường Sinh', '06/07/1991', 369852147),
	('QL015', 'CH019', N'Đỗ Thái Bình', '11/11/1993', 258741369),
	('QL016', 'CH012', N'Phan Thị Diệu Linh', '05/08/1994', 453219876),
	('QL017', 'CH014', N'Lê Thị Lan Anh', '02/03/1996', 963852741),
	('QL018', 'CH016', N'Vương Thị Ngọc Mai', '09/03/1998', 159753468),
	('QL019', 'CH018', N'Đào Khánh Trường', '12/08/1998', 753951864),
	('QL020', 'CH020', N'Nguyễn Văn Bình', '01/05/1990', 147852369)
	INSERT INTO QUANLY
	VALUES
	('QL021', 'CH021', N'Huỳnh Minh Anh', '29/06/1996', 0397810632),
	('QL022', 'CH022', N'Nguyễn Thúy Ái', '22/06/1998', 0338458223),
	('QL023', 'CH023', N'Phạm Nhật Minh', '08/10/1999',0948585953),
	('QL024', 'CH024', N'Nguyễn Huỳnh Như', '30/08/1993', 0376083995),
	('QL025', 'CH025', N'Đoàn Quốc Khánh', '01/12/1995', 0326971125),
	('QL026', 'CH026', N'Nguyễn Mỷ Tiên', '29/03/1997', 0733510688),
	('QL027', 'CH027', N'Hoàng Anh Quân', '09/03/1993',0354638598),
	('QL028', 'CH028', N'Lê Thanh Huyền', '29/11/1999',0827246649),
	('QL029', 'CH029', N'Nguyễn Thanh Bình', '27/02/1994', 0309786545),
	('QL030', 'CH030', N'Nguyễn Thanh Vũ', '14/06/1995', 0997312862)


	SET DATEFORMAT DMY
	INSERT INTO NHANVIEN
	VALUES
	('NV001', 'QL001', N'Nguyễn Văn Minh', '01/11/2000', N'35 Nguyễn Đỗ Cung, Tây Thạnh, Tân Phú', 0357032323)
	INSERT INTO NHANVIEN
	VALUES
	('NV002', 'QL001', N'Lê Ánh Nguyệt', '28/02/2002', N'532 Lê Trọng Tấn, Tây Thạnh, Tân Phú', 0983838293),
	('NV003', 'QL001', N'Nguyễn Thị Mai', '19/07/2004', N'42, Sơn Kỳ, Tân Phú', 0983737456),
	('NV004', 'QL002', N'Dương Hoàng Duy', '30/08/2003', N'53 Hoàng Hoa Thám, Phường 13, Tân Bình', 0359534758),
	('NV005', 'QL003', N'Dương Minh Trí', '11/02/2000', N'309B Quang Trung, Phường 12, Gò Vấp', 0359724758),
	('NV006', 'QL003', N'Nguyễn Thị Bích Ngọc', '13/11/2003', N'116 Dương Quảng Hàm, Phường 5, Gò Vấp', 0357032323),
	('NV007', 'QL004', N'Trịnh Hoài Nam', '25/04/2001', N'8 Bùi Đình Tuý, Phường 24, Bình Thạnh', 0987643433),
	('NV008', 'QL004', N'Nguyễn Thế Anh', '04/12/2001', N'115 Bùi Đình Tuý, Phường 12, Bình Thạnh', 0359041877),
	('NV009', 'QL006', N'Nguyễn Văn Xin', '19/06/2002', N'32 Đường Ấp Đông 1, Tân Chánh Hiệp, Hóc Môn', 0357032326),
	('NV010', 'QL007', N'Lê Thị Thu', '20/09/2000', N'4 Bạch Đằng, Phường 2, Tân Bình', 0357749323)
	

INSERT INTO NHANVIEN 
VALUES
	('NV011', 'QL011', N'Nguyễn Thị Loan', '01/12/1995', N'123 đường ABC, Quận XYZ', 123456789),
	('NV012', 'QL011', N'Lê Văn Thanh', '03/05/1997', N'123 đường DEF, Quận GHI', 453219876),
	('NV013', 'QL012', N'Phạm Văn Tân', '06/08/1999', N'123 đường HIJ, Quận KLM', 789456123),
	('NV014', 'QL012', N'Huỳnh Thị Ngọc Ánh', '04/10/1994', N'123 đường NOP, Quận QRS', 963852741),
	('NV015', 'QL013', N'Trần Thanh Thư', '10/05/1996', N'123 đường TUV, Quận WXY', 987654321),
	('NV016', 'QL013', N'Nguyễn Đăng Khoa', '09/11/1993', N'123 đường ZAB, Quận CDE', 159753468),
	('NV017', 'QL014', N'Nguyễn Trường Giang', '08/05/1998', N'123 đường FGH, Quận IJK', 369852147),
	('NV018', 'QL014', N'Hoàng Văn Khánh', '07/07/1992', N'123 đường LMN, Quận OPQ', 753951864),
	('NV019', 'QL015', N'Nguyễn Đức Trí', '12/08/1994', N'123 đường RST, Quận UVW', 258741369),
	('NV020', 'QL015', N'Đỗ Văn Sơn', '10/09/1990', N'123 đường XYZ, Quận ABC', 147852369)
	INSERT INTO NHANVIEN
	VALUES
	('NV021', 'QL021', N'Lê Kim Anh', '22/11/2004', N'118/93 Nguyễn Đỗ Cung, Tây Thạnh, Q.Tân Phú', 0382371902),
	('NV022', 'QL021', N'Trần Khánh Quỳnh', '20/03/1999', N'114 Tô Ngọc Vân, Phường 15, Q.Gò Vấp', 0338458287),
	('NV023', 'QL022', N'Lê Hà', '11/09/2001', N'86/25A Ông Ích Khiêm, Phường 14, Q.11', 0988585943),
	('NV024', 'QL023', N'Nguyễn Hoàng Trí', '30/08/2003', N'890 Lạc Long Quân, Phường 8, Q.Tân Bình', 0359534758),
	('NV025', 'QL023', N'Thái Hoàng Quân', '18/03/2001', N'4/11/7, Đường Lưu Chí Hiếu, Phường Tây Thạnh, Q.Tân Phú', 0396247082),
	('NV026', 'QL023', N'Hoàng Bảo Ngọc', '12/01/1999', N'Kênh 19/5, Phường Tây Thạnh, Q.Tân Phú', 0907225023),
	('NV027', 'QL024', N'Dương Anh Tú', '19/05/2002', N'Đường số 19, Phương An Phú (Quận 2 cũ),TP.Thủ Đức', 0977643763),
	('NV028', 'QL025', N'Huỳnh Khương Duy', '03/08/2003', N'70/40 Bùi Đình Tuý, Phường 12, Q.Bình Thạnh', 0907198230),
	('NV029', 'QL026', N'Nguyễn Hoàng Nam', '22/07/2000', N'Phan Đăng Lưu, Phường 5, Q.Phú Nhuận', 0357027653),
	('NV030', 'QL027', N'Trần Ái My', '12/10/1998', N'220/6A Hoàng Hoa Thám, Phường 5, Q.Phú Nhuận', 0357234523)

	INSERT INTO SANPHAM
	VALUES
	('SP001', 'CH001', N'Dầu gội', 50000, NULL),
	('SP002', 'CH001', N'Sữa tắm', 60000, NULL),
	('SP003', 'CH002', N'Xà bông', 10000, NULL),
	('SP004', 'CH002', N'Dầu xả', 5000, NULL),
	('SP005', 'CH001', N'Nước rửa chén', 30000, NULL),
	('SP006', 'CH003', N'Mì tôm', 4000, NULL),
	('SP007', 'CH003', N'Cocacola', 9000, NULL),
	('SP008', 'CH004', N'Nước cam', 10000, NULL),
	('SP009', 'CH004', N'Nước dâu', 10000, NULL),
	('SP010', 'CH005', N'Pepsi', 10000, NULL)


INSERT INTO SANPHAM 
VALUES
	('SP011', 'CH011', N'Rau cải xanh', 15000, N'Rau cải xanh non tươi ngon'),
	('SP012', 'CH013', N'Cà chua', 20000, N'Cà chua đỏ tươi ngon'),
	('SP013', 'CH015', N'Khoai lang', 18000, N'Khoai lang sạch, tươi ngon'),
	('SP014', 'CH017', N'Cam', 25000, N'Cam ngọt, chín mọng'),
	('SP015', 'CH019', N'Chuối', 12000, N'Chuối chín, mọng nước'),
	('SP016', 'CH012', N'Cà rốt', 18000, N'Cà rốt tươi ngon, có nhiều vitamin'),
	('SP017', 'CH014', N'Nấm', 30000, N'Nấm tươi ngon'),
	('SP018', 'CH016', N'Bơ', 60000, N'Bơ thơm ngon, chất lượng cao'),
	('SP019', 'CH018', N'Đậu hà lan', 22000, N'Đậu hà lan sạch, tươi'),
	('SP020', 'CH020', N'Măng tây', 35000, N'Măng tây ngọt, mọng nước')
	INSERT INTO SANPHAM
	VALUES
	('SP021', 'CH021', N'Gạo', 120000, NULL),
	('SP022', 'CH021', N'Bột', 10000, NULL),
	('SP023', 'CH022', N'Dầu ăn', 57000, NULL),
	('SP024', 'CH022', N'Nước chấm', 30000, NULL),
	('SP025', 'CH021', N'Kem', 30000, NULL),
	('SP026', 'CH023', N'Mì tôm', 100000, NULL),
	('SP027', 'CH023', N'Trái Cây', 64000, NULL),
	('SP028', 'CH024', N'Sữa', 16000, NULL),
	('SP029', 'CH024', N'Bánh kẹo', 52000, NULL),
	('SP030', 'CH025', N'Sting', 49000, NULL)
	INSERT INTO KHUYENMAI
	VALUES
	('KM001', 'SP007', N'Cocacola giảm giá 20%', NULL, '12/05/2023', '20/05/2023'),
	('KM002', 'SP001', N'Dầu gội tặng 10% dung tích', NULL, '10/05/2023', '10/06/2023'),
	('KM003', 'SP002', N'Sữa tắm giảm giá 20%', NULL, '15/05/2023', '10/06/2023'),
	('KM004', 'SP004', N'Dầu xả mua 2 tặng 1', NULL, '12/05/2023', '20/05/2023'),
	('KM005', 'SP006', N'Mì tôm mua 10 gói tặng 1 gói', NULL, '10/05/2023', '10/06/2023'),
	('KM006', 'SP008', N'Nước cam mua 1 lốc 6 chai tặng 1 chai', NULL, '10/05/2023', '30/06/2023'),
	('KM007', 'SP009', N'Nước dâu mua 1 lốc 6 chai tặng 1 chai', NULL, '10/05/2023', '30/06/2023'),
	('KM008', 'SP010', N'Pepsi mua 1 lốc 6 chai tặng 1 chai', NULL, '10/05/2023', '30/06/2023'),
	('KM009', 'SP005', N'Nước rửa chén tặng 1 chùi nồi', NULL, '12/05/2023', '20/05/2023'),
	('KM010', 'SP003', N'Xà bông giảm giá 10%', NULL, '12/05/2023', '30/05/2023')

	INSERT INTO KHUYENMAI
	VALUES
	('KM021', 'SP027', N'Quýt giống Úc 1kg giảm 30%', NULL, '10/05/2023', '30/05/2023'),
	('KM022', 'SP021', N'Gạo ST25 Đồng Việt giảm giá 33%', NULL, '12/05/2023', '12/06/2023'),
	('KM023', 'SP022', N'Bột chiên giòn Meizan giảm giá 33%', NULL, '10/05/2023', '10/06/2023'),
	('KM024', 'SP024', N'Muối ớt Guyumi giảm giá 20%', NULL, '12/05/2023', '30/05/2023'),
	('KM025', 'SP026', N'Mì Hảo 100 mua 1 thùng giảm 18%', NULL, '12/05/2023', '12/06/2023'),
	('KM026', 'SP028', N'3 bịch sữa Dutch Lady giảm giá 24%', NULL, '01/05/2023', '30/06/2023'),
	('KM027', 'SP029', N'Bánh xốp KitKat trà xanh giảm giá 30%', NULL, '15/05/2023', '15/06/2023'),
	('KM028', 'SP030', N'Sting mua 1 lốc 6 lon giảm giá 23%', NULL, '10/05/2023', '30/05/2023'),
	('KM029', 'SP025', N'Kem socola Merino mua 2 tặng 1', NULL, '10/05/2023', '30/05/2023'),
	('KM030', 'SP023', N'Dầu ăn Meizan giảm giá 12%', NULL, '15/05/2023', '15/06/2023')

	INSERT INTO PHIEUNHAP
	VALUES
	('N001', 'K001', '10/05/2023'),
	('N002', 'K002', '07/05/2023'),
	('N003', 'K003', '01/05/2023'),
	('N004', 'K004', '12/04/2023'),
	('N005', 'K005', '03/05/2023'),
	('N006', 'K006', '10/05/2023'),
	('N007', 'K007', '03/05/2023'),
	('N008', 'K008', '11/05/2023'),
	('N009', 'K009', '09/05/2023'),
	('N010', 'K010', '08/05/2023')

INSERT INTO PHIEUNHAP (MAPN,MAKHO,NGAYLAP)
VALUES ('N021', 'K021', '12/11/2022'),
       ('N022', 'K022', '18/12/2022'),
       ('N023', 'K023', '24/03/2022'),
       ('N024', 'K024', '19/12/2022'),
       ('N025', 'K025', '17/05/2022'),
       ('N026', 'K026', '29/06/2022'),
       ('N027', 'K027', '01/07/2022'),
       ('N028', 'K028', '11/08/2022'),
       ('N029', 'K029', '2/11/2022'),
       ('N030', 'K030', '11/11/2022');	

	INSERT INTO NHACUNGCAP
	VALUES
	('C001', N'Công ty TNHH SUNTORY PEPSICO', 'N001'),
	('C002', N'Công ty TNHH Lavie', 'N002'),
	('C003', N'Dove', 'N003'),
	('C004', N'Công ty TNHH ONA', 'N004'),
	('C005', N'Công ty Cổ phần Acecook', 'N004'),
	('C006', N'Công ty Ecoxanh ', 'N006'),
	('C007', N'Công Ty TNHH Roxane', 'N007'),
	('C008', N'Công ty TNHH Red Bull', 'N008'),
	('C009', N'Công ty TNHH Nước Giải Khát Coca‑Cola', 'N009'),
	('C010', N' CÔNG TY TNHH TBS', 'N010')

	INSERT INTO NHACUNGCAP
	VALUES
	('C011', N'Công ty TNHH XNK NHẤT THIÊN', 'N001'),
	('C012', N'Công ty TNHH Dầu thực vật Cái Lân', 'N002'),
	('C013', N'Công ty gia vị Trí Việt Phát', 'N003'),
	('C014', N'CÔNG TY TNHH GẠO ĐỒNG VIỆT', 'N004'),
	('C015', N'Công ty Cổ phần Acecook', 'N004'),
	('C016', N'Công ty TNHH MTV KIDO ', 'N006'),
	('C017', N'Công ty TNHH FrieslandCampina Việt Nam', 'N007'),
	('C018', N'Công ty Nestlé Việt Nam', 'N008'),
	('C019', N'Công ty TNHH Meizan CLV (MCC) ', 'N009'),
	('C020', N'Công ty PepsiCo Việt Nam', 'N010')	
	INSERT INTO PHIEUXUAT
	VALUES
	('X001', 'QL001', 'K001', '12/05/2023'),
	('X002', 'QL002', 'K002', '10/05/2023'),
	('X003', 'QL003', 'K003', '05/05/2023'),
	('X004', 'QL004', 'K004', '17/04/2023'),
	('X005', 'QL005', 'K005', '07/05/2023'),
	('X006', 'QL006', 'K006', '15/05/2023'),
	('X007', 'QL007', 'K007', '08/05/2023'),
	('X008', 'QL008', 'K008', '12/05/2023'),
	('X009', 'QL009', 'K009', '14/05/2023'),
	('X010', 'QL010', 'K010', '12/05/2023')
	INSERT INTO PHIEUXUAT
	VALUES
	('X021', 'QL021', 'K001', '12/05/2023'),
	('X022', 'QL022', 'K002', '10/05/2023'),
	('X023', 'QL023', 'K003', '08/05/2023'),
	('X024', 'QL024', 'K004', '13/05/2023'),
	('X025', 'QL025', 'K005', '06/05/2023'),
	('X026', 'QL026', 'K006', '15/05/2023'),
	('X027', 'QL027', 'K007', '17/05/2023'),
	('X028', 'QL028', 'K008', '15/05/2023'),
	('X029', 'QL029', 'K009', '12/05/2023'),
	('X030', 'QL030', 'K010', '10/05/2023')

	INSERT INTO HOADON
	VALUES
	('HD001', 'KH001', '03/04/2023', 100000),
	('HD002', 'KH002', '01/02/2023', 250000),
	('HD003', 'KH003', '25/12/2022', 400000),
	('HD004', 'KH004', '27/11/2022', 95000),
	('HD005', 'KH005', '02/05/2023', 50000),
	('HD006', 'KH006', '21/03/2023', 127000),
	('HD007', 'KH007', '16/12/2022', 330000),
	('HD008', 'KH008', '09/10/2022', 420000),
	('HD009', 'KH009', '11/04/2023', 186000),
	('HD010', 'KH010', '19/03/2023', 234000)
INSERT INTO HOADON
VALUES
	('HD011', 'KH011', '12/03/2023', 200000),
	('HD012', 'KH012', '22/04/2023', 360000),
	('HD013', 'KH013', '19/02/2023', 230000),
	('HD014', 'KH014', '12/05/2023', 58000),
	('HD015', 'KH015', '28/02/2023', 12000),
	('HD016', 'KH016', '26/03/2023', 330000),
	('HD017', 'KH017', '16/05/2023', 250000),
	('HD018', 'KH018', '12/04/2023', 550000),
	('HD019', 'KH019', '21/02/2023', 470000),
	('HD020', 'KH020', '07/03/2023', 690000)
	INSERT INTO HOADON
	VALUES
	('HD021', 'KH011', '22/03/2023', 220000),
	('HD022', 'KH012', '12/04/2023', 260000),
	('HD023', 'KH013', '09/02/2023', 430000),
	('HD024', 'KH014', '02/05/2023', 78000),
	('HD025', 'KH015', '18/02/2023', 32000),
	('HD026', 'KH016', '16/03/2023', 230000),
	('HD027', 'KH017', '06/05/2023', 450000),
	('HD028', 'KH018', '02/04/2023', 350000),
	('HD029', 'KH019', '11/02/2023', 170000),
	('HD030', 'KH020', '17/03/2023', 290000)
INSERT INTO HOADON (MAHD,MAKH,NGAYLAP,TONGTIEN)
VALUES ('HD031','KH001','11/11/2022',100000),
       ('HD032','KH002','13/12/2022',200000),
       ('HD033','KH003','02/10/2022',300000),
       ('HD034','KH004','11/04/2022',400000),
       ('HD035','KH005','21/06/2022',500000),
       ('HD036','KH006','13/03/2022',600000),
       ('HD037','KH007','02/02/2022',700000),
       ('HD038','KH008','12/08/2022',800000),
       ('HD039','KH009','11/02/2022',900000),
       ('HD040','KH010','13/02/2022',1000000);	
	INSERT INTO PHIEUTICHDIEM
	VALUES
	('TD001', 'KH001', '03/04/2023', 1),
	('TD002', 'KH002', '01/02/2023', 2),
	('TD003', 'KH003', '25/12/2022', 4),
	('TD004', 'KH004', '27/11/2022', 0),
	('TD005', 'KH005', '02/05/2023', 0),
	('TD006', 'KH006', '21/03/2023', 1),
	('TD007', 'KH007', '16/12/2022', 3),
	('TD008', 'KH008', '09/10/2022', 4),
	('TD009', 'KH009', '11/04/2023', 1),
	('TD010', 'KH010', '19/03/2023', 2)
INSERT INTO PHIEUTICHDIEM (MAPTD,MAKH,NGAYLAP,SODIEM)
VALUES ('TD011', 'KH011', '14/03/2022', 10),
       ('TD012', 'KH012', '15/10/2022', 20),
       ('TD013', 'KH013', '12/11/2022', 30),
       ('TD014', 'KH014', '13/04/2022', 40),
       ('TD015', 'KH015', '19/02/2022', 50),
       ('TD016', 'KH016', '01/10/2023', 60),
       ('TD017', 'KH017', '20/11/2023', 70),
       ('TD018', 'KH018', '21/06/2023', 80),
       ('TD019', 'KH019', '25/09/2023', 90),
       ('TD020' ,'KH020' ,'28/05/2023' ,100);
	
	INSERT INTO SANPHAM_NHACC
	VALUES
	('SP001','C003'),
	('SP002','C006'),
	('SP003','C010'),
	('SP004','C007'),
	('SP005','C010'),
	('SP006','C005'),
	('SP007','C009'),
	('SP008','C008'),
	('SP009','C008'),
	('SP010','C001')
	INSERT INTO SANPHAM_NHACC
	VALUES
	('SP021','C011'),
	('SP022','C012'),
	('SP023','C013'),
	('SP024','C014'),
	('SP025','C015'),
	('SP026','C016'),
	('SP027','C017'),
	('SP028','C018'),
	('SP029','C019'),
	('SP030','C020')

	INSERT INTO QUANLY_KHO
	VALUES
	('QL001','K003'),
	('QL002','K001'),
	('QL003','K005'),
	('QL004','K006'),
	('QL005','K004'),
	('QL006','K010'),
	('QL007','K008'),
	('QL008','K004'),
	('QL009','K009'),
	('QL010','K002')
	INSERT INTO QUANLY_KHO
	VALUES
	('QL011','K011'),
	('QL012','K012'),
	('QL013','K014'),
	('QL014','K018'),
	('QL015','K019'),
	('QL016','K020'),
	('QL017','K016'),
	('QL018','K013'),
	('QL019','K017'),
	('QL020','K015')
	INSERT INTO NHANVIEN_KHACHHANG
	VALUES
	('NV001', 'KH002'),
	('NV001', 'KH003'),
	('NV003', 'KH009'),
	('NV004', 'KH004'),
	('NV004', 'KH010'),
	('NV006', 'KH005'),
	('NV007', 'KH007'),
	('NV007', 'KH008'),
	('NV008', 'KH001'),
	('NV009', 'KH006')
INSERT INTO NHANVIEN_KHACHHANG
VALUES
	('NV011','KH011'),
    ('NV012','KH012'),
    ('NV013','KH013'),
    ('NV014','KH014'),
    ('NV015','KH015'),
    ('NV016','KH016'),
    ('NV017','KH017'),
    ('NV018','KH018'),
    ('NV019','KH019'),
    ('NV020','KH020')
	INSERT INTO NHANVIEN_KHACHHANG
	VALUES
	('NV021', 'KH008'),
	('NV021', 'KH004'),
	('NV023', 'KH003'),
	('NV024', 'KH006'),
	('NV024', 'KH007'),
	('NV026', 'KH005'),
	('NV027', 'KH009'),
	('NV027', 'KH010'),
	('NV028', 'KH002'),
	('NV029', 'KH001')	
-- Cập nhật người quản lý cho cửa hàng
	UPDATE CUAHANG
	SET MAQL = 'QL001'
	WHERE MACH IN('CH001', 'CH002','CH003', 'CH005', 'CH007', 'CH009')
	UPDATE CUAHANG
	SET MAQL = 'QL002'
	WHERE MACH IN('CH004')
	UPDATE CUAHANG
	SET MAQL = 'QL003'
	WHERE MACH IN('CH006', 'CH008')
	UPDATE CUAHANG
	SET MAQL = 'QL004'
	WHERE MACH IN('CH010', 'CH012','CH011')
	UPDATE CUAHANG
	SET MAQL = 'QL005'
	WHERE MACH = 'CH013'
	UPDATE CUAHANG
	SET MAQL = 'QL006'
	WHERE MACH = 'CH014'
	UPDATE CUAHANG
	SET MAQL = 'QL007'
	WHERE MACH = 'CH015'
	UPDATE CUAHANG
	SET MAQL = 'QL008'
	WHERE MACH = 'CH016'
	UPDATE CUAHANG
	SET MAQL = 'QL009'
	WHERE MACH = 'CH017'
	UPDATE CUAHANG
	SET MAQL = 'QL010'
	WHERE MACH = 'CH018'
	UPDATE CUAHANG
	SET MAQL = 'QL011'
	WHERE MACH = 'CH019'
	UPDATE CUAHANG
	SET MAQL = 'QL012'
	WHERE MACH = 'CH029'
	UPDATE CUAHANG
	SET MAQL = 'QL020'
	WHERE MACH = 'CH027'
	UPDATE CUAHANG
	SET MAQL = 'QL023'
	WHERE MACH = 'CH021'
	UPDATE CUAHANG
	SET MAQL = 'QL014'
	WHERE MACH = 'CH022'
	UPDATE CUAHANG
	SET MAQL = 'QL025'
	WHERE MACH = 'CH023'
	UPDATE CUAHANG
	SET MAQL = 'QL021'
	WHERE MACH = 'CH024'
	UPDATE CUAHANG
	SET MAQL = 'QL030'
	WHERE MACH IN('CH025', 'CH026','CH027', 'CH028', 'CH029', 'CH030')



	SELECT * FROM KHUYENMAI
-- =================================================================
-- =                                                               =
-- =                       Phần ràng buộc                          =
-- =                                                               =
-- =================================================================
--- 2001215625 CAO HOÀNG KHÁNH BĂNG
--           ================== check ==================
ALTER TABLE QUANLY
ADD CONSTRAINT CHK_NGAYSINH 
CHECK (YEAR(NGAYSINH) > 0 AND MONTH(NGAYSINH) > 0 AND DAY(NGAYSINH) > 0)

ALTER TABLE QUANLY
ADD CONSTRAINT CHK_SDT 
CHECK (SDT> 0)

ALTER TABLE CUAHANG
ADD CONSTRAINT CHK_SDT_CUAHANG CHECK (SDT > 0)

ALTER TABLE PHIEUXUAT
ADD CONSTRAINT CHK_NGAYLAP CHECK (YEAR(NGAYLAP) > 0 AND MONTH(NGAYLAP) > 0 AND DAY(NGAYLAP) > 0)

ALTER TABLE PHIEUNHAP
ADD CONSTRAINT CHK_NGAYLAP_PN CHECK (YEAR(NGAYLAP) > 0 AND MONTH(NGAYLAP) > 0 AND DAY(NGAYLAP) > 0)

ALTER TABLE KHO
ADD CONSTRAINT CHK_DIENTICH CHECK (DIENTICH > 0)

ALTER TABLE SANPHAM
ADD CONSTRAINT CHK_GIABAN CHECK (GIABAN > 0)

ALTER TABLE KHUYENMAI
ADD CONSTRAINT CHK_GIABAN CHECK (GIABAN >= 0)

ALTER TABLE KHUYENMAI
ADD CONSTRAINT CHK_NGAYBD CHECK (YEAR(NGAYBD) > 0 AND MONTH(NGAYBD) > 0 AND DAY(NGAYBD) > 0),
CONSTRAINT CHK_NGAYKT CHECK (YEAR(NGAYKT) > 0 AND MONTH(NGAYKT) > 0 AND DAY(NGAYKT) > 0)


ALTER TABLE NHANVIEN
ADD CONSTRAINT CHK_NGAYSINH_NV CHECK (YEAR(NGAYSINH) > 0 AND MONTH(NGAYSINH) > 0 AND DAY(NGAYSINH) > 0),
CONSTRAINT CHK_SDT_NHANVIEN CHECK (SDT > 0)


ALTER TABLE KHACHHANG
ADD CONSTRAINT CHK_GIOITINH_KH CHECK (GIOITINH = N'Nam' OR GIOITINH = N'Nữ')

ALTER TABLE PHIEUTICHDIEM
ADD CONSTRAINT CHK_NGAYLAP_PTD CHECK (YEAR(NGAYLAP) > 0 AND MONTH(NGAYLAP) > 0 AND DAY(NGAYLAP) > 0),
CONSTRAINT CHK_SODIEM CHECK (SODIEM >= 0)

ALTER TABLE HOADON 
ADD CONSTRAINT CHK_NGAYLAP_HD CHECK (YEAR(NGAYLAP) > 0 AND MONTH(NGAYLAP) > 0 AND DAY(NGAYLAP) > 0),
CONSTRAINT CHK_TONGTIEN CHECK (TONGTIEN >= 0)

-- ================== default ==================
ALTER TABLE NHANVIEN
ADD CONSTRAINT DF_DIACHI DEFAULT N'CHƯA XÁC ĐỊNH' FOR DIACHI
-- ================== TRIGGER ==================
-- kiểm tra thời gian khuyến mãi
CREATE TRIGGER TRG_THOIGIAN_KM 
ON KHUYENMAI
FOR INSERT, UPDATE
AS
	IF(SELECT CAST(THOIGIAN AS INT) FROM inserted) > 0 AND (SELECT DAY(NGAYBD) FROM INSERTED) < (SELECT DAY(NGAYKT) FROM INSERTED)
		COMMIT TRAN
	ELSE
		BEGIN
				PRINT N'Thời gian khuyến mãi phải lớn hơn 0'
				ROLLBACK TRAN
		END
---- Kiểm thử trigger
	set dateformat dmy
	INSERT INTO KHUYENMAI VALUES 
	('KM100', 'SP027', N'Quýt giống Úc 1kg giảm 30%','0','20/05/2023','30/05/2023')
	DROP TRIGGER TRG_THOIGIAN_KM



-- =================================================================
-- =                                                               =
-- =                       Phần truy vấn                           =
-- =                                                               =
-- =================================================================
select * from CUAHANG
select * from HOADON
select * from KHACHHANG
select * from KHO
select * from KHUYENMAI
select * from NHACUNGCAP
select * from NHANVIEN
select * from NHANVIEN_KHACHHANG
select * from PHIEUNHAP
select * from PHIEUTICHDIEM
select * from PHIEUXUAT
select * from QUANLY
select * from QUANLY_KHO
select * from SANPHAM
select * from SANPHAM_NHACC

-- KHÁNH BĂNG
--------------------------------- TRUY VẤN ĐƠN GIẢN ---------------------------------
--1 Xuất cửa hàng có địa chỉ ở Tân Bình
SELECT TEN FROM CUAHANG
WHERE DIACHI LIKE N'%Tân Bình%'

--2 Xuất kho có địa chỉ ở Tân Phú hoặc ở Tân Bình
select * from KHO
WHERE DIACHI LIKE N'%Tân Phú%' OR DIACHI LIKE N'%Tân Bình%'

--3 Xuất kho có diện tích lớn hơn 2300
SELECT * FROM KHO
WHERE DIENTICH > 2300

--4 những khuyến mãi bắt đầu từ tháng 5 năm 2023
SELECT * FROM KHUYENMAI
WHERE YEAR(NGAYBD) >= 2023 AND MONTH(NGAYBD) >= 5

--5 Những phiếu nhập có ngày lập sau tháng 5 năm 2023
SELECT * FROM PHIEUNHAP
WHERE YEAR(NGAYLAP) <= 2023 AND MONTH(NGAYLAP) > 5

--------------------------------- TRUY VẤN NÂNG CAO ---------------------------------
--6 Liệt kê các nhà cung cấp và số sản phẩm của nhà cung cấp đó
SELECT TENNCC, COUNT(MASP) AS N'SỐ SP CUNG CẤP' FROM NHACUNGCAP, SANPHAM_NHACC
WHERE NHACUNGCAP.MANCC = SANPHAM_NHACC.MANCC
GROUP BY TENNCC
--7 Các nhà cung cấp cung cấp nhiều sản phẩm nhất
SELECT TENNCC FROM NHACUNGCAP, SANPHAM_NHACC
WHERE NHACUNGCAP.MANCC = SANPHAM_NHACC.MANCC
GROUP BY TENNCC
HAVING COUNT(SANPHAM_NHACC.MASP) >= ALL(
	SELECT COUNT(MASP) FROM NHACUNGCAP, SANPHAM_NHACC
	WHERE NHACUNGCAP.MANCC = SANPHAM_NHACC.MANCC
	GROUP BY TENNCC
)
--8 Khách hàng có số tích điểm nhiều nhất
SELECT TENKH, SUM(SODIEM) AS N'SỐ ĐIỂM' FROM KHACHHANG, PHIEUTICHDIEM
WHERE KHACHHANG.MAKH = PHIEUTICHDIEM.MAKH
GROUP BY TENKH
HAVING SUM(SODIEM) >= ALL (
	SELECT SUM(SODIEM) FROM PHIEUTICHDIEM, KHACHHANG
	WHERE  KHACHHANG.MAKH = PHIEUTICHDIEM.MAKH
	GROUP BY TENKH
)
--9 Ai là người không quản lý bất kỳ cửa hàng nào
SELECT HOTEN FROM QUANLY
WHERE MAQL NOT IN(
	SELECT distinct(MAQL) FROM CUAHANG
)
--10 Sản phẩm có giá bán cao nhất
SELECT * FROM SANPHAM
WHERE GIABAN >= ALL (
	SELECT GIABAN FROM SANPHAM
)
-- Thời gian khuyến mãi dài nhất
SELECT TENKM FROM KHUYENMAI
WHERE DATEDIFF(D,NGAYBD, NGAYKT) >= ALL (
	SELECT DATEDIFF(D,NGAYBD, NGAYKT) FROM KHUYENMAI
)


--2001216154 - Đặng Ngọc Nguyên Thảo

--------------------------------- TRUY VẤN ĐƠN GIẢN ---------------------------------
---1.Hóa đơn được lập vào tháng 05/2023.
SELECT *FROM HOADON
WHERE MONTH(NGAYLAP)=05 AND  YEAR(NGAYLAP)=2023
---2.Cho biết thông tin của nhân viên Lê Kim Anh
SELECT MANV,MAQL,NGAYSINH,DIACHI,SDT
FROM NHANVIEN
WHERE HOTEN='Lê Kim Anh'
---3.Cho biết tên quản lý của nhân viên có MANV là CH011
SELECT QUANLY.HOTEN
FROM QUANLY,NHANVIEN
WHERE QUANLY.MAQL=NHANVIEN.MAQL AND MANV='NV030'
---4.Cho biết thông tin chương trình khuyến mãi sản phẩm cocacola
SELECT TENKM,NGAYBD,NGAYKT
FROM KHUYENMAI,SANPHAM
WHERE KHUYENMAI.MASP=SANPHAM.MASP AND TENSP=N'Cocacola'
---5.Cho biết khách hàng có mã khách hàng KH007 đã tích được bao nhiêu điểm mua hàng.
SELECT SODIEM
FROM PHIEUTICHDIEM
WHERE MAKH='KH007'
--------------------------------- TRUY VẤN NÂNG CAO ---------------------------------
--6.tim ho ten kh da mua hoa don co tri gia cao nhat 
SELECT TENKH, TONGTIEN
FROM KHACHHANG K INNER JOIN HOADON H
ON K.MAKH=H.MAKH
AND MAHD=(SELECT MAHD
			FROM HOADON
			WHERE TONGTIEN = (SELECT MAX(TONGTIEN) 
								FROM HOADON))
---7.in ra mahd và trị giá hd trong tháng 05/2022 sắp xếp theo ngày tăng dầnvaf trị giá hóa đơn giảm dần
SELECT MAHD, TONGTIEN
FROM HOADON
WHERE MONTH(NGAYLAP)= 04 AND YEAR(NGAYLAP)= 2023
ORDER BY NGAYLAP ASC,TONGTIEN DESC 
---8.Cho biết danh sách những nhân viên (MANV,HOTEN) có trên 2 khách hàng---
 SELECT NHANVIEN.MANV, NHANVIEN.HOTEN,COUNT(*)   AS 'Số lượng khách hàng'
 FROM NHANVIEN,NHANVIEN_KHACHHANG NK
 WHERE NHANVIEN.MANV=NK.MANV
 GROUP BY NHANVIEN.MANV,NHANVIEN.HOTEN
 HAVING COUNT(NK.MANV) >=2
 ---9.Cho biết tên nhà cung cấp và ngày lập phiếu nhập của từng nhà cung cấp
SELECT N.TENNCC,P.NGAYLAP
FROM NHACUNGCAP N
INNER JOIN PHIEUNHAP P ON N.MAPN=P.MAPN
GROUP BY N.TENNCC,P.NGAYLAP
---10. cho biết những MÃ kho có ít nhất 2 quản lý
SELECT KHO.MAKHO
FROM KHO,QUANLY,QUANLY_KHO
WHERE KHO.MAKHO=QUANLY_KHO.MAKHO AND QUANLY.MAQL=QUANLY_KHO.MAQL
GROUP BY KHO.MAKHO
HAVING COUNT(*) >=2
GO
---------------------TV-----------------
ALTER TABLE KHACHHANG
ADD CONSTRAINT CHK_GIOITINH CHECK (PHAI=N'Nam' OR PHAI=N'Nữ')
ALTER TABLE SANPHAM
ADD CONSTRAINT UNI_TENSP UNIQUE (TENSP)
ALTER TABLE KHUYENMAI
ADD CONSTRAINT DF_THOIGIAN DEFAULT 'CHUA XAC DINH' FOR THOIGIAN
GO
--XÂY DỰNG TRIGGER KIỂM TRA RÀNG BUỘC KHÓA NGOẠI Ở BẢNG SANPHAM VỚI SANPHAM_NHACC
CREATE TRIGGER SANPHAM_INSERT
ON SANPHAM
FOR INSERT
AS
IF NOT EXISTS(SELECT * FROM SANPHAM_NHACC, INSERTED
			WHERE SANPHAM_NHACC.MaSP=INSERTED.MaSP)
BEGIN
			PRINT N'Mã SP không có trong danh mục'
			ROLLBACK TRANSACTION
END
INSERT INTO SANPHAM
VALUES('SP040', 'CH005', N'Pepsi', 10000, NULL)
SELECT *FROM SANPHAM




--2001210622 – Nguyễn Thị Thùy Dương

--------------------------------- TRUY VẤN ĐƠN GIẢN ---------------------------------

--1. Liệt kê những khách hàng nam và có họ Nguyễn
SELECT *
FROM KHACHHANG
WHERE GIOITINH=N'Nam' AND TENKH LIKE N'Nguyễn%'

--2. thông tin của khách hàng có mã KH005
SELECT *
FROM KHACHHANG
WHERE MAKH='KH005'

--3. Xuất những hóa đơn có tiền lớn hơn 300000
SELECT * 
FROM HOADON
WHERE TONGTIEN > 300000

--4. Xuất thông tin nhân viên ở quận Gò Vấp
SELECT *
FROM NHANVIEN
WHERE DIACHI LIKE N'%Gò Vấp%'

--5. cho biết họ tên nhân các viên sinh năm 2000
SELECT HOTEN
FROM NHANVIEN
WHERE YEAR(NGAYSINH)=2000
--------------------------------- TRUY VẤN NÂNG CAO ---------------------------------
--1. sắp xếp diện tích kho tăng dần
SELECT *
FROM KHO
ORDER BY DIENTICH ASC

--2. mã nhân viên và họ tên nhân viên phục vụ ít nhất 2 khách hàng
SELECT NHANVIEN.MANV, NHANVIEN.HOTEN
FROM NHANVIEN, NHANVIEN_KHACHHANG
WHERE NHANVIEN.MANV= NHANVIEN_KHACHHANG.MANV
GROUP BY NHANVIEN.MANV, NHANVIEN.HOTEN
HAVING COUNT(NHANVIEN_KHACHHANG.MANV) >= 2

--3. cho biết thông tin kho có diện tích lớn nhất
SELECT *
FROM KHO
WHERE DIENTICH = (SELECT MAX (DIENTICH) FROM KHO)

--4. liệt kê danh sách tên nhân viên và số lượng khách hàng của từng nhân viên
SELECT NHANVIEN.HOTEN, COUNT(*) AS'SỐ LƯỢNG KHÁCH HÀNG'
FROM NHANVIEN,NHANVIEN_KHACHHANG
WHERE NHANVIEN.MANV=NHANVIEN_KHACHHANG.MANV
GROUP BY NHANVIEN.HOTEN

--5. cho biết tên khách hàng và tổng tích điểm của khách hàng
SELECT KHACHHANG.TENKH,  SUM(PHIEUTICHDIEM.SODIEM) AS 'Tổng tích điểm'
FROM KHACHHANG, PHIEUTICHDIEM
WHERE KHACHHANG.MAKH = PHIEUTICHDIEM.MAKH
GROUP BY KHACHHANG.TENKH

--dùng Default Constraint viết ràng buộc giá trị mặc định cho SODIEM là 5
ALTER TABLE PHIEUTICHDIEM
ADD CONSTRAINT DF_SODIEM DEFAULT 5 FOR SODIEM

--dùng Unique Constraint viết ràng buộc kiểm tra duy nhất cho cột MAKH
ALTER TABLE KHACHHANG
ADD CONSTRAINT UNI_MAKH UNIQUE (MAKH)

--dùng Check Constraint viết ràng buộc miền giá trị cho DIENTICH
ALTER TABLE KHO
ADD CONSTRAINT CHK_DIENTICH CHECK (DIENTICH > 0)

--trigger kiểm tra khi nhập dữ liệu vào bảng HOADON thì TONGTIEN phải lớn hơn 0
GO
CREATE TRIGGER KT_TONGTIEN ON HOADON
FOR INSERT
AS
IF(SELECT TONGTIEN FROM INSERTED) > 0
	COMMIT TRANSACTION
ELSE
	BEGIN
		PRINT'TONG TIEN PHAI LON HON 0'
		ROLLBACK TRANSACTION
	END

INSERT INTO HOADON
VALUES ('HD059','KH009','11/02/2022',-900000)

--2001215933 - Lê Văn Lợi
--------------------------------- TRUY VẤN ĐƠN GIẢN ---------------------------------
--1.Lấy mã và tên sản phẩm có giá bán từ 50000 đồng đến 100000 đồng:
SELECT MASP, TENSP FROM SANPHAM WHERE GIABAN BETWEEN 50000 AND 100000;

--2.Lấy tên và ngày sinh của các nhân viên có mã quản lý là QL001:
SELECT HOTEN, NGAYSINH FROM NHANVIEN WHERE MAQL = 'QL001';

--3.Lấy tên của các nhà cung cấp có tên bắt đầu bằng chữ ‘D’:
SELECT TENNCC FROM NHACUNGCAP WHERE TENNCC LIKE 'D%';

--4.Lấy mã và tên sản phẩm có giá bán nhỏ hơn 10000 đồng:
SELECT MASP, TENSP FROM SANPHAM WHERE GIABAN < 10000;

--5.Lấy mã và tên khuyến mãi có thời gian bắt đầu từ ngày 01/05/2023:
SELECT MAKM, TENKM FROM KHUYENMAI WHERE NGAYBD >= '01/05/2023';

--------------------------------- TRUY VẤN NÂNG CAO ---------------------------------
--1.Lấy tên và số lượng nhân viên của các quản lý có số lượng nhân viên lớn hơn hoặc bằng 2:
SELECT QUANLY.HOTEN, COUNT(NHANVIEN.MANV) AS SONHANVIEN FROM QUANLY
JOIN NHANVIEN ON QUANLY.MAQL = NHANVIEN.MAQL
GROUP BY QUANLY.HOTEN
HAVING COUNT(NHANVIEN.MANV) >= 2;

--2.Lấy tên và số điểm của các khách hàng có số điểm cao nhất trong bảng PHIEUTICHDIEM:
SELECT KHACHHANG.TENKH, PHIEUTICHDIEM.SODIEM FROM KHACHHANG
JOIN PHIEUTICHDIEM ON KHACHHANG.MAKH = PHIEUTICHDIEM.MAKH
WHERE PHIEUTICHDIEM.SODIEM = (SELECT MAX(SODIEM) FROM PHIEUTICHDIEM);

--3.Lấy tên và số lượng nhân viên của các quản lý có số lượng nhân viên ít nhất trong bảng NHANVIEN:
SELECT QUANLY.HOTEN, COUNT(NHANVIEN.MANV) AS SONHANVIEN FROM QUANLY
JOIN NHANVIEN ON QUANLY.MAQL = NHANVIEN.MAQL
GROUP BY QUANLY.HOTEN
HAVING COUNT(NHANVIEN.MANV) = (SELECT MIN(SONV) FROM (SELECT COUNT(NHANVIEN.MANV) AS SONV FROM QUANLY
  JOIN NHANVIEN ON QUANLY.MAQL = NHANVIEN.MAQL
  GROUP BY QUANLY.HOTEN) AS MIN);

--4.Lấy tên và số lượng nhân viên của các quản lý có số lượng nhân viên nhiều nhất trong bảng NHANVIEN:
SELECT QUANLY.HOTEN, COUNT(NHANVIEN.MANV) AS SONHANVIEN FROM QUANLY
JOIN NHANVIEN ON QUANLY.MAQL = NHANVIEN.MAQL
GROUP BY QUANLY.HOTEN
HAVING COUNT(NHANVIEN.MANV) = (SELECT MAX(SONV) FROM (SELECT COUNT(NHANVIEN.MANV) AS SONV FROM QUANLY
  JOIN NHANVIEN ON QUANLY.MAQL = NHANVIEN.MAQL
  GROUP BY QUANLY.HOTEN) AS MAX);

--5.Lấy tên và số điểm của các khách hàng có số điểm lớn hơn hoặc bằng trung bình số điểm của tất cả các khách hàng:
SELECT KHACHHANG.TENKH, PHIEUTICHDIEM.SODIEM FROM KHACHHANG
JOIN PHIEUTICHDIEM ON KHACHHANG.MAKH = PHIEUTICHDIEM.MAKH
WHERE PHIEUTICHDIEM.SODIEM >= (SELECT AVG(SODIEM) FROM PHIEUTICHDIEM);

--Thêm ràng buộc Check Constraint cho cột NGAYSINH của bảng NHANVIEN phải nhỏ hơn ngày hiện tại:
ALTER TABLE NHANVIEN
ADD CONSTRAINT CHK_NGAYSINH CHECK (NGAYSINH < GETDATE());

--Thêm ràng buộc Unique Constraint cho cột TENKM của bảng KHUYENMAI:
ALTER TABLE KHUYENMAI
ADD CONSTRAINT UNQ_TENKM UNIQUE (TENKM);

--Thêm ràng buộc Default Constraint cho cột TONGTIEN của bảng HOADON với giá trị mặc định là 0:
ALTER TABLE HOADON
ADD CONSTRAINT DF_TONGTIEN DEFAULT 0 FOR TONGTIEN;


----Vũ văn minh 2001215963
--truy vấn cơ bản--
--1.tìm tên những khách hàng là nam
SELECT TENKH FROM KHACHHANG
WHERE GIOITINH = 'Nam'
--2.
SELECT TOP 3 TENSP FROM SANPHAM
--3.
SELECT * FROM SANPHAM
WHERE GIABAN > 20000
--4.
SELECT GIOITINH, COUNT(*) AS SO_LUONG FROM KHACHHANG
GROUP BY GIOITINH
--5.Tìm tất cả các hóa đơn được lập trong tháng 11 năm 2022:
SELECT * FROM HOADON WHERE YEAR(NGAYLAP) = 2022 AND MONTH(NGAYLAP) = 11;
-------------TRUY VAN NANG CAO-------------
--1.XUẤT NHỮNG KHÁCH CHI TRÊN 1 TRIỆU
SELECT KH. TENKH, SUM(HD. TONGTIEN) AS TONGTIEN FROM KHACHHANG KH
INNER JOIN HOADON HD ON KH.MAKH = HD. MAKH
GROUP BY KH. TENKH
HAVING SUM(HD. TONGTIEN) > 1000000
ORDER BY TONGTIEN DESC;
--2.XUẤT TỔNG TIỀN BÁN HÀNG CỦA MỖI THÁNG
SELECT MONTH(HD.NGAYLAP) AS 'Tháng', YEAR(HD.NGAYLAP) AS 'Năm', SUM(HD.TONGTIEN) AS TONGTIEN
FROM HOADON HD
GROUP BY MONTH (HD.NGAYLAP), YEAR (HD.NGAYLAP)
ORDER BY YEAR (HD.NGAYLAP),MONTH(HD.NGAYLAP)
--3.tim so san pham co trong moi cua hang
SELECT CUAHANG.MACH, COUNT(SANPHAM.MASP) AS SOSANPHAM 
FROM SANPHAM
RIGHT JOIN CUAHANG ON SANPHAM.MACH = CUAHANG.MACH
--4.tên khách hàng có ít nhất 1 hóa đơn
SELECT KHACHHANG. TENKH, COUNT (DISTINCT HOADON. MAHD) AS SOHOADON FROM KHACHHANG
JOIN HOADON ON KHACHHANG.MAKH = HOADON. MAKH 
GROUP BY KHACHHANG. TENKH HAVING COUNT (DISTINCT HOADON. MAHD) > 1;
--5.SỐ SẢN PHẨM KHÁC NHAU Ở MÔI CỬA HÀNG 
SELECT CUAHANG.TEN, COUNT(DISTINCT SANPHAM.MASP) AS SOSANPHAMKHACNH
FROM CUAHANG
JOIN SANPHAM ON CUAHANG.MACH = SANPHAM.MACH
GROUP BY CUAHANG.TEN

--UNIQUE
ALTER TABLE SANPHAM ADD CONSTRAINT UQ_MASP UNIQUE (MASP);
--DEFAULT
ALTER TABLE SANPHAM ADD CONSTRAINT DF_GIABAN DEFAULT 10000 FOR GIABAN;
--TRIGGER
GO
CREATE TRIGGER trg_dientich ON KHO FOR INSERT
AS
IF(SELECT DIENTICH FROM INSERTED) > 0
COMMIT TRANSACTION
BEGIN
PRINT'Vui long nhap lai'
ROLLBACK TRANSACTION
END

------- HẾT RỒI... BÁI BAI!!! :)