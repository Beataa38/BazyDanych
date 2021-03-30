-- 1. Utworzenie bazy danych o nazwie firma
CREATE DATABASE firma;

-- 2. Dodanie nowego schematu o nazwie rozliczenia
USE firma;
CREATE SCHEMA rozliczenia;

-- 3. Stworzenie tabel do schematu rozliczenia
CREATE TABLE rozliczenia.pracownicy (id_pracownika INTEGER PRIMARY KEY NOT NULL, imiê VARCHAR(30) NOT NULL, nazwisko VARCHAR(30) NOT NULL, adres VARCHAR(50) NOT NULL, telefon VARCHAR(9));
CREATE TABLE rozliczenia.godziny (id_godziny INTEGER PRIMARY KEY NOT NULL, data1 DATE NOT NULL, liczba_godzin INTEGER NOT NULL, id_pracownika INTEGER NOT NULL);
CREATE TABLE rozliczenia.pensje (id_pensji INTEGER PRIMARY KEY NOT NULL, stanowisko VARCHAR(30) NOT NULL, kwota MONEY NOT NULL, id_premii INTEGER NOT NULL);
CREATE TABLE rozliczenia.premie (id_premii INTEGER PRIMARY KEY NOT NULL, rodzaj VARCHAR(30) NOT NULL, kwota MONEY NOT NULL);
ALTER TABLE rozliczenia.godziny ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);
ALTER TABLE rozliczenia.pensje ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);

-- 4. Wype³nienie tabeli rekordami
INSERT INTO rozliczenia.pracownicy VALUES (1, 'Stefan' , 'Gruca', 'Zabrze ul. Czysta 4', '663457321');
INSERT INTO rozliczenia.pracownicy VALUES (2, 'Maria' , 'Buczek', 'Warszawa ul. Maki 22', '553163447');
INSERT INTO rozliczenia.pracownicy VALUES (3, 'Adam' , 'Górski', 'Zielonki ul. Bankowa 36', '764987221');
INSERT INTO rozliczenia.pracownicy VALUES (4, 'Micha³' , 'Drzewiecki', '£ódŸ ul. D¹browskiej 3a', '634551995');
INSERT INTO rozliczenia.pracownicy VALUES (5, 'Katarzyna' , 'Grochola', 'Szczecin ul. W¹ska 2a', '593456772');
INSERT INTO rozliczenia.pracownicy VALUES (6, 'Jan' , 'Dobrzyñski', 'Rabka-Zdrój ul. Podhalska 59', '788563447');
INSERT INTO rozliczenia.pracownicy VALUES (7, 'Wiktoria' , 'Nowak', 'Grybów ul. Równie 84', '521664267');
INSERT INTO rozliczenia.pracownicy VALUES (8, 'Joanna' , 'Filipczak', 'Biecz ul. Kazimierza 11', '799435211');
INSERT INTO rozliczenia.pracownicy VALUES (9, 'Karol' , 'Drabek', 'Radom ul. Sycyñska 29', '511574386');
INSERT INTO rozliczenia.pracownicy VALUES (10, 'Tadeusz' , 'Kowalski', 'Gdañsk ul. Boles³awa Chrobrego 69', '689994124');

INSERT INTO rozliczenia.godziny VALUES (1, '2021-01-24' , 8, 4);
INSERT INTO rozliczenia.godziny VALUES (2, '2021-01-24' , 4, 2);
INSERT INTO rozliczenia.godziny VALUES (3, '2021-01-24' , 12, 8);
INSERT INTO rozliczenia.godziny VALUES (4, '2021-01-24' , 8, 3);
INSERT INTO rozliczenia.godziny VALUES (5, '2021-01-24' , 12, 1);
INSERT INTO rozliczenia.godziny VALUES (6, '2021-01-24' , 4, 6);
INSERT INTO rozliczenia.godziny VALUES (7, '2021-01-24' , 6, 10);
INSERT INTO rozliczenia.godziny VALUES (8, '2021-01-24' , 8, 7);
INSERT INTO rozliczenia.godziny VALUES (9, '2021-01-24' , 4, 5);
INSERT INTO rozliczenia.godziny VALUES (10, '2021-01-24' , 12, 9);

INSERT INTO rozliczenia.pensje VALUES (1, 'menager' , 144, 4);
INSERT INTO rozliczenia.pensje VALUES (2, 'pokojówka' , 72, 2);
INSERT INTO rozliczenia.pensje VALUES (3, 'goniec hotelowy' , 216, 7);
INSERT INTO rozliczenia.pensje VALUES (4, 'menager' , 144, 9);
INSERT INTO rozliczenia.pensje VALUES (5, 'pokojówka' , 216, 1);
INSERT INTO rozliczenia.pensje VALUES (6, 'pokojówka' , 72, 5);
INSERT INTO rozliczenia.pensje VALUES (7, 'goniec hotelowy' , 144, 10);
INSERT INTO rozliczenia.pensje VALUES (8, 'recepcjonista' , 144, 8);
INSERT INTO rozliczenia.pensje VALUES (9, 'recepcjonista' , 96, 3);
INSERT INTO rozliczenia.pensje VALUES (10, 'pokojówka' , 216, 6);

INSERT INTO rozliczenia.premie VALUES (1, 'uznaniowa' , 25);
INSERT INTO rozliczenia.premie VALUES (2, 'uznaniowa' , 5);
INSERT INTO rozliczenia.premie VALUES (3, 'brak' , 0);
INSERT INTO rozliczenia.premie VALUES (4, 'regulaminowa' , 25);
INSERT INTO rozliczenia.premie VALUES (5, 'brak' , 0);
INSERT INTO rozliczenia.premie VALUES (6, 'regulaminowa' , 15);
INSERT INTO rozliczenia.premie VALUES (7, 'uznaniowa' , 10);
INSERT INTO rozliczenia.premie VALUES (8, 'brak' , 0);
INSERT INTO rozliczenia.premie VALUES (9, 'regulaminowa' , 15);
INSERT INTO rozliczenia.premie VALUES (10, 'brak' , 0);

-- 5. Wyœwietlenie nazwisk pracowników i ich adresów
SELECT nazwisko, adres FROM rozliczenia.pracownicy;

-- 6. Przekonwertowanie daty
SELECT DATEPART(weekday, data1 ) FROM rozliczenia.godziny;
SELECT DATEPART(month, data1) FROM rozliczenia.godziny;

-- 7. Modyfikacje w tabeli pensja
EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';
ALTER TABLE rozliczenia.pensje ADD kwota_netto Money;
UPDATE rozliczenia.pensje SET kwota_netto = 0.81 * kwota_brutto;
SELECT * FROM rozliczenia.pensje;
