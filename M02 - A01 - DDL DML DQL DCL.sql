/*************************************************
 Curso T-SQL
 Autor: Landry

 Demonstração:
 - DDL (Data Definition Language)
 - DCL (Data Control Language)
 - DQL (Data Query Language)
 - DML (Data Manipulation Language)
*************************************************/
use Aula
go

/**********************************************
 DDL (Data Definition Language)
 - CREATE, ALTER, DROP
***********************************************/
-- Cria tabela Cliente
CREATE TABLE dbo.Cliente (
Cliente_ID int not null,
Nome varchar(50) not null)

-- Altera estrutura da tabela cliente
-- Adiciona nova coluna CPF
ALTER TABLE dbo.Cliente ADD CPF varchar(11) null

-- apaga a tabela Cliente
DROP TABLE dbo.Cliente

/**********************************************
 DCL (Data Control Language)
 - GRANT, DENY, REVOKE
***********************************************/
-- Cria tabela Cliente
CREATE TABLE dbo.Cliente (
Cliente_ID int not null,
Nome varchar(50) not null)
go

INSERT dbo.Cliente VALUES (1,'Landry')

-- Cria Login e Usuário "Erick" para testar comandos DCL
CREATE LOGIN Erick WITH PASSWORD = N'Senha', CHECK_POLICY=OFF
go
CREATE USER Erick FOR LOGIN Erick
go

-- Troca o contexto da conexão para o usuário "Erick"
EXECUTE AS USER = 'Erick'
-- Retorna o usuário corrente da conexão
SELECT SUSER_NAME()
-- Retorna o contexto da conexão para o usuário original
REVERT

SELECT * FROM dbo.Cliente
INSERT dbo.Cliente VALUES (2,'Paula')

-- Atribui permissão SELECT e INSERT para usuário "Erick" na tabela "Cliente"
GRANT SELECT,INSERT ON dbo.Cliente TO Erick

INSERT dbo.Cliente VALUES (2,'Paula')
SELECT * FROM dbo.Cliente

-- Nega permissão INSERT para usuário "Erick" na tabela "Cliente" 
DENY INSERT ON dbo.Cliente TO Erick

INSERT dbo.Cliente VALUES (3,'Luana')
SELECT * FROM dbo.Cliente

-- Remove tanto um GRANT quanto um REVOKE
REVOKE SELECT,INSERT ON dbo.Cliente TO Erick

-- Exclui Usuário e Login "Erick"
DROP USER Erick
DROP LOGIN Erick

/**********************************************
 DQL (Data Query Language)
 - SELECT
***********************************************/
-- Consulta linhas
SELECT * FROM dbo.Cliente

/**********************************************
 DML (Data Manipulation Language)
 - INSERT, UPDATE, DELETE, TRUNCATE TABLE
***********************************************/
-- Inclui linhas
INSERT dbo.Cliente VALUES (3,'Luana')

-- Atualiza linhas
UPDATE dbo.Cliente SET Nome = 'Landry Duailibe'
WHERE Cliente_ID = 1

-- Exclui linhas
DELETE dbo.Cliente WHERE Cliente_ID = 3 -- Luana

-- Apaga todas as linhas da tabela Cliente
TRUNCATE TABLE dbo.Cliente

/****************************
 Batches: GO
*****************************/
INSERT dbo.Cliente VALUES (1,'Landry')

SELECT * FROM dbo.Cliente
go
SELECT *  dbo.Cliente

-- Exclui tabelas
DROP TABLE dbo.Cliente