USE [master]
GO
/****** Object:  Database [ASKMachineTest]    Script Date: 1/31/2024 10:27:58 AM ******/
CREATE DATABASE [ASKMachineTest]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ASKMachineTest', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ASKMachineTest.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ASKMachineTest_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ASKMachineTest_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ASKMachineTest] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ASKMachineTest].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ASKMachineTest] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ASKMachineTest] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ASKMachineTest] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ASKMachineTest] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ASKMachineTest] SET ARITHABORT OFF 
GO
ALTER DATABASE [ASKMachineTest] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ASKMachineTest] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ASKMachineTest] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ASKMachineTest] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ASKMachineTest] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ASKMachineTest] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ASKMachineTest] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ASKMachineTest] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ASKMachineTest] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ASKMachineTest] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ASKMachineTest] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ASKMachineTest] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ASKMachineTest] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ASKMachineTest] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ASKMachineTest] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ASKMachineTest] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ASKMachineTest] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ASKMachineTest] SET RECOVERY FULL 
GO
ALTER DATABASE [ASKMachineTest] SET  MULTI_USER 
GO
ALTER DATABASE [ASKMachineTest] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ASKMachineTest] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ASKMachineTest] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ASKMachineTest] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ASKMachineTest] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ASKMachineTest] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ASKMachineTest', N'ON'
GO
ALTER DATABASE [ASKMachineTest] SET QUERY_STORE = ON
GO
ALTER DATABASE [ASKMachineTest] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ASKMachineTest]
GO
/****** Object:  Table [dbo].[descriptiontitleheadingdesc]    Script Date: 1/31/2024 10:27:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[descriptiontitleheadingdesc](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[productid] [int] NULL,
	[title] [varchar](100) NULL,
	[heading] [varchar](100) NULL,
	[description] [varchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[imageheading]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[imageheading](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[productid] [int] NULL,
	[fileheading] [varchar](100) NULL,
	[image] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_AddProduCategory]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_AddProduCategory](
	[AddCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](30) NULL,
	[IsActive] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_AddProduct]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_AddProduct](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Category] [varchar](50) NULL,
	[SubCategory] [varchar](50) NULL,
	[ProductName] [varchar](50) NULL,
	[Image] [varchar](max) NULL,
	[shortDescription] [varchar](100) NULL,
	[Content] [varchar](100) NULL,
	[Active] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_AddSubProdctCategory]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_AddSubProdctCategory](
	[AddSubCateId] [int] IDENTITY(1,1) NOT NULL,
	[ddlCategoryName] [varchar](20) NULL,
	[AddSubCategory] [varchar](20) NULL,
	[Active] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ProductResistration]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ProductResistration](
	[RegId] [int] IDENTITY(1,1) NOT NULL,
	[EmailId] [varchar](20) NULL,
	[Password] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[DeleteAddSubCategory]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[DeleteAddSubCategory]
(@CID int=null)
As
Begin
     declare @Msg varchar(MAx),@Status int,@Focus varchar(100)
	begin try
	begin tran
	   BEGIN
	      DELETE from AddSubCategory where CID=@CID
		  Set @Msg='Record delete Successfully.'
	   END
	commit tran
	ENd try
	Begin catch
	  rollback tran
	  Set @Msg=ERROR_MESSAGE()+'Lone no'+CONVERT(varchar,ERROR_LINE());
	End Catch
	   Select @Msg As Msg,@Status As Status,@Focus As Focus
End
GO
/****** Object:  StoredProcedure [dbo].[USP_BindCategory]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[USP_BindCategory]
(@CategoryID int)
AS
--USP_BindCityMaster 0
Begin
   if @CategoryID=0
      Select CategoryName From CategoryMaster order By CategoryID
End
GO
/****** Object:  StoredProcedure [dbo].[USP_BindProductCategory]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[USP_BindProductCategory]                 
AS          
-- USP_BindProductCategory           
Begin                 
      Select * From tbl_AddProduCategory where IsActive='1'         
End
GO
/****** Object:  StoredProcedure [dbo].[USP_BindProductSubCategory]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[USP_BindProductSubCategory]   
@ddlCategoryName varchar(20)  
AS            
-- USP_BindProductSubCategory           
Begin                    
      Select *  From tbl_AddSubProdctCategory where ddlCategoryName=@ddlCategoryName           
End 
GO
/****** Object:  StoredProcedure [dbo].[USP_BindSubCategory]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Proc [dbo].[USP_BindSubCategory]
(@CID int)
As
BEgin
   if @CID=0
      Select AddSubCategory From AddSubCategory order By CID
End
GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteAddProduct]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[USP_DeleteAddProduct]    
(@ProductID int=null)    
As    
Begin    
     declare @Msg varchar(MAx),@Status int,@Focus varchar(100)    
 begin try    
 begin tran    
    BEGIN    
       DELETE from tbl_AddProduct where ProductID=@ProductID  
	   Delete from imageheading where ProductID=@ProductID
	   Delete from descriptiontitleheadingdesc where ProductID=@ProductID
    Set @Msg='Record delete Successfully.'    
    END    
 commit tran    
 ENd try    
 Begin catch    
   rollback tran    
   Set @Msg=ERROR_MESSAGE()+'Lone no'+CONVERT(varchar,ERROR_LINE());    
 End Catch    
    Select @Msg As Msg,@Status As Status,@Focus As Focus    
End 


GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteAddProdutCategory]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Procedure [dbo].[USP_DeleteAddProdutCategory]          
(          
@AddCategoryId int=null          
)        
 -- USP_DeleteAddProdutCategory 12  
As          
Begin          
     declare @Msg varchar(MAx),@Status int,@Focus varchar(100),@ddlCategoryName varchar(50)
 begin try          
 begin tran  
 select @ddlCategoryName=CategoryName from tbl_AddProduCategory where AddCategoryId=@AddCategoryId  
  if Exists(select AddSubCateId from tbl_AddSubProdctCategory where ddlCategoryName=@ddlCategoryName	)      
 begin
   set @Msg= 'Firstly Delete SubCategory'      
 end    
 else  
    BEGIN           
       DELETE from tbl_AddProduCategory where AddCategoryId=@AddCategoryId         
    Set @Msg='Record Delete Successfully.'      
    END          
 commit tran          
 ENd try          
 Begin catch          
   rollback tran          
   Set @Msg=ERROR_MESSAGE()+'Line no:'+CONVERT(varchar,ERROR_LINE());          
 End Catch          
    Select @Msg As Msg,@Status As Status,@Focus As Focus          
End 


GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteAddSubProductCategory]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE Procedure [dbo].[USP_DeleteAddSubProductCategory]  
(@AddSubCateId  int=null)  
As  
Begin  
     declare @Msg varchar(MAx),@Status int,@Focus varchar(100)  
 begin try  
 begin tran  
    BEGIN  
       DELETE from tbl_AddSubProdctCategory where AddSubCateId=@AddSubCateId  
    Set @Msg='Record delete Successfully.'  
    END  
 commit tran  
 ENd try  
 Begin catch  
   rollback tran  
   Set @Msg=ERROR_MESSAGE()+'Lone no'+CONVERT(varchar,ERROR_LINE());  
 End Catch  
    Select @Msg As Msg,@Status As Status,@Focus As Focus  
End  
GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteCategoryMaster]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Procedure [dbo].[USP_DeleteCategoryMaster]    
(    
@CategoryID int=null    
)    
As    
Begin    
     declare @Msg varchar(MAx),@Status int,@Focus varchar(100),@CategoryName varchar(50)    
 begin try    
 begin tran    
    BEGIN     
  DELETE from CategoryMaster where CategoryID=@CategoryID    
    Set @Msg='Record Delete Successfully.'  
    END    
 commit tran    
 ENd try    
 Begin catch    
   rollback tran    
   Set @Msg=ERROR_MESSAGE()+'Line no:'+CONVERT(varchar,ERROR_LINE());    
 End Catch    
    Select @Msg As Msg,@Status As Status,@Focus As Focus    
End
GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteDesc]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create  Procedure [dbo].[USP_DeleteDesc]        
(          
	@id int      
)        
As          
BEGIN           
    DELETE from descriptiontitleheadingdesc where id=@id         
    Select 'Record Delete Successfully.' as Msg  
END  

GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteImageDetail]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[USP_DeleteImageDetail]  
(  
@ImageID int  
)  
As  
Begin  
     declare @Msg varchar(MAx),@Status int 
 begin try  
 begin tran  
    BEGIN  
       DELETE from tbl_ImageDetail where ImageID=@ImageID  
    Set @Msg='Record Delete Successfully.'  
    END  
 commit tran  
 ENd try  
 Begin catch  
   rollback tran  
   Set @Msg=ERROR_MESSAGE()+'Line no:'+CONVERT(varchar,ERROR_LINE());  
 End Catch  
    Select @Msg As Msg,@Status As Status  
End 
GO
/****** Object:  StoredProcedure [dbo].[USP_DeletePdf]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create  Procedure [dbo].[USP_DeletePdf]        
(          
	@id int      
)        
As          
BEGIN           
    DELETE from imageheading where id=@id         
    Select 'Record Delete Successfully.' as Msg  
END  

GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteProduct]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[USP_DeleteProduct]
(
@ProductID int
)
As
Begin
     declare @Msg varchar(MAx),@Status int,@Focus varchar(100)
	begin try
	begin tran
	   BEGIN
	      DELETE from Product_tbl where ProductID=@ProductID
		  Set @Msg='Record Delete Successfully.'
	   END
	commit tran
	ENd try
	Begin catch
	  rollback tran
	  Set @Msg=ERROR_MESSAGE()+'Line no:'+CONVERT(varchar,ERROR_LINE());
	End Catch
	   Select @Msg As Msg,@Status As Status,@Focus As Focus
End
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertRegistration]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Proc [dbo].[USP_InsertRegistration]
(
@RID int ,
@Name varchar(50),
@Email varchar(100),
@MobileNo varchar(10),
@Password varchar(10)
)
As
Begin
   Declare @Msg varchar(max),@Status int ,@Focus varchar(100)
   begin tran 
   begin try
      if exists(Select RID from Registration where Name=@Name And RID=@RID)
	  begin
	     Set @Msg='Name already exists.'
		 Set @Status=0
		 Set @Focus='txtName'
	  End
	   Else if exists(Select RID from Registration where Email=@Email And RID=@RID)
	  begin
	     Set @Msg='Email already exists.'
		 Set @Status=0
		 Set @Focus='txtEmail'
	  End
	   Else if exists(Select RID from Registration where MobileNo=@MobileNo And RID=@RID)
	  begin
	     Set @Msg='Mobile No already exists.'
		 Set @Status=0
		 Set @Focus='txtMobileNo'
	  End
	BEGIN
	    insert into Registration(Name,Email,MobileNo,Password)
		values(@Name,@Email,@MobileNo,@Password)
		Set @Msg='Registration successfully.'
		Set @Status=1
	END
   commit tran
   End try
   begin catch
    rollback tran
	Set @Msg=ERROR_MESSAGE()+'Line No :'+CONVERT(varchar,ERROR_LINE());
	Set @Status=0
   End catch
   select @Msg As Msg,@Status As Status,@Focus As Focus
End 
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertResistredStudent]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_InsertResistredStudent]    
(    
@RegId int,    
@Name varchar(20),    
@EmailId varchar(20),    
@Mobile varchar(10),    
@Password varchar(20)    
)    
As    
declare @Msg varchar(max),@Status int ,@Focus varchar(100)    
Begin    
if Exists(select RegId from tbl_ResistredStudent where Name=@Name and EmailId=@EmailId)    
begin    
 set @Msg='Your Are Allready Resisterd...!' 
 set @Status=1 
end   
else  
begin    
 insert into tbl_ResistredStudent(Name,EmailId,Mobile,Password)    
 values(@Name,@EmailId,@Mobile,@Password)    
 set @Msg ='Resisterd Data SuccessFully..!'    
 set @Status=2   
end    
select @Msg As Msg, @Status As [Status], @Focus As Focus    
end
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertUpAddProduct]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[USP_InsertUpAddProduct]                      
(                      
@ProductID int,                      
@Category varchar(50),                      
@SubCategory varchar(50),                      
@ProductName varchar(50),       
@Image varchar(max),                           
@shortDescription varchar(100),                            
@Content varchar(100), 
@Active bit                      
)                      
As                      
Begin                      
Declare @Msg varchar(max),@Status int,@Focus varchar(100),@id int=0                  
Begin tran                      
begin try                      
    if exists(Select ProductID from tbl_AddProduct where ProductName=@ProductName And ProductID<>@ProductID)                      
 Begin                      
  Set @Msg='Product Name already exist'                      
  Set @Status=0                      
 End                      
 Else                      
    if exists(Select ProductID from tbl_AddProduct where ProductID=@ProductID)                      
 Begin                      
   Update tbl_AddProduct Set Category=@Category, SubCategory=@SubCategory,ProductName=@ProductName,Image=@Image,shortDescription=@shortDescription,                      
  Content=@Content,Active=@Active where ProductID=@ProductID              
        
   Set @Msg='Record Update Successfully.'                      
   Set @Status=2        
   Set @id=@ProductID
 End                      
 Else                      
 Begin                      
   insert into tbl_AddProduct(Category,SubCategory,ProductName,Image,shortDescription,Content,Active)                      
   values(@Category,@SubCategory,@ProductName,@Image,@shortDescription,@Content,@Active)                      
   SEt @Msg='Record Inserted Successfully'                      
   Set  @Status=1    
   set @id=(Select top 1 ProductID from tbl_AddProduct order by ProductID desc)
 End                      
commit tran                       
end try                      
begin catch                      
rollback tran                      
Set @Msg=Error_MEssage()+'Line no:'+CONVERT(varchar,ERROR_LINE());                      
End catch                      
Select @Msg As Msg ,@Status As Status,@Focus AS Focus,@id as id                  
End 


GO
/****** Object:  StoredProcedure [dbo].[USP_InsertUpdateAddCategory]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[USP_InsertUpdateAddCategory]
(
@CID int,
@Category varchar(50),
@AddSubCategory varchar(50),
@Active bit
)
As
Begin
Declare @Msg varchar(max),@Status int,@Focus varchar(100)
Begin tran
begin try
    if exists(Select CID from AddSubCategory where AddSubCategory=@AddSubCategory And CID<>@CID)
	Begin
	 Set @Msg='AddSubCategory already exist'
	 Set @Status=0
	End
 Else
    if exists(Select CID from AddSubCategory where CID=@CID)
	Begin
	  Update AddSubCategory Set Category=@Category,AddSubCategory=@AddSubCategory,Active=@Active where CID=@CID
	  Set @Msg='Record Update Successfully.'
	  Set @Status=2
	End
	Else
	Begin
	  insert into AddSubCategory(Category,AddSubCategory,Active)values(@Category,@AddSubCategory,@Active)
	  SEt @Msg='Record Inserted Successfully'
	  Set  @Status=1
	End
commit tran 
end try
begin catch
rollback tran
Set @Msg=Error_MEssage()+'Line no:'+CONVERT(varchar,ERROR_LINE());
End catch
Select @Msg As Msg ,@Status As Status,@Focus AS Focus
End
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertUpdateAddProduct]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[USP_InsertUpdateAddProduct]
(
@ProductID int,
@Category varchar(50),
@SubCategory varchar(50),
@ProductName varchar(50),
@Image varchar(max),
@ImageType varchar(100),
@ImageName varchar(100),
@shortDescription varchar(100),
@Active bit
)
As
Begin
Declare @Msg varchar(max),@Status int,@Focus varchar(100)
Begin tran
begin try
    if exists(Select ProductID from Product_tbl where ProductName=@ProductName And ProductID<>@ProductID)
	Begin
	 Set @Msg='Product Name already exist'
	 Set @Status=0
	End
 Else
    if exists(Select ProductID from Product_tbl where ProductID=@ProductID)
	Begin
	  Update Product_tbl Set Category=@Category, SubCategory=@SubCategory,ProductName=@ProductName,Image=@Image,
	  ImageType=@ImageType,ImageName=@ImageName,shortDescription=@shortDescription,Active=@Active where ProductID=@ProductID
	  Set @Msg='Record Update Successfully.'
	  Set @Status=2
	End
	Else
	Begin
	  insert into Product_tbl(Category,SubCategory,ProductName,Image,ImageType,ImageName,shortDescription,Active)
	  values(@Category,@SubCategory,@ProductName,@Image,@ImageType,@ImageName,@shortDescription,@Active)
	  SEt @Msg='Record Inserted Successfully'
	  Set  @Status=1
	End
commit tran 
end try
begin catch
rollback tran
Set @Msg=Error_MEssage()+'Line no:'+CONVERT(varchar,ERROR_LINE());
End catch
Select @Msg As Msg ,@Status As Status,@Focus AS Focus
End
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertUpdateAddProductCategory]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Proc [dbo].[USP_InsertUpdateAddProductCategory]    
(    
@AddCategoryId int,    
@CategoryName varchar(50),    
@IsActive bit)    
As    
Begin    
Declare @Msg varchar(max),@Status int,@Focus varchar(100)    
Begin tran    
begin try    
    if exists(Select AddCategoryId from tbl_AddProduCategory where CategoryName=@CategoryName And AddCategoryId<>@AddCategoryId)    
 Begin    
  Set @Msg='CategoryName already exist'    
  Set @Status=0    
 End    
 Else    
    if exists(Select AddCategoryId from tbl_AddProduCategory where AddCategoryId=@AddCategoryId)    
 Begin    
   Update tbl_AddProduCategory Set CategoryName=@CategoryName,IsActive=@IsActive where AddCategoryId=@AddCategoryId   
   Set @Msg='Record Update Successfully.'    
   Set @Status=2    
 End    
 Else    
 Begin    
   insert into tbl_AddProduCategory(CategoryName,IsActive)values(@CategoryName,@IsActive)    
   SEt @Msg='Record Inserted Successfully'    
   Set  @Status=1    
 End    
commit tran     
end try    
begin catch    
rollback tran    
Set @Msg=Error_MEssage()+'Line no:'+CONVERT(varchar,ERROR_LINE());    
End catch    
Select @Msg As Msg ,@Status As Status,@Focus AS Focus    
End 
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertUpdateAddSubProductCategory]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
      
CREATE Proc [dbo].[USP_InsertUpdateAddSubProductCategory]      
(      
 @AddSubCateId int ,    
 @ddlCategoryName varchar(20),    
 @AddSubCategory varchar(20),    
 @Active bit      
)      
As      
Begin      
Declare @Msg varchar(max),@Status int,@Focus varchar(100)      
Begin tran      
begin try      
    if exists(Select AddSubCateId from tbl_AddSubProdctCategory where AddSubCategory=@AddSubCategory And AddSubCateId<>@AddSubCateId)      
 Begin      
  Set @Msg='AddSubCategory already exist'      
  Set @Status=0      
 End      
 Else      
    if exists(Select AddSubCateId from tbl_AddSubProdctCategory where AddSubCateId=@AddSubCateId)      
 Begin      
   Update tbl_AddSubProdctCategory Set ddlCategoryName=@ddlCategoryName,AddSubCategory=@AddSubCategory,Active=@Active where AddSubCateId=@AddSubCateId     
   Set @Msg='Record Update Successfully.'      
   Set @Status=2      
 End      
 Else      
 Begin      
   insert into tbl_AddSubProdctCategory(ddlCategoryName,AddSubCategory,Active)values(@ddlCategoryName,@AddSubCategory,@Active)      
   SEt @Msg='Record Inserted Successfully'      
   Set  @Status=1      
 End      
commit tran       
end try      
begin catch      
rollback tran      
Set @Msg=Error_MEssage()+'Line no:'+CONVERT(varchar,ERROR_LINE());      
End catch      
Select @Msg As Msg ,@Status As Status,@Focus AS Focus      
End      
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertUpdateCategory]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create  Proc [dbo].[USP_InsertUpdateCategory]
(
@CategoryID int,
@CategoryName varchar(50),
@Active bit)
As
Begin
Declare @Msg varchar(max),@Status int,@Focus varchar(100)
Begin tran
begin try
    if exists(Select CategoryID from CategoryMaster where CategoryName=@CategoryName And CategoryID<>@CategoryID)
	Begin
	 Set @Msg='CategoryName already exist'
	 Set @Status=0
	End
 Else
    if exists(Select CategoryID from CategoryMaster where CategoryID=@CategoryID)
	Begin
	  Update CategoryMaster Set CategoryName=@CategoryName,Active=@Active where CategoryID=@CategoryID
	  Set @Msg='Record Update Successfully.'
	  Set @Status=2
	End
	Else
	Begin
	  insert into CategoryMaster(CategoryName,Active)values(@CategoryName,@Active)
	  SEt @Msg='Record Inserted Successfully'
	  Set  @Status=1
	End
commit tran 
end try
begin catch
rollback tran
Set @Msg=Error_MEssage()+'Line no:'+CONVERT(varchar,ERROR_LINE());
End catch
Select @Msg As Msg ,@Status As Status,@Focus AS Focus
End
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertUpdateImageDetail]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[USP_InsertUpdateImageDetail]    
(    
@ImageID int,    
@Name varchar(50),    
@Image varchar(max),    
@ImageType varchar(100),    
@ImageName varchar(100)   
)    
As    
Begin    
Declare @Msg varchar(max),@Status int    
Begin tran    
begin try    
    if exists(Select ImageID from tbl_ImageDetail where Name=@Name And ImageID<>@ImageID)    
 Begin    
  Set @Msg='Name already exist'    
  Set @Status=0    
 End    
 Else    
    if exists(Select ImageID from tbl_ImageDetail where ImageID=@ImageID)    
 Begin    
   Update tbl_ImageDetail Set Name=@Name, Image=@Image,ImageType=@ImageType,ImageName=@ImageName where ImageID=@ImageID   
   Set @Msg='Record Update Successfully.'    
   Set @Status=2    
 End    
 Else    
 Begin    
   insert into tbl_ImageDetail(Name,Image,ImageType,ImageName)    
   values(@Name,@Image,@ImageType,@ImageName)    
   SEt @Msg='Record Inserted Successfully'    
   Set  @Status=1    
 End    
commit tran     
end try    
begin catch    
rollback tran    
Set @Msg=Error_MEssage()+'Line no:'+CONVERT(varchar,ERROR_LINE());    
End catch    
Select @Msg As Msg ,@Status As Status   
End 
GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[USP_Login]
(
@Email varchar(100),
@Password varchar(10)
)
As
Begin
   Declare @Msg varchar(max),@Status int ,@Focus varchar(100)
   begin tran 
   begin try
	  if exists(Select RID from Registration where Email=@Email And Password=@Password)
	  begin
	     Set @Msg='Login Successfully.'
		 Set @Status=1
	  End
	Else
	BEGIN
		Set @Msg='Login failed'
		Set @Status=0
	END
   commit tran
   End try
   begin catch
    rollback tran
	Set @Msg=ERROR_MESSAGE()+'Line No :'+CONVERT(varchar,ERROR_LINE());
	Set @Status=0
   End catch
   select @Msg As Msg,@Status As Status,@Focus As Focus
End
GO
/****** Object:  StoredProcedure [dbo].[USP_Product_id_fileheading_image]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_Product_id_fileheading_image]
(
	@id int ,
	@productid int, 
	@fileheading varchar(100),
	@image varchar(max)
)
as
begin
	if(@id=0)
	begin
		insert into imageheading(productid,fileheading,image) values(@productid,@fileheading,@image)
	end
	else
	begin
		update imageheading set productid=@productid,fileheading=@fileheading,image=@image where id=@id
	end
end
GO
/****** Object:  StoredProcedure [dbo].[USP_Product_id_title_heading_description]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_Product_id_title_heading_description]
(
	@id int =0,
	@productid int, 
	@title varchar(100),
	@heading varchar(100),
	@description varchar(250)
)
as
begin
	if(@id=0)
	begin
		insert into descriptiontitleheadingdesc(productid,title,heading,description) values (@productid,@title,@heading,@description)
	end
	else 
	begin 
		update descriptiontitleheadingdesc set productid=@productid,title=@title,heading=@heading,description=@description where id=@id
	end
end
GO
/****** Object:  StoredProcedure [dbo].[USP_ProductLogin]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_ProductLogin]
(
  @EmailId VARCHAR(50),      
  @Password VARCHAR(20)      
)
AS
BEGIN
  DECLARE @Msg VARCHAR(100) = '',
          @Status INT = 0,
          @Focus VARCHAR(100) = '',
          @Id INT = 0,
          @Email VARCHAR(50) = ''

  IF NOT EXISTS (SELECT 1 FROM tbl_ProductResistration WHERE EmailId = @EmailId)
  BEGIN
    SET @Msg = 'Enter valid Email'
    SET @Status = 0
    SET @Focus = 'txtEmailId'
  END
  ELSE IF NOT EXISTS (SELECT 1 FROM tbl_ProductResistration WHERE EmailId = @EmailId AND Password = @Password)
  BEGIN
    SET @Msg = 'Enter valid password'
    SET @Status = 0
    SET @Focus = 'txtPassword'
  END
  ELSE
  BEGIN
    SET @Msg = 'Login Successfully'
    SET @Status = 1
    SELECT @Id = RegId, @Email = EmailId
    FROM tbl_ProductResistration
    WHERE EmailId = @EmailId AND Password = @Password
  END

  SELECT @Msg AS Msg, @Status AS [Status], @Focus AS Focus, @Id AS Id, @Email AS Email 
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ShowAddcategory]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create  Proc  [dbo].[USP_ShowAddcategory]
( @CategoryID int=null)
As 
Begin
       Select CategoryID,CategoryName,Active From CategoryMaster 
	   where CategoryID=(Case when Isnull(@CategoryID,0)=0 then CategoryID else @CategoryID End) 
End
GO
/****** Object:  StoredProcedure [dbo].[USP_ShowAddProduct]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_ShowAddProduct]          
 (          
   @ProductID int=0          
 )          
 -- USP_ShowImageDetail  0 --         
 AS          
 Begin          
 if @ProductID=0          
 Begin          
 Select Row_NUMbER() OVER (order by ProductID) AS [Product Id],ProductID,Category,SubCategory, ProductName,shortDescription,Content ,                    
    case                     
    when Active='True' then 'Active'                    
        when Active='False' then 'InActive'                    
    End   as Active                  
    From tbl_AddProduct   End          
 Else          
 Begin          
  Select a.ProductID,a.Category,a.SubCategory,a.ProductName,a.Image,a.shortDescription,a.Content,a.Active,b.descid,b.title,b.heading,b.description,c.imageid,
  c.fileheading,c.images from tbl_AddProduct a left outer join 
  (Select productid,STRING_AGG(id, '#') AS descid,STRING_AGG(title,'#') as title,STRING_AGG(heading,'#') as heading,STRING_AGG(description,'#') as description 
  from descriptiontitleheadingdesc group by productid) b on a.ProductID=b.productid left outer join 
  (Select productid,STRING_AGG(id, '#') AS imageid,STRING_AGG(fileheading, '#') AS fileheading,STRING_AGG(image, '#') AS images
  from imageheading group by productid) c on a.ProductID=c.productid where a.ProductID=@ProductID          
 End          
 End


GO
/****** Object:  StoredProcedure [dbo].[USP_ShowAddProductCategory]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc  [dbo].[USP_ShowAddProductCategory]                    
( @AddCategoryId int=null)                    
As                    
-- USP_ShowAddProductcategory --              
Begin                    
       Select Row_NUMbER() OVER (order by AddCategoryId) AS [AddCategory Id],AddCategoryId,CategoryName,              
    case               
    when IsActive='True' then 'Active'              
        when IsActive='False' then 'InActive'              
    End  As IsActive             
    From tbl_AddProduCategory                     
    where AddCategoryId=(Case when Isnull(@AddCategoryId,0)=0 then AddCategoryId else @AddCategoryId End)                     
End 
GO
/****** Object:  StoredProcedure [dbo].[USP_ShowAddSubcategory]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc  [dbo].[USP_ShowAddSubcategory]
( @CID int=null)
As 
Begin
       Select CID,Category,AddSubCategory,Active From AddSubCategory 
	   where CID=(Case when Isnull(@CID,0)=0 then CID else @CID End) 
End
GO
/****** Object:  StoredProcedure [dbo].[USP_ShowAddSubProductcategory]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc  [dbo].[USP_ShowAddSubProductcategory]            
( @AddSubCateId int=null)            
As             
-- USP_ShowAddSubProductcategory        
Begin            
       Select Row_NUMbER() OVER (order by AddSubCateId) AS [AddSubCate Id],AddSubCateId,ddlCategoryName,AddSubCategory,        
   case           
  when Active='True' then 'Active'          
        when Active='False' then 'InActive'          
  End  As Active        
    From tbl_AddSubProdctCategory             
    where AddSubCateId=(Case when Isnull(@AddSubCateId,0)=0 then AddSubCateId else @AddSubCateId End)             
End 
GO
/****** Object:  StoredProcedure [dbo].[USP_ShowImageDetail]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[USP_ShowImageDetail]        
 (        
   @ImageID int=0        
 )        
      
 -- USP_ShowImageDetail  0 --       
 AS        
 Begin        
 if @ImageID=0        
 Begin        
Select Row_NUMbER() OVER (order by ImageID) AS [Image ID],ImageID,Name,Image  From tbl_ImageDetail order by ImageID        
 End        
 Else        
 Begin        
  Select * from tbl_ImageDetail where ImageID=@ImageID        
 End        
 End
GO
/****** Object:  StoredProcedure [dbo].[USP_ShowLogin]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_ShowLogin]
(
  @RegId int,
  @EmailId varchar(20),
  @Password varchar(20)
)
As
declare @Msg varchar(100),@Status int , @Focus varchar(100)
Begin
  if Exists(select * from tbl_ProductResistration where RegId<>@RegId)
  begin
   set @Msg='LOgin Successfully'
  end
 else
  begin
   set @Msg='LOgin Failed'
  end
end
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateChangePassword]    Script Date: 1/31/2024 10:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE proc [dbo].[USP_UpdateChangePassword]                  
  (             
  @Password varchar(20),      
  @NewPassword varchar(20)                
  )                 
  -- USP_UpdateChangePassword 'piky','986'            
    As  
 Begin  
  declare @Msg varchar(100),@Status int ,@Focus varchar(100) = 'txtCurrentPassword' , @EmailId varchar(20)              
  if exists(Select * from tbl_ProductResistration where  Password=@Password)        
 Begin       
  update tbl_ProductResistration set Password=@NewPassword where Password=@Password              
    set @Msg= 'Change Password Succesfully'                  
 set @Status= 1        
   End     
   else  
    Begin   
     set @Msg= 'Invalid Password'                  
 set @Status= 1   
   End     
Select @Msg As Msg ,@Status As Status,@Focus AS Focus          
End
GO
USE [master]
GO
ALTER DATABASE [ASKMachineTest] SET  READ_WRITE 
GO
