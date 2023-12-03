/*************************************************
 Curso T-SQL
 Autor: Landry

 Demonstração:
 - TIMESTAMP e ROWVERSION
 - UNIQUEIDENTIFIER
 - SQL_VARIANT
 - HIERARCHYID
 - TABLE
*************************************************/
use Aula
go

/******************************************************************************************************
 TIMESTAMP e ROWVERSION
 - Versão da linha
 https://learn.microsoft.com/en-us/sql/t-sql/data-types/rowversion-transact-sql?view=sql-server-ver16
*******************************************************************************************************/

CREATE TABLE tbTimeStamp (
cod int not null,
nome varchar(20) not null,
ColTimestamp rowversion,
ColRowversion rowversion)
go
-- ERRO: Timestamp e Rowversion são sinônimos, só pode um por tabela!

-- drop table tbRowversion
CREATE TABLE tbRowversion (
cod int not null,
nome varchar(20) not null,
ColRowversion rowversion)
go

INSERT tbRowversion (cod,nome,ColRowversion)  VALUES (1,'Jose',10)
-- ERRO: Não pode fornecer valor em coluna TIMESTAMP e ROWVERSION.

INSERT tbRowversion VALUES (1,'Jose')
-- ERRO: Tem que fornecer a lista de colunas no INSERT.

INSERT tbRowversion (cod,nome)  VALUES (1,'Jose')
INSERT tbRowversion (cod,nome)  VALUES (2,'Maria')
INSERT tbRowversion (cod,nome)  VALUES (3,'Ana')

SELECT * FROM tbRowversion

UPDATE tbRowversion SET nome = 'Jose Silva' WHERE cod = 1

-- Exclui tabela
DROP TABLE tbRowversion

/*********************************************************************************************************** 
 UNIQUEIDENTIFIER 
 - Chave única de 16 bytes até mesmo entre servidores
 https://learn.microsoft.com/pt-br/sql/t-sql/data-types/uniqueidentifier-transact-sql?view=sql-server-ver16
************************************************************************************************************/
/*
NEWSEQUENTIALID() - Gera GUID sequencial até o Windows Reiniciar, é mais rápida que NEWID()
NEWID() - Gera GUID não sequencial.
*/
-- drop table tbUniqueidentifier
CREATE TABLE tbUniqueidentifier (
cod int not null,
nome varchar(20) not null,
Col_NEWID Uniqueidentifier not null default NEWID(),
Col_NEWSEQUENTIALID Uniqueidentifier not null default NEWSEQUENTIALID())
go

INSERT tbUniqueidentifier (cod,nome)  VALUES (1,'Jose')
INSERT tbUniqueidentifier (cod,nome)  VALUES (2,'Ana')
INSERT tbUniqueidentifier (cod,nome)  VALUES (3,'Maria')

SELECT * FROM tbUniqueidentifier

SELECT NEWSEQUENTIALID()
-- ERRO: não pode ser referenciada em SELECT.

SELECT NEWID()

-- Exclui tabela
DROP TABLE tbUniqueidentifier

/******************************************************************************************************
 SQL_VARIANT
 https://learn.microsoft.com/en-us/sql/t-sql/data-types/sql-variant-transact-sql?view=sql-server-ver16

 Lista dos tipos de dados que não podem ser utilizados no SQL_VARIANT:
 - datetimeoffset1
 - geography
 - geometry
 - hierarchyid
 - image
 - ntext
 - nvarchar(max)
 - rowversion (timestamp)
 - text
 - varchar(max)
 - varbinary(max)
 - User-defined types
 - xml
*******************************************************************************************************/
-- DROP TABLE tbSQL_Variant
CREATE TABLE tbSQL_Variant (
cod int not null,
nome varchar(20) not null,
Col_SQL_Variant SQL_Variant not null)
go

INSERT tbSQL_Variant (cod,nome,Col_SQL_Variant) VALUES (1,'Jose','String')
INSERT tbSQL_Variant (cod,nome,Col_SQL_Variant) VALUES (2,'Ana',cast('20120801' as date))
INSERT tbSQL_Variant (cod,nome,Col_SQL_Variant) VALUES (3,'Maria',1234)

SELECT * FROM tbSQL_Variant
-- Tipo de dado DATE foi convertido para Datetime

-- Exclui tabela
DROP TABLE tbSQL_Variant


/***************************************************************
 XML
****************************************************************/
-- DROP TABLE dbo.Carros
CREATE TABLE dbo.Carros (
CarroID int not null, 
Modelo varchar(50), 
Fabricante varchar(30),
Tipo varchar(10), 
IfoVenda xml)
go

INSERT dbo.Carros VALUES (1,'Polo','General Motors','Sedan',
'<Carro>
   <KmLitro>10</KmLitro>
   <Ar>Sim</Ar>
   <Direcao>Sim</Direcao>
 </Carro>')
go

INSERT dbo.Carros VALUES (2,'Fiesta','Ford','Popular',
'<Carro>
   <KmLitro>14</KmLitro>
   <Ar>Sim</Ar>
   <Direcao>Sim</Direcao>
 </Carro>')
go

SELECT * FROM dbo.Carros

SELECT CarroID, Modelo, 
IfoVenda.value('(/Carro/KmLitro)[1]','VARCHAR(50)') as KmLitro
FROM dbo.Carros
where IfoVenda.exist('/Carro/KmLitro[(text()[1])=14]') = 1


-- Exclui tabela
DROP TABLE dbo.Carros

/*********************************************************************************************************************
 HIERARCHYID
 https://learn.microsoft.com/en-us/sql/t-sql/data-types/hierarchyid-data-type-method-reference?view=sql-server-ver16
**********************************************************************************************************************/
CREATE TABLE FuncionarioHierarchies(
FuncionarioID int not null primary key,
Nome varchar(10) not null,
Cargo varchar(12) not null,
Hierarquia hierarchyid null)
go

INSERT FuncionarioHierarchies VALUES (1,'Jose','Presidente',hierarchyid::GetRoot())
go
SELECT * FROM FuncionarioHierarchies where Hierarquia = hierarchyid::GetRoot()

-- Inclusao dos Diretores Maria e Pedro, utilizando o método GetDescendant:
-- Inclui Maria
DECLARE @Pai hierarchyid                      
SELECT @Pai = hierarchyid::GetRoot() FROM FuncionarioHierarchies

INSERT FuncionarioHierarchies VALUES (2,'Maria','Diretor',@Pai.GetDescendant(NULL,NULL))
go

-- Inclui Pedro
DECLARE @Pai hierarchyid                      
DECLARE @PrimeiroFilho hierarchyid                     
SELECT @Pai = hierarchyid::GetRoot() FROM FuncionarioHierarchies
SELECT @PrimeiroFilho =@Pai.GetDescendant(NULL,NULL)

INSERT FuncionarioHierarchies VALUES (3,'Pedro','Diretor',@Pai.GetDescendant(@PrimeiroFilho,NULL))
go

-- Completar Organograma com Gerentes
DECLARE @Pai hierarchyid                      
DECLARE @PrimeiroFilho hierarchyid                     
SELECT @Pai = Hierarquia FROM FuncionarioHierarchies where FuncionarioID = 2
INSERT FuncionarioHierarchies VALUES (4,'Ana','Gerente',@Pai.GetDescendant(NULL,NULL))
SELECT @PrimeiroFilho =@Pai.GetDescendant(NULL,NULL)
INSERT FuncionarioHierarchies VALUES (5,'Lucia','Gerente',@Pai.GetDescendant(@PrimeiroFilho,NULL))

SELECT @Pai = Hierarquia FROM FuncionarioHierarchies where FuncionarioID = 3
INSERT FuncionarioHierarchies VALUES (6,'Ronaldo','Gerente',@Pai.GetDescendant(NULL,NULL))

SELECT @Pai = Hierarquia FROM FuncionarioHierarchies where FuncionarioID = 5
INSERT FuncionarioHierarchies VALUES (7,'Marcio','Coordenador',@Pai.GetDescendant(NULL,NULL))
go

-- Retornar o Organograma
SELECT FuncionarioID,Nome,Cargo,Hierarquia.GetLevel() as Nivel,
(Select FuncionarioID FROM FuncionarioHierarchies 
Where Hierarquia = e.Hierarquia.GetAncestor(1)) As Chefe,Hierarquia
FROM FuncionarioHierarchies e

-- Exclui tabela
DROP TABLE FuncionarioHierarchies


/**************************************************************************************************
 TABLE
 https://learn.microsoft.com/en-us/sql/t-sql/data-types/table-transact-sql?view=sql-server-ver16
***************************************************************************************************/
CREATE TABLE tbProduto (
ProdutoID int not null,
Produto varchar(50) not null,
Mkt Table not null)
go
/* ERRO: Tipo de Dado TABLE não pode ser utilizado em coluna, só em variável
Msg 156, Level 15, State 1, Line 181
Incorrect syntax near the keyword 'Table'
*/

DECLARE @Cliente Table(cod int not null primary key, nome varchar(20) not null)

INSERT @Cliente (cod,nome) VALUES (1,'Jose')
INSERT @Cliente (cod,nome) VALUES (2,'Ana')
INSERT @Cliente (cod,nome) VALUES (3,'Paula')

SELECT * FROM @Cliente



