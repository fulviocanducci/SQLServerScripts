/*************************************************
 Curso T-SQL
 Autor: Landry

 Demonstração:
 - Criando Banco de Dados
 - Backup e Restore
**************************************************/
use master
go

-- Criando o Banco de Dados "Aula" para demonstrações do curso
-- utiliza caminho padrão para arq. de Dados e Log
-- Tamanho inicial dos arquivos padrão, igual ao Banco de Sistema "Model"
CREATE DATABASE Aula
go

-- Alterar Recovery Model para SIMPLE do Banco de Dados "Aula", ideal para Bancos de teste.
ALTER DATABASE Aula SET RECOVERY SIMPLE
go

-- Verificando a criação do Banco de Dados "Aula" e Recovery Model SIMPLE
SELECT [name] as Banco, recovery_model_desc as Recovery_Model
FROM sys.databases
WHERE [name] = 'Aula'

-- BACKUP do Banco de Dados "Aula"
BACKUP DATABASE Aula TO DISK = 'C:\Temp\SqlServer\Backup\Aula.bak' WITH format, compression, stats=2

-- Retorna informações do Banco de Dados "Aula"
exec sp_helpdb 'Aula'

-- Coloca o Banco de Dados "Aula" OffLine, derrubanco antes todas as conexões
ALTER DATABASE Aula SET OFFLINE WITH ROLLBACK IMMEDIATE
ALTER DATABASE Aula SET ONLINE WITH ROLLBACK IMMEDIATE

-- Restaura o Banco de Dados "Aula" a partir de um Backup
RESTORE DATABASE Aula FROM DISK = 'C:\Temp\SqlServer\Backup\Aula.bak' WITH recovery, stats=2,
MOVE 'Aula' TO 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Aula.mdf',
MOVE 'Aula_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Aula_log.ldf'

-- Exclui o Banco de Dados "Aula"
DROP DATABASE Aula;