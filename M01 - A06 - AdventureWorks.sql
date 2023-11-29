/*************************************************
 Curso T-SQL
 Autor: Landry

 Demonstração:
 - Banco de Dados AdventureWorks
*************************************************/
use master
go

RESTORE FILELISTONLY FROM DISK = 'c:\Backup\AdventureWorksLT2022.bak'

RESTORE DATABASE AdventureWorksLT FROM DISK = 'c:\Backup\AdventureWorksLT2022.bak' WITH stats=2,
MOVE 'AdventureWorksLT2022_Data' TO 'C:\MSSQL_Data\AdventureWorksLT.mdf',
MOVE 'AdventureWorksLT2022_Log'  TO 'C:\MSSQL_Data\AdventureWorksLT_log.ldf'

ALTER AUTHORIZATION ON DATABASE::AdventureWorksLT TO sa


