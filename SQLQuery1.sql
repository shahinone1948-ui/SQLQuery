 CREATE DATABASE MusicDB;
GO

USE MusicDB;
GO


-- =========================
-- Tables
-- =========================

CREATE TABLE Musician
(
    ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    City VARCHAR(50),
    St VARCHAR(50),
    Phone VARCHAR(20)
);

CREATE TABLE Album
(
    ID INT PRIMARY KEY,
    AlbumDate DATE,
    Title VARCHAR(100),
    MusicianID INT FOREIGN KEY REFERENCES Musician(ID)
);

CREATE TABLE Song
(
    Title VARCHAR(100) PRIMARY KEY,
    Author VARCHAR(50),
    AlbumID INT FOREIGN KEY REFERENCES Album(ID)
);

CREATE TABLE Instrument
(
    Name VARCHAR(50) PRIMARY KEY,
    InstrumentKey VARCHAR(20)
);

CREATE TABLE Musician_Song
(
    MusicianID INT,
    SongTitle VARCHAR(100),
    PRIMARY KEY (MusicianID, SongTitle),
    FOREIGN KEY (MusicianID) REFERENCES Musician(ID),
    FOREIGN KEY (SongTitle) REFERENCES Song(Title)
);

CREATE TABLE Musician_Instrument
(
    MusicianID INT,
    InstrumentName VARCHAR(50),
    PRIMARY KEY (MusicianID, InstrumentName),
    FOREIGN KEY (MusicianID) REFERENCES Musician(ID),
    FOREIGN KEY (InstrumentName) REFERENCES Instrument(Name)
);


-- =========================
-- Insert Data
-- =========================

INSERT INTO Musician (ID, Name, City, St, Phone)
VALUES
(1, 'Ahmed Samir', 'Cairo', 'Nasr City', '01011112222'),
(2, 'Omar Khaled', 'Giza', 'Dokki', '01122223333'),
(3, 'Youssef Ali', 'Alexandria', 'Smouha', '01233334444'),
(4, 'Karim Hassan', 'Mansoura', 'El Gomhoria St', '01544445555');


INSERT INTO Instrument (Name, InstrumentKey)
VALUES
('Guitar', 'GTR'),
('Piano', 'PNO'),
('Drums', 'DRM'),
('Violin', 'VLN');


INSERT INTO Album (ID, AlbumDate, Title, MusicianID)
VALUES
(1, '2024-03-15', 'Elforaq', 1),
(2, '2025-01-20', 'Night Sounds', 1),
(3, '2025-06-10', 'Eastern Vibes', 2),
(4, '2026-10-04', 'Melodies of Cairo', 3);


INSERT INTO Song (Title, Author, AlbumID)
VALUES
('Cairo Nights', 'Ahmed Samir', 1),
('Lost Melody', 'Ahmed Samir', 1),
('Morning Lights', 'Ahmed Samir', 2),
('Desert Wind', 'Omar Khaled', 3),
('Golden Strings', 'Omar Khaled', 3);


INSERT INTO Musician_Song (MusicianID, SongTitle)
VALUES
(1, 'Cairo Nights'),
(1, 'Lost Melody'),
(1, 'Morning Lights'),
(2, 'Cairo Nights'),
(2, 'Desert Wind'),
(3, 'Golden Strings');


INSERT INTO Musician_Instrument (MusicianID, InstrumentName)
VALUES
(1, 'Guitar'),
(1, 'Piano'),
(2, 'Guitar'),
(2, 'Drums'),
(3, 'Violin'),
(4, 'Guitar');


-- =========================
-- Update
-- =========================

UPDATE Musician
SET City = 'Behira'
WHERE ID = 1;

UPDATE Musician
SET Phone = '01198765432'
WHERE ID = 3;

UPDATE Album
SET Title = 'Elhob',
    AlbumDate = '2026-10-06'
WHERE ID = 2;

UPDATE Song
SET Author = 'Amr Diab'
WHERE Title = 'Lost Melody';

UPDATE Instrument
SET InstrumentKey = 'ELEC-GTR'
WHERE Name = 'Guitar';

UPDATE Song
SET AlbumID = 2
WHERE Title = 'Desert Wind';

INSERT INTO Musician_Instrument (MusicianID, InstrumentName)
VALUES (3, 'Piano');


-- =========================
-- Delete
-- =========================

DELETE FROM Musician_Song
WHERE MusicianID = 1
  AND SongTitle = 'Lost Melody';

DELETE FROM Musician_Instrument
WHERE MusicianID = 1
  AND InstrumentName = 'Piano';


-- Delete Song and its relationships
DELETE FROM Musician_Song
WHERE SongTitle = 'Cairo Nights';

DELETE FROM Song
WHERE Title = 'Cairo Nights';


-- Delete Album and its songs
DELETE FROM Musician_Song
WHERE SongTitle IN
(
    SELECT Title
    FROM Song
    WHERE AlbumID = 2
);

DELETE FROM Song
WHERE AlbumID = 2;

DELETE FROM Album
WHERE ID = 2;


-- Delete Musician and dependent records
DELETE FROM Musician_Song
WHERE MusicianID = 3;

DELETE FROM Musician_Instrument
WHERE MusicianID = 3;

DELETE FROM Song
WHERE AlbumID IN
(
    SELECT ID
    FROM Album
    WHERE MusicianID = 3
);

DELETE FROM Album
WHERE MusicianID = 3;

DELETE FROM Musician
WHERE ID = 3;


-- =========================
-- SELECT Practice
-- =========================

-- Basic SELECT

SELECT *
FROM Musician;

SELECT *
FROM Album;

SELECT *
FROM Song;

SELECT *
FROM Instrument;


-- Specific Columns

SELECT Name, City
FROM Musician;

SELECT Title, AlbumDate
FROM Album;

SELECT Title, Author
FROM Song;

SELECT Name, InstrumentKey
FROM Instrument;


-- Aliases

SELECT Name AS [Musician Name]
FROM Musician;

SELECT Title AS [Album Title]
FROM Album;

SELECT Author AS [Song Author]
FROM Song;

SELECT Name + ' - ' + City AS [Musician Info]
FROM Musician;


-- WHERE

SELECT *
FROM Musician
WHERE City = 'Cairo';

SELECT *
FROM Album
WHERE ID > 1;

SELECT *
FROM Song
WHERE Author = 'Ahmed Samir';

SELECT *
FROM Instrument
WHERE InstrumentKey = 'GTR';


-- AND / OR

SELECT *
FROM Musician
WHERE City = 'Cairo'
  AND ID > 1;

SELECT *
FROM Album
WHERE MusicianID = 1
  AND ID > 1;

SELECT *
FROM Song
WHERE Author = 'Ahmed Samir'
  AND AlbumID = 1;

SELECT *
FROM Musician
WHERE City = 'Cairo'
   OR City = 'Giza';

SELECT *
FROM Song
WHERE Author IN ('Ahmed Samir', 'Omar Khaled');

SELECT *
FROM Album
WHERE MusicianID IN (1, 2);


-- IN / NOT IN

SELECT *
FROM Musician
WHERE ID IN (1, 2);

SELECT *
FROM Musician
WHERE ID NOT IN (1, 2);

SELECT *
FROM Album
WHERE MusicianID IN (1, 2);

SELECT *
FROM Song
WHERE AlbumID NOT IN (1, 2);


-- BETWEEN

SELECT *
FROM Album
WHERE ID BETWEEN 1 AND 3;

SELECT *
FROM Musician
WHERE ID BETWEEN 1 AND 3;

SELECT *
FROM Album
WHERE AlbumDate BETWEEN '2024-01-01' AND '2026-12-31';


-- DISTINCT

SELECT DISTINCT City
FROM Musician;

SELECT DISTINCT Author
FROM Song;

SELECT DISTINCT InstrumentKey
FROM Instrument;


-- ORDER BY

SELECT *
FROM Musician
ORDER BY Name ASC;

SELECT *
FROM Musician
ORDER BY Name DESC;

SELECT *
FROM Album
ORDER BY AlbumDate ASC;

SELECT *
FROM Album
ORDER BY AlbumDate DESC;

SELECT *
FROM Song
ORDER BY Title ASC;


-- LIKE

SELECT *
FROM Musician
WHERE Name LIKE 'A%';

SELECT *
FROM Song
WHERE Title LIKE 'C%';

SELECT *
FROM Musician
WHERE Name LIKE '%n';

SELECT *
FROM Song
WHERE Author LIKE '%d';

SELECT *
FROM Musician
WHERE Name LIKE '%ah%';

SELECT *
FROM Song
WHERE Title LIKE '%Night%';

SELECT *
FROM Instrument
WHERE Name LIKE '%G%';


-- NULL / NOT NULL

SELECT *
FROM Musician
WHERE Phone IS NULL;

SELECT *
FROM Musician
WHERE Phone IS NOT NULL;

SELECT *
FROM Musician
WHERE St IS NULL;

SELECT *
FROM Album
WHERE AlbumDate IS NULL;

SELECT *
FROM Song
WHERE Author IS NOT NULL;


-- =========================
-- Mixed Practice
-- =========================

SELECT Name, City
FROM Musician;

SELECT *
FROM Musician
WHERE City = 'Cairo';

SELECT *
FROM Musician
WHERE City = 'Cairo'
  AND ID > 1;

SELECT *
FROM Musician
WHERE City IN ('Cairo', 'Giza');

SELECT *
FROM Musician
WHERE ID IN (1, 2);

SELECT *
FROM Musician
WHERE ID NOT IN (1, 2);

SELECT *
FROM Album
WHERE ID BETWEEN 1 AND 3;

SELECT DISTINCT City
FROM Musician;

SELECT *
FROM Album
ORDER BY AlbumDate ASC;

SELECT *
FROM Album
ORDER BY AlbumDate DESC;

SELECT *
FROM Musician
WHERE Name LIKE 'A%';

SELECT *
FROM Song
WHERE Title LIKE '%s';

SELECT *
FROM Instrument
WHERE Name LIKE '%i%';

SELECT *
FROM Musician
WHERE Phone IS NULL;

SELECT *
FROM Musician
WHERE Phone IS NOT NULL;

SELECT Name AS [Musician Name]
FROM Musician;