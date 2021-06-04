CREATE DATABASE schematy;
USE schematy;

-- schemat znormalizowany (p³atek œniegu)
CREATE TABLE GeoEon (id_eon int NOT NULL PRIMARY KEY, nazwa_eon varchar(10));
CREATE TABLE GeoEra (id_era int NOT NULL PRIMARY KEY, 
	id_eon int NOT NULL FOREIGN KEY REFERENCES GeoEon(id_eon), nazwa_era varchar(9));
CREATE TABLE GeoOkres (id_okres int NOT NULL PRIMARY KEY, 
	id_era int NOT NULL FOREIGN KEY REFERENCES GeoEra(id_era), nazwa_okres varchar(24));
CREATE TABLE GeoEpoka (id_epoka int NOT NULL PRIMARY KEY, 
	id_okres int NOT NULL FOREIGN KEY REFERENCES GeoOkres(id_okres), nazwa_epoka varchar(10));
CREATE TABLE GeoPietro (id_pietro int NOT NULL PRIMARY KEY, 
	id_epoka int NOT NULL FOREIGN KEY REFERENCES GeoEpoka(id_epoka), nazwa_pietro varchar(14));

INSERT INTO GeoEon VALUES (1, 'FANEROZOIK');
INSERT INTO GeoEra VALUES (1, 1, 'Kanezoik'),
							(2, 1, 'Mezozoik'),
							(3, 1, 'Palezoik');
INSERT INTO GeoOkres VALUES (1, 1, 'Czwartorz¹d'),
							(2, 1, 'Trzeciorz¹d, Neogen'),
							(3, 1, 'Trzeciorz¹d, Paleogen'),
							(4, 2, 'Kreda'),
							(5, 2, 'Jura'),
							(6, 2, 'Trias'),
							(7, 3, 'Perm'),
							(8, 3, 'Karbon'),
							(9, 3, 'Dewon');
INSERT INTO GeoEpoka VALUES (1, 1, 'Halocen'),
							(2, 1, 'Plejstocen'),
							(3, 2, 'Pliocen'),
							(4, 2, 'Miocen'),
							(5, 3, 'Oligocen'),
							(6, 3, 'Eocen'),
							(7, 3, 'Paleocen'),
							(8, 4, 'Górna'),
							(9, 4, 'Dolna'),
							(10, 5, 'Górna'),
							(11, 5, 'Œrodkowa'),
							(12, 5, 'Dolna'),
							(13, 6, 'Górny'),
							(14, 6, 'Œrodkowy'),
							(15, 6, 'Dolny'),
							(16, 7, 'Górny'),
							(17, 7, 'Dolny'),
							(18, 8, 'Górny'),
							(19, 8, 'Dolny'),
							(20, 9, 'Górny'),
							(21, 9, 'Œrodkowy'),
							(22, 9, 'Dolny');
INSERT INTO GeoPietro VALUES (1, 1, 'megalaj'),
							(2, 1, 'nortgryp'),
							(3, 1, 'grenland'),
							(4, 2, 'chiban'),
							(5, 2, 'kalabr'),
							(6, 3, 'piacent'),
							(7, 3, 'zankl'),
							(8, 4, 'messyn'),
							(9, 4,  'torton'),
							(10, 4, 'serrawal'),
							(11, 4, 'lang'),
							(12, 4, 'burdyga³'),
							(13, 4, 'akwitan'),
							(14, 5, 'szat'),
							(15, 6, 'priabon'),
							(16, 6, 'barton'),
							(17, 6, 'lutet'),
							(18, 6, 'iprez'),
							(19, 7, 'tanet'),
							(20, 7, 'zeland'),
							(21, 7, 'dan'),
							(22, 8, 'mastrycht'),
							(23, 8, 'kampan'),
							(24, 8, 'santon'),
							(25, 8, 'koniak'),
							(26, 8, 'turon'),
							(27, 8, 'cenoman'),
							(28, 9, 'alb'),
							(29, 9, 'apt'),
							(30, 9, 'barrem'),
							(31, 9, 'hoteryw'),
							(32, 9, 'walan¿yn'),
							(33, 9, 'berrias'),
							(34, 10, 'tyton'),
							(35, 10, 'kimeryd'),
							(36, 10, 'oksford'),
							(37, 11, 'kelowej'),
							(38, 11, 'baton'),
							(39, 11, 'bajos'),
							(40, 11, 'aalen'),
							(41, 12, 'toark'),
							(42, 12, 'pliensbach'),
							(43, 12, 'synemur'),
							(44, 12, 'hettang'),
							(45, 13, 'retyk'),
							(46, 13, 'noryk'),
							(47, 13, 'karnik'),
							(48, 14, 'ladyn'),
							(49, 14, 'anizyk'),
							(50, 15, 'olenek'),
							(51, 15, 'ind'),
							(52, 16, 'czangsing'),
							(53, 16, 'wucziaping'),
							(54, 16, 'kapitan'),
							(55, 16, 'word'),
							(56, 16, 'road'),
							(57, 17, 'kangur'),
							(58, 17, 'artinsk'),
							(59, 17, 'sakmar'),
							(60, 17, 'assel'),
							(61, 18, 'g¿el'),
							(62, 18, 'kasimow'),
							(63, 18, 'moskow'),
							(64, 18, 'baszkir'),
							(65, 19, 'serpuchow'),
							(66, 19, 'wizen'),
							(67, 19, 'turnej'),
							(68, 20, 'famen'),
							(69, 20, 'fran'),
							(70, 21, '¿ywet'),
							(71, 21, 'eifel'),
							(72, 22, 'ems'), 
							(73, 22, 'prag'),
							(74, 22, 'lochkow');


-- schemat zdenormalizowany (gwiazda)
SELECT GeoPietro.id_pietro, GeoPietro.nazwa_pietro, GeoEpoka.id_epoka, GeoEpoka.nazwa_epoka, 
	GeoOkres.id_okres, GeoOkres.nazwa_okres, GeoEra.id_era, GeoEra.nazwa_era, GeoEon.id_eon, 
	GeoEon.nazwa_eon 
	INTO GeoTabela FROM GeoPietro 
	INNER JOIN GeoEpoka ON GeoPietro.id_epoka=GeoEpoka.id_epoka 
	INNER JOIN GeoOkres ON GeoOkres.id_okres=GeoEpoka.id_okres 
	INNER JOIN GeoEra ON GeoEra.id_era = GeoOkres.id_era 
	INNER JOIN GeoEon ON GeoEon.id_eon = GeoEra.id_eon;

SELECT * FROM GeoTabela;

-- tabela Milion
CREATE TABLE Dziesiec (cyfra int, bit int);
INSERT INTO Dziesiec VALUES (0, 0000),
							(1, 0001),
							(2, 0010),
							(3, 0011),
							(4, 0100),
							(5, 0101),
							(6, 0110),
							(7, 0111),
							(8, 1000),
							(9, 1001);

CREATE TABLE Milion (liczba int, cyfra int, bit int);

INSERT INTO Milion 
	SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra + 10000*a5.cyfra + 10000*a6.cyfra AS liczba, 
	a1.cyfra AS cyfra, 
	a1.bit AS bit
	FROM Dziesiec a1, Dziesiec a2, Dziesiec a3, Dziesiec a4, Dziesiec a5, Dziesiec a6;

SELECT * FROM Milion;

-- Zapytanie 1
SET STATISTICS IO, TIME ON 
DBCC FREEPROCCACHE; 
DBCC DROPCLEANBUFFERS; 
CHECKPOINT
GO
SELECT COUNT(*) FROM Milion INNER JOIN GeoTabela ON ((Milion.liczba%68)=(GeoTabela.id_pietro));

-- indeks do zapytañ
CREATE INDEX zap1 ON GeoTabela(id_pietro);
CREATE INDEX milion_idx ON Milion(liczba);

-- Zapytanie 2
SET STATISTICS IO, TIME ON 
DBCC FREEPROCCACHE; 
DBCC DROPCLEANBUFFERS; 
CHECKPOINT
GO
SELECT COUNT(*) FROM Milion INNER JOIN GeoPietro ON ((Milion.liczba%68)=GeoPietro.id_pietro) 
INNER JOIN GeoEpoka ON GeoEpoka.id_epoka=GeoPietro.id_epoka 
	INNER JOIN GeoOkres ON GeoOkres.id_okres=GeoEpoka.id_okres 
	INNER JOIN GeoEra ON GeoEra.id_era=GeoOkres.id_era 
	INNER JOIN GeoEon ON GeoEon.id_eon=GeoEra.id_eon;

-- dzia³aj¹ te same indeksy co w zapytaniu 1

-- Zapytanie 3
SET STATISTICS IO, TIME ON 
DBCC FREEPROCCACHE; 
DBCC DROPCLEANBUFFERS; 
CHECKPOINT
GO
SELECT COUNT(*) FROM Milion WHERE (Milion.liczba%68)=(SELECT id_pietro FROM GeoTabela WHERE (Milion.liczba%68)=(id_pietro));

-- Zapytanie 4
SET STATISTICS IO, TIME ON 
DBCC FREEPROCCACHE; 
DBCC DROPCLEANBUFFERS; 
CHECKPOINT
GO
SELECT COUNT(*) FROM Milion WHERE (Milion.liczba%68)=(SELECT GeoPietro.id_pietro FROM GeoPietro 
	INNER JOIN GeoEpoka ON GeoEpoka.id_epoka=GeoPietro.id_epoka 
	INNER JOIN GeoOkres ON GeoOkres.id_okres=GeoEpoka.id_okres
	INNER JOIN GeoEra ON GeoEra.id_era=GeoOkres.id_era
	INNER JOIN GeoEon ON GeoEon.id_eon=GeoEra.id_eon WHERE (Milion.liczba%68)=(GeoPietro.id_pietro));

SELECT	Milion.liczba%68 FROM Milion;

