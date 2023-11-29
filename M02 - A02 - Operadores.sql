/*************************************************
 Curso T-SQL
 Autor: Landry

 Demonstra��o:
 - Operadores Aritm�ticos
 - Operadores de Copara��o
 - Operador para Concatena��o de Strings
 - Operadores L�gicos
*************************************************/
use master
go

/*******************************************************
 Operadores Aritm�ticos
	+ (Soma)
	- (Subtra��o)
	* (Multiplica��o)
	/ (Divis�o)
	% (M�dulo) - Retorna o resto inteiro de uma divis�o. 
	             Exemplo:  13 % 5 = 3 
		         - Resto da divis�o de 12 por 5 � 3.
********************************************************/

SELECT 20 + 5 as Soma -- 25
SELECT 20 - 5 as Subtra��o -- 15
SELECT 20 * 5 as Multiplica��o -- 100
SELECT 20 / 5 as Divis�o -- 4

SELECT 20 % 5 as Modulo -- 0 (resto da divis�o)
SELECT 13.0 % 5.0 as Modulo -- 3 (resto da divis�o)

/****************************************************************
Operadores de Compara��o
	= (Igual a)
	> (Maior que)
	< (Menor que)
	>= (Maior ou igual a)
	<= (Menor ou igual a)
	<> (Diferente de)
	!= (Diferente de) n�o � padr�o ANSI/ISO
	!< (N�o � menor que) n�o � padr�o ANSI/ISO
	!> (N�o � maior que) n�o � padr�o ANSI/ISO
*****************************************************************/

-- IF
go
DECLARE @Val1 int = 10
DECLARE @Val2 int = 15

IF @Val1 > @Val2 
	print 'Vari�vel 1 maior que vari�vel 2'
ELSE
	print 'Vari�vel 1 menor ou igual a vari�vel 2'
go

-- Se IF necessita de mais de um comando obrigat�rio BEGIN ... END
DECLARE @Val1 int = 10
DECLARE @Val2 int = 5

IF @Val1 > @Val2 
	BEGIN
		print 'Vari�vel 1 maior que vari�vel 2'
		print 'IF com mais de um comando'
	END
ELSE
	BEGIN
		print 'Vari�vel 1 menor ou igual a vari�vel 2'
		print 'IF com mais de um comando'
	END
go

-- WHILE (loop)
go
DECLARE @i int = 1
WHILE @i < 5 BEGIN
	print 'Valor @i = ' + ltrim(str(@i))
	SET @i += 1	
END





