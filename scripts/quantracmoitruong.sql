USE [master]
GO
/****** Object:  Database [quantracmoitruong]    Script Date: 12/23/2019 1:46:27 PM ******/
CREATE DATABASE [quantracmoitruong]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'quantracmoitruong', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.QUANTRACSERVER\MSSQL\DATA\quantracmoitruong.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'quantracmoitruong_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.QUANTRACSERVER\MSSQL\DATA\quantracmoitruong_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [quantracmoitruong] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [quantracmoitruong].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [quantracmoitruong] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [quantracmoitruong] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [quantracmoitruong] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [quantracmoitruong] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [quantracmoitruong] SET ARITHABORT OFF 
GO
ALTER DATABASE [quantracmoitruong] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [quantracmoitruong] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [quantracmoitruong] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [quantracmoitruong] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [quantracmoitruong] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [quantracmoitruong] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [quantracmoitruong] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [quantracmoitruong] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [quantracmoitruong] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [quantracmoitruong] SET  DISABLE_BROKER 
GO
ALTER DATABASE [quantracmoitruong] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [quantracmoitruong] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [quantracmoitruong] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [quantracmoitruong] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [quantracmoitruong] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [quantracmoitruong] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [quantracmoitruong] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [quantracmoitruong] SET RECOVERY FULL 
GO
ALTER DATABASE [quantracmoitruong] SET  MULTI_USER 
GO
ALTER DATABASE [quantracmoitruong] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [quantracmoitruong] SET DB_CHAINING OFF 
GO
ALTER DATABASE [quantracmoitruong] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [quantracmoitruong] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [quantracmoitruong] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'quantracmoitruong', N'ON'
GO
ALTER DATABASE [quantracmoitruong] SET QUERY_STORE = OFF
GO
USE [quantracmoitruong]
GO
/****** Object:  User [admin]    Script Date: 12/23/2019 1:46:27 PM ******/
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [admin]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [admin]
GO
ALTER ROLE [db_datareader] ADD MEMBER [admin]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [admin]
GO
/****** Object:  Table [dbo].[alert_history]    Script Date: 12/23/2019 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[alert_history](
	[id] [nvarchar](20) NOT NULL,
	[id_station] [nvarchar](255) NOT NULL,
	[alert_type] [smallint] NOT NULL,
	[alert_at] [datetime2](3) NOT NULL,
	[indicator] [nvarchar](20) NULL,
	[value] [int] NULL,
	[unit] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_group_permission]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_group_permission](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[group_id] [nvarchar](255) NOT NULL,
	[permission_id] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_permission]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_permission](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[code_name] [nvarchar](255) NOT NULL,
	[description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_roles]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[display_name] [nvarchar](255) NULL,
	[description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_stations_user_permission]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_stations_user_permission](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[station_id] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_tokens]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_tokens](
	[token] [nvarchar](20) NOT NULL,
	[created_at] [datetime2](3) NOT NULL,
	[type] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_user_access_tokens]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_user_access_tokens](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[token] [nvarchar](20) NOT NULL,
	[user_id] [int] NOT NULL,
	[description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_user_permission]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_user_permission](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[permission_id] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_user_role]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_user_role](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[group_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_users]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_users](
	[id] [nvarchar](20) NOT NULL,
	[username] [nvarchar](255) NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[password] [nvarchar](255) NOT NULL,
	[email_verified_at] [datetime2](3) NULL,
	[alert_email] [nvarchar](255) NOT NULL,
	[phone] [nvarchar](20) NOT NULL,
	[workplace] [nvarchar](255) NOT NULL,
	[position] [nvarchar](255) NOT NULL,
	[role_key] [nvarchar](64) NOT NULL,
	[id_stations] [nvarchar](64) NOT NULL,
	[created_at] [datetime2](3) NOT NULL,
	[updated_at] [datetime2](3) NOT NULL,
	[deleted_at] [datetime2](3) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[firmwares]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[firmwares](
	[id] [nvarchar](20) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[version] [nvarchar](50) NOT NULL,
	[firmware_date] [datetime2](3) NOT NULL,
	[status] [smallint] NULL,
	[url] [nvarchar](100) NOT NULL,
	[created_at] [datetime2](3) NOT NULL,
	[updated_at] [datetime2](3) NULL,
	[deleted_at] [datetime2](3) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[indicator_threshold]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[indicator_threshold](
	[id] [nvarchar](20) NOT NULL,
	[monitoringType] [nvarchar](20) NOT NULL,
	[indicatorId] [nvarchar](20) NOT NULL,
	[monitoringGroupId] [nvarchar](20) NOT NULL,
	[upperLimit] [nvarchar](20) NOT NULL,
	[lowerLimit] [nvarchar](20) NOT NULL,
	[hourLimit] [nvarchar](20) NULL,
	[safetyDescription] [nvarchar](max) NULL,
	[overThresholdDescription] [nvarchar](max) NULL,
 CONSTRAINT [PK__indicato__3213E83F7CCDA624] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[indicators]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[indicators](
	[id] [nvarchar](20) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[monitoringType] [nvarchar](20) NOT NULL,
	[symbol] [nvarchar](255) NOT NULL,
	[unit] [nvarchar](255) NULL,
	[description] [nvarchar](max) NULL,
 CONSTRAINT [PK__indicato__3213E83FAFB1FEF9] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[monitoring_data]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[monitoring_data](
	[id] [nvarchar](20) NOT NULL,
	[idData] [nvarchar](20) NOT NULL,
	[indicator] [nvarchar](20) NOT NULL,
	[value] [float] NOT NULL,
	[unit] [nvarchar](20) NOT NULL,
	[sensorStatus] [nvarchar](2) NOT NULL,
	[createdAt] [datetime2](3) NULL,
	[updatedAt] [datetime2](3) NULL,
	[deletedAt] [datetime2](3) NULL,
 CONSTRAINT [PK__monitori__3213E83FBF5CA729] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[monitoring_data_info]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[monitoring_data_info](
	[id] [nvarchar](20) NOT NULL,
	[stationId] [nvarchar](255) NULL,
	[location] [nvarchar](60) NULL,
	[battery] [int] NULL,
	[monitoringContent] [nvarchar](1024) NOT NULL,
	[sentAt] [datetime2](3) NOT NULL,
	[createdAt] [datetime2](3) NULL,
	[updatedAt] [datetime2](3) NULL,
	[deletedAt] [datetime2](3) NULL,
	[isFtpdata] [smallint] NOT NULL,
 CONSTRAINT [PK__monitori__3213E83FAC275017] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[monitoring_groups]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[monitoring_groups](
	[id] [nvarchar](20) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[monitoringType] [nvarchar](20) NOT NULL,
	[symbol] [nvarchar](255) NOT NULL,
	[description] [nvarchar](max) NULL,
	[createdAt] [datetime2](3) NULL,
	[updatedAt] [datetime2](3) NULL,
	[deletedAt] [datetime2](3) NULL,
 CONSTRAINT [PK__monitori__3213E83FDB7617FA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[monitoring_types]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[monitoring_types](
	[id] [nvarchar](20) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[symbol] [nvarchar](255) NOT NULL,
	[description] [nvarchar](max) NULL,
	[created_at] [datetime2](3) NOT NULL,
	[updated_at] [datetime2](3) NULL,
	[deleted_at] [datetime2](3) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sample_history]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sample_history](
	[id] [nvarchar](20) NOT NULL,
	[id_station] [nvarchar](255) NOT NULL,
	[sample_at] [datetime2](3) NOT NULL,
	[id_user] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[station_cameras]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[station_cameras](
	[id] [nvarchar](20) NOT NULL,
	[stationId] [nvarchar](20) NULL,
	[name] [nvarchar](50) NULL,
	[host] [nvarchar](100) NULL,
	[port] [nvarchar](10) NULL,
	[camUser] [nvarchar](50) NULL,
	[camPass] [nvarchar](255) NULL,
	[rtspLink] [text] NULL,
	[details] [text] NULL,
	[mode] [nvarchar](50) NULL,
	[createdAt] [datetime2](3) NULL,
	[updatedAt] [datetime2](3) NULL,
	[deletedAt] [datetime2](3) NULL,
 CONSTRAINT [PK__station___3213E83F48C9355B] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[station_followers]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[station_followers](
	[id] [nvarchar](20) NOT NULL,
	[id_user] [nvarchar](20) NOT NULL,
	[id_station] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[station_groups]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[station_groups](
	[id] [nvarchar](20) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[symbol] [nvarchar](255) NOT NULL,
	[description] [nvarchar](max) NULL,
	[created_at] [datetime2](3) NOT NULL,
	[updated_at] [datetime2](3) NULL,
	[deleted_at] [datetime2](3) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[station_indicators]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[station_indicators](
	[id] [nvarchar](20) NOT NULL,
	[idStation] [nvarchar](20) NOT NULL,
	[idIndicator] [nvarchar](20) NOT NULL,
	[status] [nvarchar](20) NULL,
	[createdAt] [datetime2](3) NULL,
	[updatedAt] [datetime2](3) NULL,
	[deletedAt] [datetime2](3) NULL,
 CONSTRAINT [PK__station___3213E83F32A52C88] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stations]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stations](
	[id] [nvarchar](20) NOT NULL,
	[monitoringType] [nvarchar](20) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[monitoringGroupId] [nvarchar](20) NOT NULL,
	[symbol] [nvarchar](255) NOT NULL,
	[address] [nvarchar](255) NOT NULL,
	[phone] [nvarchar](20) NOT NULL,
	[image] [nvarchar](100) NULL,
	[rootLocation] [nvarchar](255) NULL,
	[lastedLocation] [nvarchar](255) NULL,
	[updateLocationStatus] [smallint] NULL,
	[installedAt] [datetime2](3) NULL,
	[verifiedAt] [datetime2](3) NULL,
	[verificationOrganization] [nvarchar](255) NULL,
	[emittedFrequency] [int] NULL,
	[ftpFolder] [nvarchar](255) NULL,
	[ftpFilename] [nvarchar](255) NULL,
	[latestSentAt] [datetime2](3) NULL,
	[sendftpStatus] [smallint] NULL,
	[receiveftpStatus] [smallint] NULL,
	[lastedIndicatorOverThreshold] [nvarchar](20) NULL,
	[numberOfThreshold] [int] NULL,
	[numberOfAlertThreshold] [int] NULL,
	[alertThresholdStatus] [smallint] NULL,
	[numberOfAlertStructure] [int] NULL,
	[alertStructureStatus] [smallint] NULL,
	[numberOfDisconnection] [int] NULL,
	[alertDisconnectionStatus] [smallint] NULL,
	[battery] [int] NULL,
	[activityStatus] [smallint] NULL,
	[publicStatus] [smallint] NULL,
	[createdAt] [datetime2](3) NULL,
	[updatedAt] [datetime2](3) NULL,
	[deletedAt] [datetime2](3) NULL,
 CONSTRAINT [PK__stations__3213E83F52074B1F] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[systems]    Script Date: 12/23/2019 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[systems](
	[id] [nvarchar](20) NOT NULL,
	[idSystem] [nvarchar](255) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[value] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[monitoring_data]  WITH CHECK ADD  CONSTRAINT [FK_monitoring_data_monitoring_data] FOREIGN KEY([idData])
REFERENCES [dbo].[monitoring_data_info] ([id])
GO
ALTER TABLE [dbo].[monitoring_data] CHECK CONSTRAINT [FK_monitoring_data_monitoring_data]
GO
ALTER TABLE [dbo].[stations]  WITH CHECK ADD  CONSTRAINT [FK_stations_stations] FOREIGN KEY([id])
REFERENCES [dbo].[stations] ([id])
GO
ALTER TABLE [dbo].[stations] CHECK CONSTRAINT [FK_stations_stations]
GO
ALTER TABLE [dbo].[alert_history]  WITH CHECK ADD CHECK  (([value]>(0)))
GO
ALTER TABLE [dbo].[monitoring_data]  WITH CHECK ADD  CONSTRAINT [CK__monitorin__value__5AEE82B9] CHECK  (([value]>(0)))
GO
ALTER TABLE [dbo].[monitoring_data] CHECK CONSTRAINT [CK__monitorin__value__5AEE82B9]
GO
ALTER TABLE [dbo].[monitoring_data_info]  WITH CHECK ADD  CONSTRAINT [CK__monitorin__batte__5812160E] CHECK  (([battery]>(0)))
GO
ALTER TABLE [dbo].[monitoring_data_info] CHECK CONSTRAINT [CK__monitorin__batte__5812160E]
GO
ALTER TABLE [dbo].[stations]  WITH CHECK ADD  CONSTRAINT [CK__stations__batter__4D94879B] CHECK  (([battery]>(0)))
GO
ALTER TABLE [dbo].[stations] CHECK CONSTRAINT [CK__stations__batter__4D94879B]
GO
ALTER TABLE [dbo].[stations]  WITH CHECK ADD  CONSTRAINT [CK__stations__emitte__4CA06362] CHECK  (([emittedFrequency]>(0)))
GO
ALTER TABLE [dbo].[stations] CHECK CONSTRAINT [CK__stations__emitte__4CA06362]
GO
USE [master]
GO
ALTER DATABASE [quantracmoitruong] SET  READ_WRITE 
GO
