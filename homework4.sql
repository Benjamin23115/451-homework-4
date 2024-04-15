CREATE TABLE
    Flights (
        FlightNumber VARCHAR(6) NOT NULL,
        OriginIATA VARCHAR(3) NOT NULL,
        Capacity INT NOT NULL,
        EstimatedArrival DATE NOT NULL,
        EstimateDeparture DATE NOT NULL,
        DestinationIATA VARCHAR(3) NOT NULL,
        PRIMARY KEY (FlightNumber)
    );

CREATE TABLE
    Schedule (
        ScheduleID INT NOT NULL,
        FlightDate DATE NOT NULL,
        FlightNumber VARCHAR(6) NOT NULL,
        PRIMARY KEY (ScheduleID),
        FOREIGN KEY (FlightNumber) REFERENCES Flights (FlightNumber)
    );

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
        EmployeeTitle VARCHAR(255) NOT NULL,
        PersonID INT NOT NULL,
        PRIMARY KEY (PersonID),
        FOREIGN KEY (PersonID) REFERENCES Person (PersonID)
    );

CREATE TABLE
    Maintenance (
        MaintenanceID INT NOT NULL,
        Date DATE NOT NULL,
        Description VARCHAR(255) NOT NULL,
        PersonID INT,
        PRIMARY KEY (MaintenanceID),
        FOREIGN KEY (PersonID) REFERENCES Employees (PersonID)
    );

CREATE TABLE
    CrewAssignments (
        ScheduleID INT NOT NULL,
        PersonID INT NOT NULL,
        PRIMARY KEY (ScheduleID),
        FOREIGN KEY (PersonID) REFERENCES Employees (PersonID)
    );

CREATE TABLE
    Reservations (
        ReservationNumber INT NOT NULL,
        ReservationDate DATE NOT NULL,
        Fare FLOAT NOT NULL,
        PaymentMethod VARCHAR(5) NOT NULL,
        ScheduleID INT NOT NULL,
        PersonID INT NOT NULL,
        PRIMARY KEY (ReservationNumber, ScheduleID, PersonID),
        FOREIGN KEY (ScheduleID) REFERENCES Schedule (ScheduleID),
        FOREIGN KEY (PersonID) REFERENCES Customer (PersonID)
    );

CREATE TABLE
    Payment (
        PaymentID INT NOT NULL,
        ReservationNumber INT NOT NULL,
        PRIMARY KEY (PaymentID),
        FOREIGN KEY (ReservationNumber) REFERENCES Reservations (ReservationNumber)
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
    Check (
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
    ScheduledFor (
        ScheduleID INT NOT NULL,
        ScheduleID INT NOT NULL,
        PRIMARY KEY (ScheduleID, ScheduleID),
        FOREIGN KEY (ScheduleID) REFERENCES Schedule (ScheduleID),
        FOREIGN KEY (ScheduleID) REFERENCES CrewAssignments (ScheduleID)
    );

CREATE TABLE
    Airplanes (
        AirplaneSerialNumber INT NOT NULL,
        Model VARCHAR(255) NOT NULL,
        Capacity INT NOT NULL,
        NextMaintenanceDate DATE NOT NULL,
        MaintenanceID INT,
        PRIMARY KEY (AirplaneSerialNumber),
        FOREIGN KEY (MaintenanceID) REFERENCES Maintenance (MaintenanceID)
    );