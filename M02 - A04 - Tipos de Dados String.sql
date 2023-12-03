/***************************************************************************
 Curso T-SQL
 Autor: Landry

 Demonstração:
 - Diferença entre VARCHAR/NVARCHAR e CHAR/NCHAR
 - LEFT ( character_expression , integer_expression ) 
 - RIGHT ( character_expression , integer_expression )
 - SUBSTRING ( expression ,start , length )
 - LTRIM ( character_expression )
 - RTRIM ( character_expression )
 - TRIM ( [ characters FROM ] string )
 - REPLACE ( string_expression , string_pattern , string_replacement )
 - REPLICATE ( string_expression , integer_expression )
 - LEN ( string_expression )
 - STR ( float_expression [ , length [ , decimal ] ] )
***************************************************************************/
use Aula
go

/************************
 String CHAR e VARCHAR
*************************/ 
-- DROP TABLE Produto
CREATE TABLE Produto (
ProdutoID int not null,
Produto_Varchar varchar(50) null,
Produto_Char char(50) null,
Valor_Unitario decimal(10,2) null)
go

INSERT Produto VALUES (1,'Monitor LCD 21"','Monitor LCD 21"', 780.00)

SELECT ProdutoID, Produto_Varchar,Produto_Char
FROM Produto
-- Monitor LCD 21"
-- Monitor LCD 21"                                   

/**************************************************************************************************************
 Funções String
 https://learn.microsoft.com/en-us/sql/t-sql/functions/string-functions-transact-sql?view=sql-server-ver16
***************************************************************************************************************/

/***************************************************
 LEFT ( character_expression , integer_expression ) 
 RIGHT ( character_expression , integer_expression )
 SUBSTRING ( expression ,start , length )
****************************************************/
DECLARE @Produto varchar(50) = 'Impressora HP Jato de Tinta'

SELECT @Produto, left(@Produto,3), right(@Produto,5), substring(@Produto,12,2)

/****************************************
 Funções que removem espaço em branco:
 LTRIM ( character_expression )
 RTRIM ( character_expression )
 TRIM ( [ characters FROM ] string )
*****************************************/
DECLARE @Nome varchar(50) = '    Landry    '
DECLARE @Sobrenome varchar(50) = '    Duailibe Salles'

SELECT @Nome + ' ' + @Sobrenome, trim(@Nome) + ' ' + ltrim(@Sobrenome)

/**********************************************************************
 REPLACE ( string_expression , string_pattern , string_replacement )
 REPLICATE ( string_expression , integer_expression )
 LEN ( string_expression )
 STR ( float_expression [ , length [ , decimal ] ] )
***********************************************************************/
-- Inclui mais linhas na tabela "Produto"
INSERT Produto VALUES (2,'Monitor LCD 18"','Monitor LCD 18"', 540.00)
INSERT Produto VALUES (3,'Impressora HP Jato de Tinta','Impressora HP Jato de Tinta', 430.00)
INSERT Produto VALUES (4,'Drive SSD 1Tb','Drive SSD 1Tb', 310.00)
INSERT Produto VALUES (5,'Drive SSD 2Tb','Drive SSD 2Tb',590.00)
go

SELECT ProdutoID, Produto_Varchar, Valor_Unitario 
FROM Produto

-- Função REPLACE
SELECT ProdutoID, Produto_Varchar, replace(Produto_Varchar,'Drive','Hard Drive')
FROM Produto

-- Função REPLICATE
SELECT replicate('0',4)

-- Função LEN
SELECT ProdutoID, Produto_Varchar, len(Produto_Varchar) as Tamanho 
FROM Produto

-- Função STR
SELECT str(ProdutoID) + ' - ' + Produto_Varchar as Produto, len(Produto_Varchar) as Tamanho 
FROM Produto

SELECT ltrim(str(ProdutoID)) + ' - ' + Produto_Varchar as Produto, len(Produto_Varchar) as Tamanho 
FROM Produto

-- Coloca Zeros na frente do número
SELECT replicate('0',6 + len(ltrim(str(ProdutoID))) - 2) + ltrim(str(ProdutoID)) as ProdutoID, Produto_Varchar, Valor_Unitario 
FROM Produto

/**************
 Exclui Tabela
***************/
DROP TABLE Produto
