/*************************************************
 Curso T-SQL
 Autor: Landry

 Demonstração:
 - Banco de Dados AdventureWorks
*************************************************/
use master
go

RESTORE FILELISTONLY FROM DISK = 'C:\Users\Developer\Downloads\SqlServer2022\AdventureWorksLT2022.bak'

RESTORE DATABASE AdventureWorksLT FROM DISK = 'C:\Users\Developer\Downloads\SqlServer2022\AdventureWorksLT2022.bak' WITH stats=2,
MOVE 'AdventureWorksLT2022_Data' TO 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\AdventureWorksLT.mdf',
MOVE 'AdventureWorksLT2022_Log'  TO 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\AdventureWorksLT_log.ldf'

ALTER AUTHORIZATION ON DATABASE::AdventureWorksLT TO sa


