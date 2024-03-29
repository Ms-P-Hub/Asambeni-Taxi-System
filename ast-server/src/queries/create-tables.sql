DROP TABLE IF EXISTS Admins CASCADE;
CREATE TABLE Admins
(
    AdminID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Username VARCHAR(10) NOT NULL,
    Phone DECIMAL(13) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS Associations CASCADE;
CREATE TABLE Associations
(
    AssociationID SERIAL PRIMARY KEY,
	AdminID INTEGER NOT NULL,
    Name VARCHAR(50) NOT NULL,
    FOREIGN KEY (AdminID) REFERENCES Admins(AdminID)
);

DROP TABLE IF EXISTS Ranks CASCADE;
CREATE TABLE Ranks
(
    RankID SERIAL PRIMARY KEY,
	AssociationID INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Location VARCHAR(50) NOT NULL,
    FOREIGN KEY (AssociationID) REFERENCES Associations(AssociationID)
);

DROP TABLE IF EXISTS Routes CASCADE;
CREATE TABLE Routes
(
    RouteID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
	RankID INT NOT NULL,
    StartLocation VARCHAR(100) NOT NULL,
    EndLocation VARCHAR(100) NOT NULL,
    FOREIGN KEY (RankID) REFERENCES Ranks(RankID),
    Price DECIMAL(10,2) NOT NULL
);

DROP TABLE IF EXISTS Passengers CASCADE;
CREATE TABLE Passengers
(
    PassengerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Phone DECIMAL(13) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Username VARCHAR(10) NOT NULL,
    Password VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS Owners CASCADE;
CREATE TABLE Owners
(
    OwnerID SERIAL PRIMARY KEY,
	AssociationID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Phone DECIMAL(13) NOT NULL,
    Username VARCHAR(10) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    FOREIGN KEY (AssociationID) REFERENCES Associations(AssociationID)
);

DROP TABLE IF EXISTS Taxis CASCADE;
CREATE TABLE Taxis
(
    TaxiID SERIAL PRIMARY KEY,
	OwnerID INT NOT NULL,
    FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID),
    NumberPlate VARCHAR(10) NOT NULL,
    Model VARCHAR(50) NOT NULL,
    Year INT NOT NULL,
    Color VARCHAR(20) NOT NULL,
    Seats INT NOT NULL,
    Status VARCHAR(20) NOT NULL
);

DROP TABLE IF EXISTS Drivers CASCADE;
CREATE TABLE Drivers
(
    DriverID SERIAL PRIMARY KEY,
	TaxiID INT NOT NULL,
	OwnerID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Phone DECIMAL(13) NOT NULL,
    IDNumber VARCHAR(13) NOT NULL,
    Username VARCHAR(10) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    FOREIGN KEY (TaxiID) REFERENCES Taxis(TaxiID),
    FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID)
);

DROP TABLE IF EXISTS Board CASCADE;
CREATE TABLE Board
(
    BoardID SERIAL PRIMARY KEY,
	OwnerID INT NOT NULL,
	RouteID INT NOT NULL,
    FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID),
    FOREIGN KEY (RouteID) REFERENCES Routes(RouteID),
    Position INT NOT NULL
);

DROP TABLE IF EXISTS Rating CASCADE;
CREATE TABLE Ratings
(
    RatingID SERIAL PRIMARY KEY,
	PassengerID INT NOT NULL,
	DriverID INT NOT NULL,
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID),
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID),
    Rating INT NOT NULL,
    Comment VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS Incidents CASCADE;
CREATE TABLE Incidents
(
    IncidentID SERIAL PRIMARY KEY,
    Description VARCHAR(500) NOT NULL,
    Date TIMESTAMP NOT NULL,
    Status varchar(20) NOT NULL,
	PassengerID INT NOT NULL,
	RouteID INT NOT NULL,
	TaxiID INT NOT NULL,
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID),
    FOREIGN KEY (TaxiID) REFERENCES Taxis(TaxiID),
    FOREIGN KEY (RouteID) REFERENCES Routes(RouteID)
);