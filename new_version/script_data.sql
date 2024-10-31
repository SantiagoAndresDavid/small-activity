-- Inserción de datos (debe generar un registro de operación en datos)
INSERT INTO Clientes (ClienteID, Nombre, Correo)
VALUES (999, 'Cliente Prueba', 'prueba@ejemplo.com');
GO

-- Actualización de datos (debe generar un registro de operación en datos)
UPDATE Clientes
SET Nombre = 'Cliente Actualizado'
WHERE ClienteID = 999;
GO

-- Eliminación de datos (debe generar un registro de operación en datos)
DELETE FROM Clientes
WHERE ClienteID = 999;
GO
