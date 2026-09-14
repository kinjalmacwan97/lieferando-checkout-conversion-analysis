
USE master;
GO

-- Drop and recreate the 'lieferandoAnalysis' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'lieferandoAnalysis')
BEGIN
    ALTER DATABASE lieferandoAnalysis SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE lieferandoAnalysis;
END;
GO
---- Create the 'lieferandoAnalysis' database
CREATE DATABASE lieferandoAnalysis;
GO

USE lieferandoAnalysis;
GO