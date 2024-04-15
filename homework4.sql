-- Washington State University: CptS451
-- Spring 2024 Semester
-- Student: Benjamin Farias Dela Mora
-- Assignment: Homework 04
-- Operating System: MS Windows
CREATE DATABASE fbno_BFDM;

USE fbno_BFDM;

CREATE TABLE
    Person (
        PersonID INT NOT NULL,
        PersonFirstName VARCHAR(255) NOT NULL,
        PersonLastName VARCHAR(255) NOT NULL,
        PersonPhoneNumber INT NOT NULL,
        PRIMARY KEY (PersonID)
    );

CREATE TABLE
    Customer (
        PersonID INT NOT NULL,
        PRIMARY KEY (PersonID),
        FOREIGN KEY (PersonID) REFERENCES Person (PersonID)
    );

CREATE TABLE
    Employees (
        EmployeeTitle INT NOT NULL,
        PersonID INT NOT NULL,
        PRIMARY KEY (PersonID),
        FOREIGN KEY (PersonID) REFERENCES Person (PersonID)
    );

CREATE TABLE
    Flights (
        FlightNumber VARCHAR(6) NOT NULL,
        OriginIATA VARCHAR(3) NOT NULL,
        Capacity INT NOT NULL,
        EstimatedArrival TIME NOT NULL,
        EstimateDeparture TIME NOT NULL,
        DestinationIATA VARCHAR(3) NOT NULL,
        PRIMARY KEY (FlightNumber)
    );

CREATE TABLE
    Airplanes (
        AirplaneSerialNumber VARCHAR(255) NOT NULL,
        Model VARCHAR(255) NOT NULL,
        Capacity INT NOT NULL,
        NextMaintenanceDate DATE NOT NULL,
        PRIMARY KEY (AirplaneSerialNumber)
    );

CREATE TABLE
    MaintenanceRecords (
        MaintenanceID INT NOT NULL AUTO_INCREMENT,
        Date DATE NOT NULL,
        Description VARCHAR(255) NOT NULL,
        AirplaneSerialNumber VARCHAR(255),
        FOREIGN KEY (AirplaneSerialNumber) REFERENCES Airplanes (AirplaneSerialNumber),
        PRIMARY KEY (MaintenanceID)
    );

CREATE TABLE
    Schedule (
        ScheduleID INT NOT NULL AUTO_INCREMENT,
        FlightDate DATE NOT NULL,
        FlightNumber VARCHAR(6) NOT NULL,
        PRIMARY KEY (ScheduleID),
        FOREIGN KEY (FlightNumber) REFERENCES Flights (FlightNumber)
    );

CREATE TABLE
    Reservations (
        ReservationID INT NOT NULL AUTO_INCREMENT,
        ReservationDate DATE NOT NULL,
        Fare DECIMAL NOT NULL,
        PaymentMethod VARCHAR(5) NOT NULL,
        ScheduleID INT NOT NULL,
        PersonID INT NOT NULL,
        FOREIGN KEY (ScheduleID) REFERENCES Schedule (ScheduleID),
        FOREIGN KEY (PersonID) REFERENCES Person (PersonID),
        PRIMARY KEY (ReservationID)
    );

CREATE TABLE
    Payment (
        PaymentID INT NOT NULL AUTO_INCREMENT,
        ReservationID INT NOT NULL,
        FOREIGN KEY (ReservationID) REFERENCES Reservations (ReservationID),
        PRIMARY KEY (PaymentID)
    );

CREATE TABLE
    Card (
        CardExpirationDate DATE NOT NULL,
        CardNo INT NOT NULL,
        PaymentID INT NOT NULL,
        PRIMARY KEY (PaymentID),
        FOREIGN KEY (PaymentID) REFERENCES Payment (PaymentID)
    );

CREATE TABLE
    CheckPayment (
        PaymentID INT NOT NULL,
        PRIMARY KEY (PaymentID),
        FOREIGN KEY (PaymentID) REFERENCES Payment (PaymentID)
    );

CREATE TABLE
    Cash (
        PaymentID INT NOT NULL,
        PRIMARY KEY (PaymentID),
        FOREIGN KEY (PaymentID) REFERENCES Payment (PaymentID)
    );

CREATE TABLE
    CrewAssignments (
        ScheduleID INT NOT NULL,
        PersonID INT NOT NULL,
        FOREIGN KEY (ScheduleID) REFERENCES Schedule (ScheduleID),
        FOREIGN KEY (PersonID) REFERENCES Person (PersonID),
        PRIMARY KEY (ScheduleID, PersonID)
    );