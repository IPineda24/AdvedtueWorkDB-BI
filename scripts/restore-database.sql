USE master;
GO

-- Eliminar la base de datos si existe
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'AdventureWorks2022')
BEGIN
    ALTER DATABASE AdventureWorks2022 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE AdventureWorks2022;
    PRINT 'Base de datos anterior eliminada';
END
GO

-- Restaurar con los nombres correctos
RESTORE DATABASE AdventureWorks2022
FROM DISK = '/var/opt/mssql/data/AdventureWorks2022.bak'
WITH 
    MOVE 'AdventureWorks2022' TO '/var/opt/mssql/data/AdventureWorks2022.mdf',
    MOVE 'AdventureWorks2022_log' TO '/var/opt/mssql/data/AdventureWorks2022_log.ldf',
    REPLACE,
    STATS = 10;
GO

-- Configurar recovery simple
ALTER DATABASE AdventureWorks2022 SET RECOVERY SIMPLE;
GO

-- Verificar que se restauró correctamente
SELECT 
    name AS DatabaseName,
    database_id AS ID,
    create_date AS CreatedDate,
    compatibility_level AS CompatLevel,
    state_desc AS State,
    recovery_model_desc AS RecoveryModel
FROM sys.databases 
WHERE name = 'AdventureWorks2022';
GO

-- Cambiar a la base de datos
USE AdventureWorks2022;
GO

-- Contar tablas
SELECT COUNT(*) AS TotalTablas FROM sys.tables;
GO

-- Mostrar primeras 10 tablas
SELECT TOP 10
    SCHEMA_NAME(schema_id) AS Esquema,
    name AS Tabla,
    create_date AS FechaCreacion
FROM sys.tables
ORD