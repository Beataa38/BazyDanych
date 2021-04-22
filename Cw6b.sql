-- 1. Utworzenie bazy danych o nazwie firma
CREATE DATABASE firma;

-- 2. Dodanie nowego schematu o nazwie ksi�gowo��
USE firma;
CREATE SCHEMA ksiegowosc;

-- 3. Stworzenie tabel do schematu ksiegowosc wraz z kluczami g��wnymi, obcymi, komentarzami
CREATE TABLE ksiegowosc.pracownicy (id_pracownika INTEGER PRIMARY KEY NOT NULL, imi� VARCHAR(30) NOT NULL, nazwisko VARCHAR(30) NOT NULL, adres VARCHAR(50) NOT NULL, telefon VARCHAR(9));
CREATE TABLE ksiegowosc.godziny (id_godziny INTEGER PRIMARY KEY NOT NULL, data DATE NOT NULL, liczba_godzin INTEGER NOT NULL, id_pracownika INTEGER NOT NULL);
CREATE TABLE ksiegowosc.pensje (id_pensji INTEGER PRIMARY KEY NOT NULL, stanowisko VARCHAR(30) NOT NULL, kwota MONEY NOT NULL);
CREATE TABLE ksiegowosc.premie (id_premii INTEGER PRIMARY KEY NOT NULL, rodzaj VARCHAR(30) NOT NULL, kwota MONEY NOT NULL);
CREATE TABLE ksiegowosc.wynagrodzenie (id_wynagrodzenia INTEGER PRIMARY KEY NOT NULL, data DATE NOT NULL, id_pracownika INTEGER NOT NULL, id_godziny INTEGER NOT NULL, 
		id_pensji INTEGER NOT NULL, id_premii INTEGER NOT NULL);
ALTER TABLE ksiegowosc.godziny ADD CONSTRAINT FK_godziny_id_prac FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenie 
	ADD CONSTRAINT FK_wynagrodz_id_prac FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika),
		CONSTRAINT FK_wynagrodz_id_godz FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny),
		CONSTRAINT FK_wynagrodz_id_pen FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensje(id_pensji),
		CONSTRAINT FK_wynagrodz_id_prem FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premie(id_premii);

EXECUTE sp_addextendedproperty 
@name =N'Opis_Tabeli', @value = N'Tabela zawieraj�ca id_pracownika, jego imi�, nazwisko oraz adres i numer telefonu.', 
@level0type = N'SCHEMA', @level0name = N'ksiegowosc',
@level1type = N'TABLE', @level1name = N'pracownicy';

EXECUTE sp_addextendedproperty 
@name =N'Opis_Tabeli', @value = N'Tabela zawieraj�ca id_godziny dla pracowanika o id_pracownika wraz z liczb� godzin oraz dat�.', 
@level0type = N'SCHEMA', @level0name = N'ksiegowosc',
@level1type = N'TABLE', @level1name = N'godziny';

EXECUTE sp_addextendedproperty 
@name =N'Opis_Tabeli', @value = N'Tabela zawieraj�ca id_pensji dla danego stanowiska wraz z kwot� pensji.', 
@level0type = N'SCHEMA', @level0name = N'ksiegowosc',
@level1type = N'TABLE', @level1name = N'pensje';

EXECUTE sp_addextendedproperty 
@name =N'Opis_Tabeli', @value = N'Tabela zawieraj�ca id_premii, jej rodzaj oraz kwot�.', 
@level0type = N'SCHEMA', @level0name = N'ksiegowosc',
@level1type = N'TABLE', @level1name = N'premie';

EXECUTE sp_addextendedproperty 
@name =N'Opis_Tabeli', @value = N'Tabela zawieraj�ca id_wynagrodzenia wraz z dat� oraz powi�zane z ni� id_premii, id_pensji, id_godziny i id_pracownika.', 
@level0type = N'SCHEMA', @level0name = N'ksiegowosc',
@level1type = N'TABLE', @level1name = N'wynagrodzenie';

select * from sys.extended_properties; --wy�wietla wynik

-- 4. Wype�nienie tabeli rekordami
INSERT INTO ksiegowosc.pracownicy VALUES (1, 'Stefan' , 'Gruca', 'Zabrze ul. Czysta 4', '663457321');
INSERT INTO ksiegowosc.pracownicy VALUES (2, 'Maria' , 'Buczek', 'Warszawa ul. Maki 22', '553163447');
INSERT INTO ksiegowosc.pracownicy VALUES (3, 'Adam' , 'G�rski', 'Zielonki ul. Bankowa 36', '764987221');
INSERT INTO ksiegowosc.pracownicy VALUES (4, 'Micha�' , 'Drzewiecki', '��d� ul. D�browskiej 3a', '634551995');
INSERT INTO ksiegowosc.pracownicy VALUES (5, 'Katarzyna' , 'Grochola', 'Szczecin ul. W�ska 2a', '593456772');
INSERT INTO ksiegowosc.pracownicy VALUES (6, 'Jan' , 'Dobrzy�ski', 'Rabka-Zdr�j ul. Podhalska 59', '788563447');
INSERT INTO ksiegowosc.pracownicy VALUES (7, 'Wiktoria' , 'Nowak', 'Gryb�w ul. R�wnie 84', '521664267');
INSERT INTO ksiegowosc.pracownicy VALUES (8, 'Joanna' , 'Filipczak', 'Biecz ul. Kazimierza 11', '799435211');
INSERT INTO ksiegowosc.pracownicy VALUES (9, 'Karol' , 'Drabek', 'Radom ul. Sycy�ska 29', '511574386');
INSERT INTO ksiegowosc.pracownicy VALUES (10, 'Tadeusz' , 'Kowalski', 'Gda�sk ul. Boles�awa Chrobrego 69', '689994124');

INSERT INTO ksiegowosc.godziny VALUES (1, '2021-01-10' , 172, 4);
INSERT INTO ksiegowosc.godziny VALUES (2, '2021-01-10' , 153, 2);
INSERT INTO ksiegowosc.godziny VALUES (3, '2021-01-10' , 161, 8);
INSERT INTO ksiegowosc.godziny VALUES (4, '2021-01-10' , 130, 3);
INSERT INTO ksiegowosc.godziny VALUES (5, '2021-01-10' , 182, 1);
INSERT INTO ksiegowosc.godziny VALUES (6, '2021-01-10' , 80, 6);
INSERT INTO ksiegowosc.godziny VALUES (7, '2021-01-10' , 156, 10);
INSERT INTO ksiegowosc.godziny VALUES (8, '2021-01-10' , 115, 7);
INSERT INTO ksiegowosc.godziny VALUES (9, '2021-01-10' , 172, 5);
INSERT INTO ksiegowosc.godziny VALUES (10, '2021-01-10' , 163, 9);

INSERT INTO ksiegowosc.pensje VALUES (1, 'menager' , 3500);
INSERT INTO ksiegowosc.pensje VALUES (2, 'pokoj�wka' , 1100);
INSERT INTO ksiegowosc.pensje VALUES (3, 'goniec hotelowy' , 1440);
INSERT INTO ksiegowosc.pensje VALUES (4, 'menager' , 3240);
INSERT INTO ksiegowosc.pensje VALUES (5, 'pokoj�wka' , 2800);
INSERT INTO ksiegowosc.pensje VALUES (6, 'pokoj�wka' , 2500);
INSERT INTO ksiegowosc.pensje VALUES (7, 'goniec hotelowy' , 2400);
INSERT INTO ksiegowosc.pensje VALUES (8, 'recepcjonista' , 2900);
INSERT INTO ksiegowosc.pensje VALUES (9, 'recepcjonista' , 3100);
INSERT INTO ksiegowosc.pensje VALUES (10, 'pokoj�wka' , 2300);

INSERT INTO ksiegowosc.premie VALUES (1, 'uznaniowa' , 25);
INSERT INTO ksiegowosc.premie VALUES (2, 'uznaniowa' , 5);
INSERT INTO ksiegowosc.premie VALUES (3, 'brak' , 0);
INSERT INTO ksiegowosc.premie VALUES (4, 'regulaminowa' , 25);
INSERT INTO ksiegowosc.premie VALUES (5, 'brak' , 0);
INSERT INTO ksiegowosc.premie VALUES (6, 'regulaminowa' , 15);
INSERT INTO ksiegowosc.premie VALUES (7, 'uznaniowa' , 10);
INSERT INTO ksiegowosc.premie VALUES (8, 'brak' , 0);
INSERT INTO ksiegowosc.premie VALUES (9, 'regulaminowa' , 15);
INSERT INTO ksiegowosc.premie VALUES (10, 'brak' , 0);

INSERT INTO ksiegowosc.wynagrodzenie 
VALUES  (1, '2021-01-10', 4, 1, 1, 4),
		(2, '2021-01-10', 2, 2, 2, 6),
		(3, '2021-01-10', 8, 3, 3, 3),
		(4, '2021-01-10', 3, 4, 8, 10),
		(5, '2021-01-10', 1, 5, 4, 5),
		(6, '2021-01-10', 6, 6, 10, 9),
		(7, '2021-01-10', 10, 7, 5, 2),
		(8, '2021-01-10', 7, 8, 6, 8),
		(9, '2021-01-10', 5, 9, 7, 7),
		(10, '2021-01-10', 9, 10, 9, 1);

-- 6b Modyfikacja i wy�wietlenie danych
	--a modyfikacja numeru telefonu (dodanie nr kierunkowego)
	ALTER TABLE ksiegowosc.pracownicy ALTER COLUMN telefon VARCHAR(14);
	UPDATE ksiegowosc.pracownicy
		SET telefon = CONCAT('(+48)', telefon); 
	
	SELECT * FROM ksiegowosc.pracownicy;

	--b modyfikacja atrybutu numeru telefonu
	ALTER TABLE ksiegowosc.pracownicy ALTER COLUMN telefon VARCHAR(17);
	UPDATE ksiegowosc.pracownicy
		SET telefon = CONCAT(SUBSTRING(telefon, 1, 8),'-',SUBSTRING(ksiegowosc.pracownicy.telefon, 9, 3), '-', SUBSTRING(ksiegowosc.pracownicy.telefon, 12, 3));
	
	SELECT * FROM ksiegowosc.pracownicy;

	--c wy�wietlenie danych pracownika z najd�u�szym nazwiskiem
	SELECT id_pracownika, imi�, UPPER(nazwisko) AS nazwisko, adres, telefon 
		FROM ksiegowosc.pracownicy 
		WHERE LEN(nazwisko) = (SELECT MAX(LEN(nazwisko)) FROM ksiegowosc.pracownicy);

	--d wy�wietlenie danych pracownik�w i ich pensji (algorytm md5)
	SELECT pracownicy.id_pracownika, HASHBYTES('MD5', imi�) AS imi�, HASHBYTES('MD5', nazwisko) AS nazwisko, HASHBYTES('MD5', adres) AS adres, HASHBYTES('MD5', telefon) AS telefon,
		pensje.id_pensji, HASHBYTES('MD5', stanowisko) AS stanowisko, kwota
		FROM ksiegowosc.pracownicy, ksiegowosc.pensje, ksiegowosc.wynagrodzenie
		WHERE wynagrodzenie.id_pensji = pensje.id_pensji AND wynagrodzenie.id_pracownika = pracownicy.id_pracownika;

	--f Wy�wietlenie pracownik�w, pensji, premii (z��czenie lewostronne)
	SELECT pracownicy.id_pracownika, pracownicy.imi�, pracownicy.nazwisko, pensje.kwota AS pensja, premie.kwota AS premia 
		FROM ksiegowosc.pracownicy
		LEFT JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pensji = pracownicy.id_pracownika
		LEFT JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
		LEFT JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii;

	--g Generowanie raportu
	SELECT CONCAT('Pracownik ', pracownicy.imi�, ' ', pracownicy.nazwisko, ', w dniu ', DAY(wynagrodzenie.data), '.0', MONTH(wynagrodzenie.data),'.', YEAR(wynagrodzenie.data), 
		' otrzyma� pensj� ca�kowit� na kwot� ', FORMAT(pensje.kwota + premie.kwota, 'N0'), ' z�, gdzie wynagrodzenie zasadnicze wynosi�o: ', 
		FORMAT((pensje.kwota - (godziny.liczba_godzin-160)*(pensje.kwota/godziny.liczba_godzin)), 'N0'), ' z�, premia: ', FORMAT(premie.kwota, 'N0'), ' z�, nadgodziny: ', 
		FORMAT((godziny.liczba_godzin-160)*(pensje.kwota/godziny.liczba_godzin), 'N0'), ' z�') AS raport
		FROM ksiegowosc.pracownicy
		LEFT JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pensji = pracownicy.id_pracownika
		LEFT JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
		LEFT JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii
		LEFT JOIN ksiegowosc.godziny ON wynagrodzenie.id_godziny = godziny.id_godziny
		WHERE godziny.liczba_godzin > 160
	UNION
	SELECT CONCAT('Pracownik ', pracownicy.imi�, ' ', pracownicy.nazwisko, ', w dniu ', DAY(wynagrodzenie.data), '.0', MONTH(wynagrodzenie.data),'.', YEAR(wynagrodzenie.data), 
		' otrzyma� pensj� ca�kowit� na kwot� ', FORMAT(pensje.kwota + premie.kwota, 'N0'), ' z�, gdzie wynagrodzenie zasadnicze wynosi�o: ', 
		FORMAT((pensje.kwota - (godziny.liczba_godzin-160)*(pensje.kwota/godziny.liczba_godzin)), 'N0'), ' z�, premia: ', FORMAT(premie.kwota, 'N0'), ' z�, nadgodziny: ', '0 z�') AS raport
		FROM ksiegowosc.pracownicy
		LEFT JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pensji = pracownicy.id_pracownika
		LEFT JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
		LEFT JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii
		LEFT JOIN ksiegowosc.godziny ON wynagrodzenie.id_godziny = godziny.id_godziny
		WHERE godziny.liczba_godzin <= 160 ;
