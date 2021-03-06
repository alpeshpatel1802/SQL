USE [master]
GO

/****** Object:  Database [SitaRamMobile]    Script Date: 12/07/2016 00:30:55 ******/
CREATE DATABASE [SitaRamMobile] ON  PRIMARY 
( NAME = N'SitaRamMobile', FILENAME = N'D:\SQLSetup\MSSQL10.MSSQLSERVER\MSSQL\DATA\SitaRamMobile.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SitaRamMobile_log', FILENAME = N'D:\SQLSetup\MSSQL10.MSSQLSERVER\MSSQL\DATA\SitaRamMobile_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [SitaRamMobile] SET COMPATIBILITY_LEVEL = 100
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SitaRamMobile].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [SitaRamMobile] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [SitaRamMobile] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [SitaRamMobile] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [SitaRamMobile] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [SitaRamMobile] SET ARITHABORT OFF 
GO

ALTER DATABASE [SitaRamMobile] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [SitaRamMobile] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [SitaRamMobile] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [SitaRamMobile] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [SitaRamMobile] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [SitaRamMobile] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [SitaRamMobile] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [SitaRamMobile] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [SitaRamMobile] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [SitaRamMobile] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [SitaRamMobile] SET  DISABLE_BROKER 
GO

ALTER DATABASE [SitaRamMobile] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [SitaRamMobile] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [SitaRamMobile] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [SitaRamMobile] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [SitaRamMobile] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [SitaRamMobile] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [SitaRamMobile] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [SitaRamMobile] SET  READ_WRITE 
GO

ALTER DATABASE [SitaRamMobile] SET RECOVERY FULL 
GO

ALTER DATABASE [SitaRamMobile] SET  MULTI_USER 
GO

ALTER DATABASE [SitaRamMobile] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [SitaRamMobile] SET DB_CHAINING OFF 
GO











USE [SitaRamMobile]
GO
/****** Object:  Table [dbo].[BankMaster]    Script Date: 12/07/2016 00:29:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BankMaster](
	[BankId] [int] IDENTITY(1,1) NOT NULL,
	[BankName] [nvarchar](500) NULL,
	[IFSC] [nvarchar](25) NULL,
	[IsActive] [bit] NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
 CONSTRAINT [PK_BankMaster] PRIMARY KEY CLUSTERED 
(
	[BankId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BankMaster] ON
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IFSC], [IsActive], [City], [State]) VALUES (1, N'Punjab National Bank-Katargam', N'PNB123', 1, N'Surat', N'Gujarat')
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IFSC], [IsActive], [City], [State]) VALUES (2, N'SBI Nanpura', N'SBI999', 1, N'Surat', N'Gujarat')
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IFSC], [IsActive], [City], [State]) VALUES (3, N'Yes bank - Juhu', N'YES789', 1, N'Mumbai', N'Maharastra')
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IFSC], [IsActive], [City], [State]) VALUES (4, N'ICICI bank - Movdi', N'ICI321', 1, N'Rajkot', N'Gujarat')
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IFSC], [IsActive], [City], [State]) VALUES (5, N'Yes bank - Udhna', N'YYY777', 0, N'Surat', N'Gujarat')
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IFSC], [IsActive], [City], [State]) VALUES (15, N'AAAAAAAAAAA', N'', 1, N'', N'')
SET IDENTITY_INSERT [dbo].[BankMaster] OFF
/****** Object:  StoredProcedure [dbo].[GetReport]    Script Date: 12/07/2016 00:29:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetReport]
@SearchString NVARCHAR(MAX)
AS
BEGIN
DECLARE @sQuery AS NVARCHAR(MAX) =''
	SET @sQuery = ' SELECT CustomerName, MobileNo, CONVERT(NVARCHAR(MAX), TransDate, 103) + '' '' + RIGHT(CONVERT(NVARCHAR(MAX), TransDate, 100),7)AS TransDate1,
			 BankName, IFSC, TransAmount, AccNumber, 
			CASE WHEN IsTransfered = 1 THEN ''Yes'' Else ''No'' END AS IsTransfered, TransactionId , comment
	FROM SitaRamMobile.dbo.TransEntry 
	LEFT OUTER JOIN BankMaster ON TransEntry.BankId = BankMaster.BankId
	WHERE ' + @SearchString + ' ORDER BY TransDate  '
	--print @sQuery
	EXECUTE (@sQuery)
END
GO
/****** Object:  Table [dbo].[TransEntry]    Script Date: 12/07/2016 00:29:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransEntry](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](200) NULL,
	[MobileNo] [nvarchar](30) NULL,
	[TransDate] [datetime] NULL,
	[BankId] [int] NULL,
	[TransAmount] [int] NULL,
	[AccNumber] [nvarchar](15) NULL,
	[IsTransfered] [bit] NULL,
	[TransactionId] [nvarchar](250) NULL,
	[Comment] [nvarchar](500) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_TransEntry] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TransEntry] ON
INSERT [dbo].[TransEntry] ([ID], [CustomerName], [MobileNo], [TransDate], [BankId], [TransAmount], [AccNumber], [IsTransfered], [TransactionId], [Comment], [CreatedDate], [UpdatedDate]) VALUES (2, N'Rajubhai Rameshbhai Ranpariya', N'9879198791', CAST(0x0000A6C9001855B0 AS DateTime), 4, 5500, N'1234567891234', 1, N'gggg', N'jama thai gaya chhe', CAST(0x0000A6C90018CBB7 AS DateTime), CAST(0x0000A6C9001CA736 AS DateTime))
INSERT [dbo].[TransEntry] ([ID], [CustomerName], [MobileNo], [TransDate], [BankId], [TransAmount], [AccNumber], [IsTransfered], [TransactionId], [Comment], [CreatedDate], [UpdatedDate]) VALUES (3, N'Shivaji Rao', N'7777777777777', CAST(0x0000A6CA00027D80 AS DateTime), 1, 4600, N'12345678912345', 1, N'7896544', N'hiiiiiii', CAST(0x0000A6CA0002B532 AS DateTime), CAST(0x0000A6CA0007098E AS DateTime))
INSERT [dbo].[TransEntry] ([ID], [CustomerName], [MobileNo], [TransDate], [BankId], [TransAmount], [AccNumber], [IsTransfered], [TransactionId], [Comment], [CreatedDate], [UpdatedDate]) VALUES (4, N'qqqqq', N'22222222', CAST(0x0000A6CA00043D28 AS DateTime), 3, 2230, N'2432432423423', 1, N'rgt3434343', N'hello', CAST(0x0000A6CA00046A7D AS DateTime), CAST(0x0000A6CA000719DF AS DateTime))
INSERT [dbo].[TransEntry] ([ID], [CustomerName], [MobileNo], [TransDate], [BankId], [TransAmount], [AccNumber], [IsTransfered], [TransactionId], [Comment], [CreatedDate], [UpdatedDate]) VALUES (5, N'alpesh', N'9879193430', CAST(0x0000A6CA00135024 AS DateTime), 1, 25000, N'576789', 1, N'333333333333', N'', CAST(0x0000A6CA0013CFC8 AS DateTime), CAST(0x0000A6CA00170684 AS DateTime))
INSERT [dbo].[TransEntry] ([ID], [CustomerName], [MobileNo], [TransDate], [BankId], [TransAmount], [AccNumber], [IsTransfered], [TransactionId], [Comment], [CreatedDate], [UpdatedDate]) VALUES (6, N'bbbbbbbbbbbbbbbb', N'44566778888888', CAST(0x0000A6CA001C55DB AS DateTime), 4, 25000, N'3333544454', 0, N'', N'hgg', CAST(0x0000A6CA001D5851 AS DateTime), NULL)
INSERT [dbo].[TransEntry] ([ID], [CustomerName], [MobileNo], [TransDate], [BankId], [TransAmount], [AccNumber], [IsTransfered], [TransactionId], [Comment], [CreatedDate], [UpdatedDate]) VALUES (7, N'Alpeshkumar Bhagavanjibhai Ajudiya', N'9879193430', CAST(0x0000A6CB00076818 AS DateTime), 4, 24500, N'223344556677', 1, N'7777777777777777777', N'DONE', CAST(0x0000A6CB0007C554 AS DateTime), CAST(0x0000A6CB01862370 AS DateTime))
INSERT [dbo].[TransEntry] ([ID], [CustomerName], [MobileNo], [TransDate], [BankId], [TransAmount], [AccNumber], [IsTransfered], [TransactionId], [Comment], [CreatedDate], [UpdatedDate]) VALUES (8, N'ZZZZZZZZZZZZZZZZZ', N'9871234567', CAST(0x0000A6CB000C0D8C AS DateTime), 2, 22000, N'453454335345', 1, N'1qqqqq', N'okay', CAST(0x0000A6CB000C40C2 AS DateTime), CAST(0x0000A6D1017F20BE AS DateTime))
INSERT [dbo].[TransEntry] ([ID], [CustomerName], [MobileNo], [TransDate], [BankId], [TransAmount], [AccNumber], [IsTransfered], [TransactionId], [Comment], [CreatedDate], [UpdatedDate]) VALUES (9, N'Rajendrabhai Rameshbhai Kakdiya', N'9825098250', CAST(0x0000A6CC00034710 AS DateTime), 4, 11000, N'359102569874', 1, N'464665315135131313131', N'hellllooooooooo', CAST(0x0000A6CC0003DF68 AS DateTime), CAST(0x0000A6CC00194F28 AS DateTime))
INSERT [dbo].[TransEntry] ([ID], [CustomerName], [MobileNo], [TransDate], [BankId], [TransAmount], [AccNumber], [IsTransfered], [TransactionId], [Comment], [CreatedDate], [UpdatedDate]) VALUES (10, N'Sachinbhai Rameshbhai Tendulkar', N'9876543210', CAST(0x0000A6CF01852068 AS DateTime), 3, 4694, N'123456789012', 1, N'55964464664', N'qqqqqqqqqqqq', CAST(0x0000A6CF0185605F AS DateTime), CAST(0x0000A6CF0186C890 AS DateTime))
INSERT [dbo].[TransEntry] ([ID], [CustomerName], [MobileNo], [TransDate], [BankId], [TransAmount], [AccNumber], [IsTransfered], [TransactionId], [Comment], [CreatedDate], [UpdatedDate]) VALUES (11, N'Rajshekhar Azad', N'7878787878', CAST(0x0000A6D000066648 AS DateTime), 3, 3600, N'454545454545', 1, N'846848464886', N'646846866646846846', CAST(0x0000A6D00006BEB4 AS DateTime), CAST(0x0000A6D00006FF14 AS DateTime))
SET IDENTITY_INSERT [dbo].[TransEntry] OFF
/****** Object:  StoredProcedure [dbo].[UpdateTransEntry]    Script Date: 12/07/2016 00:29:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateTransEntry]
@Id int,
@CustomerName nvarchar(200),
@MobileNo nvarchar(30),
@TransDate datetime,
@BankId int,
@TransAmount INT,
@AccNumber nvarchar(15),
@IsTransfered bit,
@TransactionId nvarchar(250),
@Comment nvarchar(500)
AS
BEGIN
UPDATE [SitaRamMobile].[dbo].[TransEntry]
           SET [CustomerName] = @CustomerName
			 ,[MobileNo] = @MobileNo
		     ,[TransDate] = @TransDate
		    ,[BankId] = @BankId
			,[TransAmount] = @TransAmount
			,[AccNumber] = @AccNumber
			,[IsTransfered] = @IsTransfered
			,[TransactionId] = @TransactionId
			,[Comment] = @Comment
			,[UpdatedDate] = GETDATE()
		WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateBankMaster]    Script Date: 12/07/2016 00:29:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateBankMaster]
@BankId int,
@BankName nvarchar(500),
@IFSC nvarchar(25),
@IsActive bit,
@City nvarchar(50),
@State nvarchar(50)
AS
BEGIN
UPDATE [SitaRamMobile].[dbo].[BankMaster]
           SET [BankName] =@BankName
           ,[IFSC] = @IFSC
           ,[IsActive] = @IsActive
           ,[City] =@City
           ,[State] = @State
     WHERE BankId = @BankId

END
GO
/****** Object:  StoredProcedure [dbo].[InsertTransEntry]    Script Date: 12/07/2016 00:29:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertTransEntry]
@CustomerName nvarchar(200),
@MobileNo nvarchar(30),
@TransDate datetime,
@BankId int,
@TransAmount INT,
@AccNumber nvarchar(15),
@IsTransfered bit,
@TransactionId nvarchar(250),
@Comment nvarchar(500)


AS
BEGIN
INSERT INTO [SitaRamMobile].[dbo].[TransEntry]
             ([CustomerName]
			 ,[MobileNo]
		     ,[TransDate]
		    ,[BankId]
			,[TransAmount]
			,[AccNumber]
			,[IsTransfered]
			,[TransactionId]
			,[Comment]
			,[CreatedDate]
			,[UpdatedDate])
     VALUES
           (@CustomerName
           ,@MobileNo
           ,@TransDate
           ,@BankId
           ,@TransAmount
           ,@AccNumber
           ,@IsTransfered
           ,@TransactionId
           ,@Comment
           ,GETDATE()
           ,null)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertBankMaster]    Script Date: 12/07/2016 00:29:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertBankMaster]
@BankName nvarchar(500),
@IFSC nvarchar(25),
@IsActive bit,
@City nvarchar(50),
@State nvarchar(50)
AS
BEGIN
INSERT INTO [SitaRamMobile].[dbo].[BankMaster]
           ([BankName]
           ,[IFSC]
           ,[IsActive]
           ,[City]
           ,[State])
     VALUES
           (@BankName
           ,@IFSC
           ,@IsActive
           ,@City
           ,@State)

END
GO
/****** Object:  StoredProcedure [dbo].[GetTransEntryByDate]    Script Date: 12/07/2016 00:29:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTransEntryByDate]
@Date DATE
AS
BEGIN
	SELECT ID, CustomerName, MobileNo, CONVERT(NVARCHAR(MAX), TransDate, 103) + ' ' + RIGHT(CONVERT(NVARCHAR(MAX), TransDate, 100),7)AS TransDate1, 
	        BankName, TransAmount, AccNumber, 
			CASE WHEN IsTransfered = 1 THEN 'Yes' Else 'No' END AS IsTransfered, TransactionId, comment 
	FROM SitaRamMobile.dbo.TransEntry 
	LEFT OUTER JOIN BankMaster ON TransEntry.BankId = BankMaster.BankId
	WHERE DAY(TransDate) = DAY(@Date) AND MONTH(TransDate) = MONTH(@Date) AND YEAR(TransDate) = YEAR(@Date) 
	ORDER BY TransDate
END
GO
/****** Object:  StoredProcedure [dbo].[GetTransEntry]    Script Date: 12/07/2016 00:29:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTransEntry]
@Id int
AS
BEGIN
IF @Id = 0 
BEGIN
	SELECT ID, CustomerName, MobileNo, TransDate, BankName, TransAmount, AccNumber, 
			CASE WHEN IsTransfered = 1 THEN 'Yes' Else 'No' END AS IsTransfered, TransactionId 
	FROM SitaRamMobile.dbo.TransEntry 
	LEFT OUTER JOIN BankMaster ON TransEntry.BankId = BankMaster.BankId
	ORDER BY TransDate
END
ELSE
BEGIN
	SELECT ID, CustomerName, MobileNo, TransDate, BankId, TransAmount, AccNumber, 
			CASE WHEN IsTransfered = 1 THEN 'Yes' Else 'No' END AS IsTransfered, TransactionId, Comment, 
			CreatedDate,UpdatedDate
	FROM SitaRamMobile.dbo.TransEntry
	WHERE Id = @Id
END
END
GO
/****** Object:  StoredProcedure [dbo].[GetIFSC]    Script Date: 12/07/2016 00:29:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetIFSC]
@BankId int
AS
IF @BankId > 0 
BEGIN
	SELECT ISNULL(IFSC,'') IFSC
	  FROM SitaRamMobile.dbo.BankMaster 
	WHERE BankId = @BankId
END
ELSE
BEGIN
	SELECT ''
END
GO
/****** Object:  StoredProcedure [dbo].[GetBankMaster]    Script Date: 12/07/2016 00:29:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBankMaster]
@BankId int
AS
BEGIN
IF @BankId = 0 
BEGIN
	SELECT BankId, BankName, IFSC, CASE WHEN IsActive = 1 THEN 'Yes' Else 'No' END AS IsActive, City, State
	  FROM SitaRamMobile.dbo.BankMaster ORDER BY BankName
END
ELSE
BEGIN
	DECLARE @CanDelete AS BIT = 1
	
	IF EXISTS(SELECT * FROM TransEntry WHERE BankId = @BankId) 
	BEGIN
		SET @CanDelete = 0
	END
	
	SELECT BankId, BankName, IFSC, CASE WHEN IsActive = 1 THEN 'Yes' Else 'No' END AS IsActive, City, State, @CanDelete AS CanDelete
	  FROM SitaRamMobile.dbo.BankMaster
	WHERE BankId = @BankId ORDER BY BankName
END
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllBanks]    Script Date: 12/07/2016 00:29:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllBanks]
AS
BEGIN
	SELECT BankId, BankName, ISNULL(IFSC, '') AS IFSC
	  FROM SitaRamMobile.dbo.BankMaster 
	ORDER BY BankName
END
GO
/****** Object:  StoredProcedure [dbo].[GetActiveBanks]    Script Date: 12/07/2016 00:29:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetActiveBanks]
AS
BEGIN
	SELECT BankId, BankName, ISNULL(IFSC, '') AS IFSC
	  FROM SitaRamMobile.dbo.BankMaster 
	WHERE IsActive = 1	
	ORDER BY BankName
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteTransEntry]    Script Date: 12/07/2016 00:29:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteTransEntry]
@Id int
AS
BEGIN
DELETE FROM TransEntry WHERE Id = @Id

END
GO
/****** Object:  StoredProcedure [dbo].[DeleteBankMaster]    Script Date: 12/07/2016 00:29:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteBankMaster]
@BankId int
AS
BEGIN
DELETE FROM BankMaster WHERE BankId = @BankId

END
GO
/****** Object:  StoredProcedure [dbo].[CheckBankName]    Script Date: 12/07/2016 00:29:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckBankName]
@BankId int,
@BankName nvarchar(500)
AS
BEGIN
IF @BankId = 0 
BEGIN
	IF EXISTS(SELECT BankName FROM SitaRamMobile.dbo.BankMaster WHERE BankName = @BankName)
	BEGIN
		SELECT 1;
	END
	ELSE
	BEGIN
		SELECT 0;
	END
END
ELSE
BEGIN
	IF EXISTS(SELECT BankName FROM SitaRamMobile.dbo.BankMaster WHERE BankName = @BankName AND BankId <> @BankId)
	BEGIN
		SELECT 1;
	END
	ELSE
	BEGIN
		SELECT 0;
	END
END
END
GO
