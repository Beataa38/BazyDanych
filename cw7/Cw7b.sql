--Zadanie 1
--Stworzenie funkcji dla ci¹gu
CREATE OR ALTER FUNCTION dbo.generowanie_cg_fib
(@n AS INTEGER)
RETURNS INT
AS
BEGIN
DECLARE @i  AS INTEGER;
	IF @n = 0 SET @i = 0;
	IF @n = 1 SET @i = 1;
	IF @n > 1 SET @i = dbo.generowanie_cg_fib(@n-1) + dbo.generowanie_cg_fib(@n-2);
	RETURN @i;
END;
GO

--Procedura wypisuj¹ca elementy ci¹gu
CREATE OR ALTER PROCEDURE dbo.wypisanie_cg_fib 
(@n AS INTEGER)
AS
BEGIN
	DECLARE @i AS INTEGER  = 0;
	WHILE @i < @n
	BEGIN
	PRINT dbo.generowanie_cg_fib(@i);
	SET @i = @i +1;
	END;
END;
GO

--Wywo³anie procedury
EXECUTE dbo.wypisanie_cg_fib @n = 4;

--Zadanie 2
USE AdventureWorks2019;
GO
CREATE TRIGGER up_nazwisko ON AdventureWorks2019.Person.Person
AFTER INSERT
AS
BEGIN
	IF @@ROWCOUNT = 0 RETURN SET NOCOUNT ON;
	UPDATE Person.Person
	SET LastName = Upper(Person.LastName) FROM inserted Where Person.BusinessEntityID = inserted.BusinessEntityID;
END;
GO

--Wstawienie nowego wiersza
SET IDENTITY_INSERT AdventureWorks2019.Person.BusinessEntity ON
INSERT INTO AdventureWorks2019.Person.BusinessEntity (BusinessEntityID, rowguid, ModifiedDate) 
	VALUES (20778, '3BB0243E-11A3-4E5C-8DB5-6B927C71432E', 
	SYSDATETIME());
INSERT INTO Person.Person VALUES (20778, 'IN', 0, 'Mr.', 'Mark', NULL, 
	'Jonson', NULL, 0, NULL, NULL, '3BB0243E-11A3-4E5C-8DB5-6B927C71432E', SYSDATETIME());
SET IDENTITY_INSERT AdventureWorks2019.Person.BusinessEntity OFF
--Wyœwietlenie tabel w których nast¹pi³y zmiany
SELECT * FROM Person.Person;
SELECT * FROM Person.BusinessEntity;

--Usuniêcie nowych wierszy
DELETE FROM Person.Person WHERE BusinessEntityID = 20778;
DELETE FROM Person.BusinessEntity WHERE BusinessEntityID = 20778;

--przywrócenie wygl¹du danych przed zmian¹
UPDATE Person.Person
SET LastName = UPPER(SUBSTRING(LastName, 1, 1))+SUBSTRING(Lower(LastName), 2, 100);

--Zadanie 3
SELECT * FROM Sales.SalesTaxRate;

USE AdventureWorks2019;
GO
CREATE TRIGGER taxRateMonitoring ON AdventureWorks2019.Sales.SalesTaxRate
AFTER UPDATE, INSERT
AS
BEGIN
	DECLARE @ilosc INTEGER
	SELECT @ilosc = COUNT(inserted.TaxRate) FROM inserted, Sales.SalesTaxRate 
		WHERE ((inserted.TaxRate > Sales.SalesTaxRate.TaxRate*1.3) OR (inserted.TaxRate < Sales.SalesTaxRate.TaxRate*0.7)) 
			AND (inserted.SalesTaxRateID = Sales.SalesTaxRate.SalesTaxRateID); --nie znajduje
	IF @ilosc > 0 
		PRINT 'Za wysoka wartoœæ TaxRate'
	PRINT @ilosc
END;
GO

--Zmiana danych aby wywo³aæ trigfger
UPDATE Sales.SalesTaxRate
SET TaxRate = 31.0 WHERE TaxRate = 19.60; --powinien wyskoczyÆ alert

UPDATE Sales.SalesTaxRate
SET TaxRate = 21.0 WHERE TaxRate = 19.60; --nie powinno byæ alertu

--Wyœwietlenie danych
SELECT TaxRate FROM AdventureWorks2019.Sales.SalesTaxRate;

--Przywrócenie danych
UPDATE Sales.SalesTaxRate
SET TaxRate = 19.6 WHERE TaxRate = 31.0;

UPDATE Sales.SalesTaxRate
SET TaxRate = 19.6 WHERE TaxRate = 21.0;

SELECT * FROM AdventureWorks2019.Sales.SalesTaxRate;
