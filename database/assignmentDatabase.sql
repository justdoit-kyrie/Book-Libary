USE [master]
GO
/****** Object:  Database [assignmentDatabase]    Script Date: 11/07/2021 9:04:04 CH ******/
CREATE DATABASE [assignmentDatabase]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'assignmentDatabase', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\assignmentDatabase.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'assignmentDatabase_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\assignmentDatabase_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [assignmentDatabase] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [assignmentDatabase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [assignmentDatabase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [assignmentDatabase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [assignmentDatabase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [assignmentDatabase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [assignmentDatabase] SET ARITHABORT OFF 
GO
ALTER DATABASE [assignmentDatabase] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [assignmentDatabase] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [assignmentDatabase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [assignmentDatabase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [assignmentDatabase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [assignmentDatabase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [assignmentDatabase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [assignmentDatabase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [assignmentDatabase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [assignmentDatabase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [assignmentDatabase] SET  DISABLE_BROKER 
GO
ALTER DATABASE [assignmentDatabase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [assignmentDatabase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [assignmentDatabase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [assignmentDatabase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [assignmentDatabase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [assignmentDatabase] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [assignmentDatabase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [assignmentDatabase] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [assignmentDatabase] SET  MULTI_USER 
GO
ALTER DATABASE [assignmentDatabase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [assignmentDatabase] SET DB_CHAINING OFF 
GO
ALTER DATABASE [assignmentDatabase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [assignmentDatabase] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [assignmentDatabase]
GO
/****** Object:  Table [dbo].[tblCategory]    Script Date: 11/07/2021 9:04:04 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategory](
	[categoryID] [nvarchar](20) NOT NULL,
	[name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblorder]    Script Date: 11/07/2021 9:04:04 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblorder](
	[orderID] [uniqueidentifier] NOT NULL CONSTRAINT [DF__tblorder__orderI__1A14E395]  DEFAULT (newid()),
	[userID] [nvarchar](30) NOT NULL,
	[date] [date] NULL,
	[total] [float] NULL,
	[paymentStatus] [nvarchar](20) NULL,
	[statusID] [nvarchar](20) NULL,
 CONSTRAINT [PK__tblorder__0809337D2149A3D4] PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblOrderDetail]    Script Date: 11/07/2021 9:04:04 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrderDetail](
	[detailID] [int] IDENTITY(1,1) NOT NULL,
	[orderID] [uniqueidentifier] NOT NULL,
	[productID] [nvarchar](50) NOT NULL,
	[quantity] [int] NULL,
	[price] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[detailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblProduct]    Script Date: 11/07/2021 9:04:04 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProduct](
	[productID] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NULL,
	[price] [float] NULL,
	[quantity] [int] NULL,
	[categoryID] [nvarchar](20) NOT NULL,
	[statusID] [nvarchar](20) NULL,
	[image] [nvarchar](200) NULL,
 CONSTRAINT [PK__tblProdu__2D10D14A115935D9] PRIMARY KEY CLUSTERED 
(
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblRoles]    Script Date: 11/07/2021 9:04:04 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRoles](
	[roleID] [nvarchar](10) NOT NULL,
	[name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblStatus]    Script Date: 11/07/2021 9:04:04 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblStatus](
	[statusID] [nvarchar](20) NOT NULL,
	[statusName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[statusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblusers]    Script Date: 11/07/2021 9:04:04 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblusers](
	[userID] [nvarchar](30) NOT NULL,
	[name] [nvarchar](50) NULL,
	[address] [nvarchar](50) NULL,
	[roleID] [nvarchar](10) NOT NULL,
	[password] [nvarchar](50) NULL,
	[statusID] [nvarchar](20) NULL,
 CONSTRAINT [PK__tblusers__CB9A1CDF7D6998E3] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[tblCategory] ([categoryID], [name]) VALUES (N'AI', N'Artificial intelligence')
INSERT [dbo].[tblCategory] ([categoryID], [name]) VALUES (N'KT', N'Quản lí dự án')
INSERT [dbo].[tblCategory] ([categoryID], [name]) VALUES (N'NN', N'Ngoại Ngữ')
INSERT [dbo].[tblCategory] ([categoryID], [name]) VALUES (N'orthers', N'Orthers')
INSERT [dbo].[tblCategory] ([categoryID], [name]) VALUES (N'SE', N'Sofeware Engineering')
INSERT [dbo].[tblorder] ([orderID], [userID], [date], [total], [paymentStatus], [statusID]) VALUES (N'67dc1e20-73a6-4ed8-b6a8-13e0a34f8c2f', N'se151120', CAST(N'2021-07-09' AS Date), 30, N'COD', N'active')
SET IDENTITY_INSERT [dbo].[tblOrderDetail] ON 

INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (1, N'67dc1e20-73a6-4ed8-b6a8-13e0a34f8c2f', N'ENG', 2, 15)
SET IDENTITY_INSERT [dbo].[tblOrderDetail] OFF
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [statusID], [image]) VALUES (N'DLF', N'Deep learning', 30, 5, N'AI', N'active', N'https://images-na.ssl-images-amazon.com/images/I/51uER7SOptL.jpg')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [statusID], [image]) VALUES (N'ENG', N'English Language', 15, 48, N'NN', N'active', N'https://images.routledge.com/common/jackets/crclarge/978113810/9781138103061.jpg')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [statusID], [image]) VALUES (N'FRANCE', N'France Language', 15, 10, N'NN', N'active', N'https://images-na.ssl-images-amazon.com/images/I/5171G9P7VGL._SX329_BO1,204,203,200_.jpg')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [statusID], [image]) VALUES (N'HDH', N'
operating system', 10, 10, N'SE', N'active', N'https://techknowledgebooks.com/wp-content/uploads/2019/09/Operating-SystemPO55B-400x516.jpg')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [statusID], [image]) VALUES (N'JPD201', N'Japanese Book', 20, 20, N'NN', N'active', N'https://dynamic.indigoimages.ca/books/4805312270.jpg?scaleup=true&width=614&maxheight=614&quality=85&lang=en')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [statusID], [image]) VALUES (N'Op', N'One piece (500 quiz book)', 5, 50, N'orthers', N'deactive', N'https://cdn0.fahasa.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/o/n/one_piece_500_quiz_book_tap_1_1.jpg')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [statusID], [image]) VALUES (N'PM', N'Project Manager', 25, 30, N'KT', N'active', N'https://images-na.ssl-images-amazon.com/images/I/512eFqtsqtL._SX258_BO1,204,203,200_.jpg')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [statusID], [image]) VALUES (N'PML', N'Python Machine Learning', 25, 10, N'AI', N'active', N'https://images-na.ssl-images-amazon.com/images/I/71PCVqFXvgL.jpg')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [statusID], [image]) VALUES (N'PRO', N'Object-Oriented Software Engineering', 20, 10, N'SE', N'active', N'https://www.site.uottawa.ca/school/research/lloseng/llbookcover-large.jpg')
INSERT [dbo].[tblRoles] ([roleID], [name]) VALUES (N'AD', N'Admin')
INSERT [dbo].[tblRoles] ([roleID], [name]) VALUES (N'QL', N'Orthers')
INSERT [dbo].[tblRoles] ([roleID], [name]) VALUES (N'US', N'User')
INSERT [dbo].[tblStatus] ([statusID], [statusName]) VALUES (N'active', N'Active available')
INSERT [dbo].[tblStatus] ([statusID], [statusName]) VALUES (N'deactive', N'Deactive available')
INSERT [dbo].[tblusers] ([userID], [name], [address], [roleID], [password], [statusID]) VALUES (N'101236414735927876403', N'hunter170701@gmail.com', N'', N'US', N'', N'active')
INSERT [dbo].[tblusers] ([userID], [name], [address], [roleID], [password], [statusID]) VALUES (N'101355691675370465340', N'ducndmse151198@gmail.com', N'', N'US', N'', N'active')
INSERT [dbo].[tblusers] ([userID], [name], [address], [roleID], [password], [statusID]) VALUES (N'107229834610998382680', N'ducndmse151198@fpt.edu.vn', N'', N'US', N'', N'active')
INSERT [dbo].[tblusers] ([userID], [name], [address], [roleID], [password], [statusID]) VALUES (N'admin', N'tui là admin', N'A14 Tô Ký, P. Trung Mỹ Tây, Q12', N'AD', N'c4ca4238a0b923820dcc509a6f75849b', N'active')
INSERT [dbo].[tblusers] ([userID], [name], [address], [roleID], [password], [statusID]) VALUES (N'LinhBN', N'bui nhat linh', N'89/2c Le Van Khuong, P. Hiep Thanh, Q12', N'QL', N'c4ca4238a0b923820dcc509a6f75849b', N'active')
INSERT [dbo].[tblusers] ([userID], [name], [address], [roleID], [password], [statusID]) VALUES (N'SE151120', N'Uy Dung', N'243/2/44 Chu Van An P.12, Q. Binh Thanh', N'US', N'c4ca4238a0b923820dcc509a6f75849b', N'active')
INSERT [dbo].[tblusers] ([userID], [name], [address], [roleID], [password], [statusID]) VALUES (N'SE151198', N'Minh Đức', N'529 Tô Ký, P. Trung Mỹ Tây, Q12', N'US', N'c4ca4238a0b923820dcc509a6f75849b', N'deactive')
ALTER TABLE [dbo].[tblorder]  WITH CHECK ADD FOREIGN KEY([statusID])
REFERENCES [dbo].[tblStatus] ([statusID])
GO
ALTER TABLE [dbo].[tblorder]  WITH CHECK ADD FOREIGN KEY([statusID])
REFERENCES [dbo].[tblStatus] ([statusID])
GO
ALTER TABLE [dbo].[tblorder]  WITH CHECK ADD  CONSTRAINT [FK__tblorder__userID__1B0907CE] FOREIGN KEY([userID])
REFERENCES [dbo].[tblusers] ([userID])
GO
ALTER TABLE [dbo].[tblorder] CHECK CONSTRAINT [FK__tblorder__userID__1B0907CE]
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK__tblOrderD__produ__22AA2996] FOREIGN KEY([productID])
REFERENCES [dbo].[tblProduct] ([productID])
GO
ALTER TABLE [dbo].[tblOrderDetail] CHECK CONSTRAINT [FK__tblOrderD__produ__22AA2996]
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK__tblOrderD__quant__21B6055D] FOREIGN KEY([orderID])
REFERENCES [dbo].[tblorder] ([orderID])
GO
ALTER TABLE [dbo].[tblOrderDetail] CHECK CONSTRAINT [FK__tblOrderD__quant__21B6055D]
GO
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD  CONSTRAINT [FK__tblProduc__catag__173876EA] FOREIGN KEY([categoryID])
REFERENCES [dbo].[tblCategory] ([categoryID])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK__tblProduc__catag__173876EA]
GO
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD  CONSTRAINT [FK__tblProduc__statu__4CA06362] FOREIGN KEY([statusID])
REFERENCES [dbo].[tblStatus] ([statusID])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK__tblProduc__statu__4CA06362]
GO
ALTER TABLE [dbo].[tblusers]  WITH CHECK ADD  CONSTRAINT [FK__tblusers__passwo__145C0A3F] FOREIGN KEY([roleID])
REFERENCES [dbo].[tblRoles] ([roleID])
GO
ALTER TABLE [dbo].[tblusers] CHECK CONSTRAINT [FK__tblusers__passwo__145C0A3F]
GO
ALTER TABLE [dbo].[tblusers]  WITH CHECK ADD FOREIGN KEY([statusID])
REFERENCES [dbo].[tblStatus] ([statusID])
GO
ALTER TABLE [dbo].[tblusers]  WITH CHECK ADD FOREIGN KEY([statusID])
REFERENCES [dbo].[tblStatus] ([statusID])
GO
USE [master]
GO
ALTER DATABASE [assignmentDatabase] SET  READ_WRITE 
GO
