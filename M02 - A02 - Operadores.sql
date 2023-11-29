/*************************************************
 Curso T-SQL
 Autor: Landry

 Demonstração:
 - Operadores Aritméticos
 - Operadores de Coparação
 - Operador para Concatenação de Strings
 - Operadores Lógicos
*************************************************/
use master
go

/*******************************************************
 Operadores Aritméticos
	+ (Soma)
	- (Subtração)
	* (Multiplicação)
	/ (Divisão)
	% (Módulo) - Retorna o resto inteiro de uma divisão. 
	             Exemplo:  13 % 5 = 3 
		         - Resto da divisão de 12 por 5 é 3.
********************************************************/

SELECT 20 + 5 as Soma -- 25
SELECT 20 - 5 as Subtração -- 15
SELECT 20 * 5 as Multiplicação -- 100
SELECT 20 / 5 as Divisão -- 4

SELECT 20 % 5 as Modulo -- 0 (resto da divisão)
SELECT 13.0 % 5.0 as Modulo -- 3 (resto da divisão)

/****************************************************************
Operadores de Comparação
	= (Igual a)
	> (Maior que)
	< (Menor que)
	>= (Maior ou igual a)
	<= (Menor ou igual a)
	<> (Diferente de)
	!= (Diferente de) não é padrão ANSI/ISO
	!< (Não é menor que) não é padrão ANSI/ISO
	!> (Não é maior que) não é padrão ANSI/ISO
*****************************************************************/

-- IF
go
DECLARE @Val1 int = 10
DECLARE @Val2 int = 15

IF @Val1 > @Val2 
	print 'Variável 1 maior que variável 2'
ELSE
	print 'Variável 1 menor ou igual a variável 2'
go

-- Se IF necessita de mais de um comando obrigatório BEGIN ... END
DECLARE @Val1 int = 10
DECLARE @Val2 int = 5

IF @Val1 > @Val2 
	BEGIN
		print 'Variável 1 maior que variável 2'
		print 'IF com mais de um comando'
	END
ELSE
	BEGIN
		print 'Variável 1 menor ou igual a variável 2'
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





