-- Crear la base de datos de ejemplo
CREATE DATABASE EjemploAuditoria;
GO

-- Cambiar a la base de datos de ejemplo
USE EjemploAuditoria;
GO

-- Crear la tabla Clientes con una clave primaria en ClienteID
CREATE TABLE Clientes (
                          ClienteID INT PRIMARY KEY,
                          Nombre NVARCHAR(100),
                          Correo NVARCHAR(100),
                          FechaRegistro DATETIME DEFAULT GETDATE()
);
GO

-- Insertar datos iniciales en la tabla Clientes
INSERT INTO Clientes (ClienteID, Nombre, Correo)
VALUES (1, 'Juan Pérez', 'juan.perez@example.com'),
       (2, 'Ana López', 'ana.lopez@example.com');
GO

-- Cambiar a la base de datos master
USE master;
GO

-- Crear una auditoría en el servidor que registre eventos en un archivo
CREATE SERVER AUDIT AuditoriaServidorEjemplo
    TO FILE (
    FILEPATH = '/var/opt/mssql/audit/',  -- Ruta donde se almacenarán los archivos de auditoría
    MAXSIZE = 5 MB,                       -- Tamaño máximo del archivo de auditoría
    MAX_ROLLOVER_FILES = 10               -- Número máximo de archivos de auditoría
    );
GO

-- Activar la auditoría en el servidor
ALTER SERVER AUDIT AuditoriaServidorEjemplo
    WITH (STATE = ON);
GO

-- Cambiar a la base de datos EjemploAuditoria
USE EjemploAuditoria;
GO

-- Crear una especificación de auditoría en la base de datos para registrar operaciones en Clientes
CREATE DATABASE AUDIT SPECIFICATION AuditoriaEjemploDB
    FOR SERVER AUDIT AuditoriaServidorEjemplo
    ADD (SELECT ON OBJECT::Clientes BY PUBLIC),
ADD (INSERT ON OBJECT::Clientes BY PUBLIC),
ADD (UPDATE ON OBJECT::Clientes BY PUBLIC),
ADD (DELETE ON OBJECT::Clientes BY PUBLIC);
GO

-- Activar la especificación de auditoría
ALTER DATABASE AUDIT SPECIFICATION AuditoriaEjemploDB
    WITH (STATE = ON);
GO

-- Realizar un SELECT para auditarlo
SELECT * FROM Clientes;

-- Insertar un nuevo registro en la tabla Clientes
INSERT INTO Clientes (ClienteID, Nombre, Correo)
VALUES (3, 'Carlos Mejía', 'carlos.mejia@example.com');

-- Actualizar un registro existente
UPDATE Clientes
SET Correo = 'juan.perez@newdomain.com'
WHERE ClienteID = 1;

-- Eliminar un registro de la tabla Clientes
DELETE FROM Clientes
WHERE ClienteID = 2;

-- Cambiar a la base de datos master para consultar registros de auditoría
USE master;
GO

-- Consultar los registros de auditoría generados
SELECT *
FROM sys.fn_get_audit_file ('/var/opt/mssql/audit/AuditoriaServidorEjemplo*.sqlaudit', DEFAULT, DEFAULT);
GO