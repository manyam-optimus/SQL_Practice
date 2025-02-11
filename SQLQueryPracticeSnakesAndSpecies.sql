CREATE TABLE Species(
SpeciesID INT PRIMARY KEY ,
CommonName NVARCHAR(100) NOT NULL,
ScientificName NVARCHAR(100) NOT NULL,
Habitat NVARCHAR(100) NOT NULL,
Venomous Bit NOT NULL
)

CREATE TABLE Snakes(
SnakeID INT PRIMARY KEY,
SpeciesID INT NOT NULL,
Length DECIMAL(5,2) NOT NULL,
Age INT NOT NULL,
Color NVARCHAR(20) NOT NULL,
CONSTRAINT fk_Snakes_SpeciesID FOREIGN KEY(SpeciesID) REFERENCES Species(SpeciesID)
)

CREATE TABLE Sightings(
SightingID INT PRIMARY KEY,
SnakeID INT NOT NULL,
Location NVARCHAR(255) NOT NULL,
SightingDate DATE NOT NULL,
Observer NVARCHAR(100) NOT NULL,
CONSTRAINT fk_SnakeID FOREIGN KEY(SnakeID) REFERENCES Snakes(SnakeID)
)

CREATE TABLE ConservationStatus(
StatusID INT PRIMARY KEY,
SpeciesID INT NOT NULL,
Status NVARCHAR(255),
LastUpdated DATE NOT NULL
CONSTRAINT fk_Conservation_SpeciesID FOREIGN KEY(SpeciesID) REFERENCES Species(SpeciesID)
)

INSERT INTO Species (SpeciesID, CommonName, ScientificName, Habitat, Venomous) VALUES
(1, 'King Cobra', 'Ophiophagus hannah', 'Forests', 1),
(2, 'Green Anaconda', 'Eunectes murinus', 'Swamps and Rivers', 0),
(3, 'Western Diamondback Rattlesnake', 'Crotalus atrox', 'Deserts and Grasslands', 1),
(4, 'Corn Snake', 'Pantherophis guttatus', 'Woodlands and Farmlands', 0),
(5, 'Black Mamba', 'Dendroaspis polylepis', 'Savannas and Rocky Hills', 1);

INSERT INTO Snakes (SnakeID, SpeciesID, Length, Age, Color) VALUES
(1, 1, 3.7, 5, 'Brown'),
(2, 2, 5.5, 8, 'Green'),
(3, 3, 1.5, 3, 'Gray'),
(4, 4, 1.2, 2, 'Orange'),
(5, 5, 2.8, 6, 'Black');

INSERT INTO Sightings (SightingID, SnakeID, Location, SightingDate, Observer) VALUES
(1, 1, 'Everglades National Park, FL', '2024-01-10', 'John Doe'),
(2, 2, 'Amazon Rainforest, Brazil', '2024-02-05', 'Maria Gonzalez'),
(3, 3, 'Sonoran Desert, AZ', '2024-03-15', 'David Smith'),
(4, 4, 'Blue Ridge Mountains, NC', '2024-04-20', 'Emily White'),
(5, 5, 'Kruger National Park, South Africa', '2024-05-08', 'James Carter');

INSERT INTO ConservationStatus (StatusID, SpeciesID, Status, LastUpdated) VALUES
(1, 1, 'Vulnerable', '2023-12-15'),
(2, 2, 'Least Concern', '2023-11-20'),
(3, 3, 'Near Threatened', '2023-10-05'),
(4, 4, 'Not Evaluated', '2023-09-25'),
(5, 5, 'Endangered', '2023-08-12');

INSERT INTO Snakes (SnakeID, SpeciesID, Length, Age, Color) VALUES
(6, 1, 3.2, 4, 'Dark Brown'),  
(7, 1, 4.0, 6, 'Brown'),       
(8, 3, 1.8, 4, 'Gray'),        
(9, 5, 2.5, 5, 'Black'),       
(10, 2, 5.7, 9, 'Green');     

INSERT INTO Sightings (SightingID, SnakeID, Location, SightingDate, Observer) VALUES
(6, 1, 'Sundarbans, India', '2024-06-12', 'Amit Roy'),  
(7, 6, 'Everglades National Park, FL', '2024-06-15', 'Emily White'),  
(8, 3, 'Mojave Desert, CA', '2024-07-05', 'Michael Brown'),  
(9, 8, 'Arizona Desert, AZ', '2024-07-20', 'Sarah Connor'),  
(10, 5, 'Kruger National Park, South Africa', '2024-08-08', 'James Carter');  

INSERT INTO ConservationStatus (StatusID, SpeciesID, Status, LastUpdated) VALUES
(6, 1, 'Endangered', '2024-01-05'),  
(7, 3, 'Threatened', '2024-02-10'),  
(8, 5, 'Critical', '2024-03-15');   

INSERT INTO Sightings (SightingID, SnakeID, Location, SightingDate, Observer) VALUES
(11, 2, 'Amazon Rainforest, Brazil', '2024-06-10', 'Maria Gonzalez'),  
(12, 3, 'Sonoran Desert, AZ', '2024-07-12', 'David Smith'),  
(13, 5, 'Kruger National Park, South Africa', '2024-07-18', 'James Carter'),  
(14, 1, 'Everglades National Park, FL', '2024-08-05', 'John Doe'),  
(15, 4, 'Blue Ridge Mountains, NC', '2024-09-10', 'Emily White'),  
(16, 6, 'Everglades National Park, FL', '2024-06-20', 'John Doe'),  
(17, 7, 'Sundarbans, India', '2024-06-22', 'Amit Roy'),  
(18, 9, 'Kruger National Park, South Africa', '2024-07-05', 'James Carter'),  
(19, 8, 'Arizona Desert, AZ', '2024-08-15', 'Sarah Connor'),  
(20, 10, 'Amazon Rainforest, Brazil', '2024-09-22', 'Maria Gonzalez');  


SELECT * FROM Species;
SELECT * FROM Snakes;
SELECT * FROM Sightings;
SELECT * FROM ConservationStatus;

--Q1. Retrieve all sightings of a specific species by common name.
	DECLARE @CommonName NVARCHAR(100) = 'King Cobra';
	SELECT sp.SpeciesID,si.SightingID,si.Location,si.SightingDate,si.Observer FROM Species sp JOIN Snakes s 
		ON sp.SpeciesID=s.SpeciesID JOIN Sightings si ON s.SnakeID=si.SnakeID WHERE sp.CommonName = @CommonName;

--Q2. Find the average length of snakes by species.
	SELECT sp.SpeciesID,sp.CommonName,sp.ScientificName,AVG(s.Length) AS AvgLength from Species sp JOIN Snakes s
	ON sp.SpeciesID = s.SpeciesID  GROUP BY sp.SpeciesID,sp.CommonName,sp.ScientificName;

--Q3. Find the top 5 longest snakes for each species.
	WITH Snakes_of_Species
	AS(SELECT s.SpeciesID, s.SnakeID ,s.Length, DENSE_RANK() OVER (PARTITION BY s.SpeciesID ORDER BY s.Length desc)
	AS RankOfSnake FROM Snakes s)
	SELECT s.SpeciesID,s.SnakeID,s.Length from Snakes_of_Species s WHERE s.RankOfSnake<=5;

--Q4. Identify the observer who has seen the highest number of different species.
	SELECT TOP 1 si.Observer, COUNT(DISTINCT s.SpeciesID) as SpeciesCount FROM Sightings si 
	JOIN Snakes s ON si.SnakeID = s.SnakeID 
	GROUP BY si.Observer ORDER BY SpeciesCount desc;

--Q5. Determine the change in conservation status for species over time.
	SELECT c.SpeciesID,sp.CommonName, sp.ScientificName,c.Status,c.LastUpdated FROM Species sp 
	JOIN ConservationStatus c ON sp.SpeciesID = c.SpeciesID 
	GROUP BY c.SpeciesID,sp.CommonName, sp.ScientificName,c.Status,c.LastUpdated
	ORDER BY c.SpeciesID,c.LastUpdated;

--Q6. List species that are classified as "Endangered" and have been sighted more than 10 times.
	SELECT s.CommonName, s.ScientificName, s.Habitat, s.Venomous, c.SpeciesID ,COUNT(si.SightingID) AS SightingsCount 
	FROM Species s JOIN ConservationStatus c ON s.SpeciesID = c.SpeciesID 
	JOIN Snakes sn ON sn.SpeciesID = c.SpeciesID 
	JOIN Sightings si ON sn.SnakeID = si.SnakeID 
	GROUP BY s.CommonName, s.ScientificName, s.Habitat, s.Venomous, c.SpeciesID
	HAVING COUNT(si.SightingID) > 10;

 
