--Corrupt TempDB to show resolution.
--Future demo MSDB corruption... missing job job steps etc
--move corruption over to a separate script and restore via db snap

USE [msdb]
GO

/****** Object:  Alert [825 - Read-Retry Required]    Script Date: 7/14/2017 9:28:59 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'825 - Read-Retry Required', 
		@message_id=825, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=0, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'54766764-d310-40ed-b4b4-059f14cdbddb'
GO

/****** Object:  Alert [SEV 17 ERROR]    Script Date: 7/14/2017 9:28:46 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'SEV 17 ERROR', 
		@message_id=0, 
		@severity=17, 
		@enabled=1, 
		@delay_between_responses=600, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]'
		--@job_id=N'54766764-d310-40ed-b4b4-059f14cdbddb'
GO

/****** Object:  Alert [SEV 18 ERROR]    Script Date: 7/14/2017 9:28:46 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'SEV 18 ERROR', 
		@message_id=0, 
		@severity=18, 
		@enabled=1, 
		@delay_between_responses=600, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'54766764-d310-40ed-b4b4-059f14cdbddb'
GO

/****** Object:  Alert [SEV 19 ERROR]    Script Date: 7/14/2017 9:28:46 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'SEV 19 ERROR', 
		@message_id=0, 
		@severity=19, 
		@enabled=1, 
		@delay_between_responses=600, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'54766764-d310-40ed-b4b4-059f14cdbddb'
GO

/****** Object:  Alert [SEV 20 ERROR]    Script Date: 7/14/2017 9:28:46 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'SEV 20 ERROR', 
		@message_id=0, 
		@severity=20, 
		@enabled=1, 
		@delay_between_responses=600, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'54766764-d310-40ed-b4b4-059f14cdbddb'
GO

/****** Object:  Alert [SEV 21 ERROR]    Script Date: 7/14/2017 9:28:46 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'SEV 21 ERROR', 
		@message_id=0, 
		@severity=21, 
		@enabled=1, 
		@delay_between_responses=600, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'54766764-d310-40ed-b4b4-059f14cdbddb'
GO

/****** Object:  Alert [SEV 22 ERROR]    Script Date: 7/14/2017 9:28:46 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'SEV 22 ERROR', 
		@message_id=0, 
		@severity=22, 
		@enabled=1, 
		@delay_between_responses=600, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'54766764-d310-40ed-b4b4-059f14cdbddb'
GO

/****** Object:  Alert [SEV 23 ERROR]    Script Date: 7/14/2017 9:28:46 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'SEV 23 ERROR', 
		@message_id=0, 
		@severity=23, 
		@enabled=1, 
		@delay_between_responses=600, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'54766764-d310-40ed-b4b4-059f14cdbddb'
GO

/****** Object:  Alert [SEV 24 ERROR]    Script Date: 7/14/2017 9:28:46 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'SEV 24 ERROR', 
		@message_id=0, 
		@severity=24, 
		@enabled=1, 
		@delay_between_responses=600, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'54766764-d310-40ed-b4b4-059f14cdbddb'
GO

/****** Object:  Alert [SEV 25 ERROR]    Script Date: 7/14/2017 9:28:46 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'SEV 25 ERROR', 
		@message_id=0, 
		@severity=25, 
		@enabled=1, 
		@delay_between_responses=600, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'54766764-d310-40ed-b4b4-059f14cdbddb'
GO


create database customer
use customer

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
--non clustered index
--Create table
if exists(select 1 from sys.tables where name = 'CorruptMe')
drop table CorruptMe
Go

Create table CorruptMe
(
	ID int
	, Name varchar(50)
)

insert into CorruptMe values (2, 'Abigail')
go 20

insert into CorruptMe values (1, 'Jimmy')
go 10

insert into CorruptMe values (2, 'Frank')
go 30

create nonclustered index idxName on CorruptMe (Name)
go
----
insert into CorruptMe values (2, 'Abigail')
go 2000

insert into CorruptMe values (1, 'Jimmy')
go 1000

insert into CorruptMe values (2, 'Frank')
go 3000

create nonclustered index idx2Name on CorruptMe (Name)
go

print 'blah'

select top 10 sys.fn_PhysLocFormatter(%%physloc%%) as pageid, * from CorruptMe

--Check for corruption
dbcc checkdb with all_errormsgs, no_infomsgs, tableresults
GO

--Lets get page IDs
DBCC IND ('customer', 'CorruptMe', 1)
GO



select * from sys.dm_db_database_page_allocations(DB_ID(), Object_id('dbo.CorruptMe'), 2,NULL, 'DETAILED')



--Lets fix the corruption
--Disable and rebuild non clustered index
select * from sys.indexes
where index_id = 2 and Object_name(OBJECT_ID) = 'CorruptMe'

alter index idxname on CorruptMe Disable
go

alter index idxname on CorruptMe rebuild
go

--Check again for corruption
dbcc checkdb with all_errormsgs, no_infomsgs, tableresults
GO

--truncate table msdb.dbo.suspect_pages
select * from msdb.dbo.suspect_pages


--Ok lets Repair our DB and see data loss
ALTER DATABASE customer SET SINGLE_USER WITH ROLLBACK IMMEDIATE
go

DBCC CHECKDB ('Customer', REPAIR_ALLOW_DATA_LOSS);
go

ALTER DATABASE customer SET multi_USER WITH ROLLBACK IMMEDIATE
go

-----------------------
-- Suspect DB
select DATABASEpropertyex ('suspectdb', 'status')

select name, state_desc from sys.databases

select DATABASEpropertyex ('suspectdb', 'status')

Alter Database suspectdb set EMERGENCY
GO
Alter Database suspectdb set single_user
GO

DBCC CheckDB ('suspectdb', REPAIR_ALLOW_DATA_LOSS) With All_errormsgs, tableresults
GO

Alter Database suspectdb set multi_user
GO

-----------------------------
--TEMPDB corruption

select * from sys.master_files
--C:\Program Files\Microsoft SQL Server\MSSQL14.DEMO2017\MSSQL\DATA\templog.ldf








