CREATE TABLE Mountains (
    MountainId INT IDENTITY(1,1) PRIMARY KEY,
    MountainName NVARCHAR(100) NOT NULL,
    Height INT NOT NULL,
    Country NVARCHAR(50) NOT NULL
);

--1
CREATE PROCEDURE AddMountain
    @MountainName NVARCHAR(100),
    @Height INT,
    @Country NVARCHAR(50)
AS
BEGIN
    INSERT INTO Mountains (MountainName, Height, Country)
    VALUES (@MountainName, @Height, @Country);
END;

--2
CREATE PROCEDURE AddMountains
    @MountainsToAdd TABLE (
        MountainName NVARCHAR(100),
        Height INT,
        Country NVARCHAR(50)
    )
AS
BEGIN
    INSERT INTO Mountains (MountainName, Height, Country)
    SELECT MountainName, Height, Country
    FROM @MountainsToAdd;
END;

--3
CREATE PROCEDURE GetAllMountains
AS
BEGIN
    SELECT * FROM Mountains;
END;

--4
CREATE PROCEDURE GetMountainById
    @MountainId INT
AS
BEGIN
    SELECT * FROM Mountains WHERE MountainId = @MountainId;
END;

--5
CREATE PROCEDURE DeleteHighestMountain
AS
BEGIN
    DELETE FROM Mountains
    WHERE Height = (SELECT MAX(Height) FROM Mountains);
END;

--6
CREATE PROCEDURE DeleteHighestMountainByCountry
    @Country NVARCHAR(50)
AS
BEGIN
    DELETE FROM Mountains
    WHERE Country = @Country
      AND Height = (SELECT MAX(Height) FROM Mountains WHERE Country = @Country);
END;
