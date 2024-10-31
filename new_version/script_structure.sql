-- Crear una tabla temporal para probar cambios en la estructura
USE EjemploAuditoria;
GO

CREATE TABLE Clientes_Prueba (
    ClienteID INT PRIMARY KEY,
    Nombre NVARCHAR(100)
);
GO

-- Eliminar la tabla temporal para probar el registro de eliminación en la estructura
DROP TABLE Clientes_Prueba;
GO
