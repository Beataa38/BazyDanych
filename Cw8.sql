use AdventureWorks2019;
-- Zadanie 1
begin
	DECLARE @srednia FLOAT;
	SELECT @srednia = SUM(Rate)/COUNT(Rate) FROM HumanResources.EmployeePayHistory;
	SELECT FirstName, LastName, Rate FROM Person.Person, HumanResources.EmployeePayHistory
		WHERE Person.BusinessEntityID = EmployeePayHistory.BusinessEntityID AND @srednia > Rate;
end;

-- Zadanie 2
GO
CREATE FUNCTION dbo.data_wysylki (@ID_zamowienia INTEGER)
RETURNS DATE
BEGIN
	DECLARE @data DATE;
	SELECT @data = ShipDate FROM Sales.SalesOrderHeader WHERE @ID_zamowienia = SalesOrderID;
	RETURN @data;
END;
GO

SELECT dbo.data_wysylki(43660) AS DataWysy³ki;

-- Zadanie 3
GO
CREATE PROCEDURE dbo.opis_produktu (@nazwa VARCHAR(50))
AS
BEGIN
	SELECT ProductID, ProductNumber, FinishedGoodsFlag FROM Production.Product WHERE @nazwa = Name;
END;
GO

EXEC dbo.opis_produktu @nazwa = "Blade";

-- Zadanie 4
GO
CREATE FUNCTION dbo.numer_karty (@ID_zamowienia INTEGER)
RETURNS NVARCHAR(50)
BEGIN
	DECLARE @numer NVARCHAR(50);
	SELECT @numer = CardNumber FROM Sales.CreditCard, Sales.SalesOrderHeader 
		WHERE SalesOrderID = @ID_zamowienia AND CreditCard.CreditCardID = SalesOrderHeader.CreditCardID;
	RETURN @numer;
END;
GO

SELECT dbo.numer_karty(43660) AS NumerKarty;

-- Zadanie 5
GO
CREATE PROCEDURE dbo.dzielenie (@num1 DECIMAL(10,2), @num2 DECIMAL(10,2), @wynik DECIMAL(10,2) OUTPUT)
AS
BEGIN
	--DECLARE @wynik DECIMAL(10,2);
	if(@num1 > @num2)
		BEGIN
			SET @wynik = (@num1*1.0)/@num2;
			RETURN (@wynik);
		END;
	if (@num1 <= @num2)
		PRINT 'Niew³aœciwie zdefiniowa³eœ dane wejœciowe';
END;
GO

DECLARE @wynik2 DECIMAL(10,2);
EXEC dbo.dzielenie @num1 = 5.0, @num2 = 2.0, @wynik = @wynik2 OUTPUT;
PRINT @wynik2;

-- Zadanie 6
GO
CREATE PROCEDURE dbo.dni (@ID_osoby NVARCHAR(50))
AS
BEGIN
	SELECT JobTitle, VacationHours, SickLeaveHours FROM HumanResources.Employee 
		WHERE @ID_osoby = NationalIDNumber;
END;
GO

EXEC dbo.dni @ID_osoby = '112457891';

-- Zadanie 7
GO
CREATE PROCEDURE dbo.kalkulator_walut (@kwota MONEY, @waluta1 VARCHAR(3), @waluta2 VARCHAR(3), @data DATE OUTPUT, @wynik MONEY OUTPUT)
AS
BEGIN
	if(@waluta1 = 'USD')
		BEGIN
			SET @wynik = (SELECT TOP 1 AverageRate FROM Sales.CurrencyRate 
				WHERE ToCurrencyCode = @waluta2 ORDER BY CurrencyRateID DESC)*@kwota;
			SET @data = (SELECT TOP 1 CurrencyRateDate FROM Sales.CurrencyRate 
				WHERE @waluta2 = ToCurrencyCode ORDER BY CurrencyRateID DESC);
		END;
	if(@waluta2 = 'USD')
		BEGIN
			SET @wynik = @kwota/(SELECT TOP 1 AverageRate FROM Sales.CurrencyRate 
				WHERE ToCurrencyCode = @waluta1 ORDER BY CurrencyRateID DESC);
			SET @data = (SELECT TOP 1 CurrencyRateDate FROM Sales.CurrencyRate 
				WHERE @waluta1 = ToCurrencyCode ORDER BY CurrencyRateID DESC);
		END;
END;
GO

-- z USD na CAD
DECLARE @wynik2 MONEY
DECLARE @data2 DATE
EXEC dbo.kalkulator_walut @kwota = 1400, @waluta1 = 'USD', @waluta2 = 'CAD', @data = @data2 OUTPUT, @wynik = @wynik2 OUTPUT
PRINT @wynik2;
PRINT @data2;

-- z CAD na USD
DECLARE @wynik3 MONEY
DECLARE @data3 DATE
EXEC dbo.kalkulator_walut @kwota = 1400, @waluta1 = 'CAD', @waluta2 = 'USD', @data = @data3 OUTPUT, @wynik = @wynik3 OUTPUT
PRINT @wynik3;
PRINT @data3;

SELECT *  FROM Sales.CurrencyRate;
