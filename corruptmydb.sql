backup database customer to disk='c:\temp\corruptiondemo.back'
restore database customer from disk='c:\temp\corruptiondemo.back'


--Ok lets corrupt our clustered index
ALTER DATABASE customer SET SINGLE_USER WITH ROLLBACK IMMEDIATE
go

--CorruptMeClust
--db, fileid, pageid, offset, length, data, bypass bufferpool 
DBCC WRITEPAGE('customer', 1, 352, 120, 5, 0x0000000000, 1)
go

ALTER DATABASE customer SET Multi_USER WITH ROLLBACK IMMEDIATE
go

--Ok lets corrupt our nonclustered index
ALTER DATABASE customer SET SINGLE_USER WITH ROLLBACK IMMEDIATE
go

--CorruptMeClust
--db, fileid, pageid, offset, length, data, bypass bufferpool 
DBCC WRITEPAGE('customer', 1, 368, 60, 5, 0x0000000000, 1)
go

ALTER DATABASE customer SET Multi_USER WITH ROLLBACK IMMEDIATE
go




----------------------------------------------
----------------------------------------------
----------------------------------------------
--IAM Page Corruption
--Lets get page IDs
DBCC IND (customer, 'CorruptMe', 1)
GO

--Ok lets corrupt our IAM page for the heap
ALTER DATABASE customer SET SINGLE_USER WITH ROLLBACK IMMEDIATE
go

--db, fileid, pageid, offset, length, data, bypass bufferpool 
DBCC WRITEPAGE('customer', 1, 244, 60, 5, 0x0000000000, 1)
go

ALTER DATABASE customer SET Multi_USER WITH ROLLBACK IMMEDIATE
go