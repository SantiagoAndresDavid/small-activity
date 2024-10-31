-- Paso 1: Configuración en el servidor
USE master;
GO

-- Eliminar auditoría de servidor existente si ya existe
IF EXISTS (SELECT * FROM sys.server_audits WHERE name = 'Acceso_Seguridad_Auditoria')
BEGIN
    ALTER SERVER AUDIT Acceso_Seguridad_Auditoria WITH (STATE = OFF);
    DROP SERVER AUDIT Acceso_Seguridad_Auditoria;
END
GO

-- Crear auditoría de servidor para almacenar los registros en un archivo
CREATE SERVER AUDIT Acceso_Seguridad_Auditoria
    TO FILE (FILEPATH = '/var/opt/mssql/audit/', MAXSIZE = 10 MB, MAX_ROLLOVER_FILES = 5);
GO

-- Activar la auditoría de servidor
ALTER SERVER AUDIT Acceso_Seguridad_Auditoria WITH (STATE = ON);
GO

-- Paso 2: Configuración de Especificaciones de Auditoría de Acceso y Seguridad
-- Eliminar especificación de auditoría de servidor existente si ya existe
IF EXISTS (SELECT * FROM sys.server_audit_specifications WHERE name = 'Especificacion_Acceso_Seguridad')
BEGIN
    ALTER SERVER AUDIT SPECIFICATION Especificacion_Acceso_Seguridad WITH (STATE = OFF);
    DROP SERVER AUDIT SPECIFICATION Especificacion_Acceso_Seguridad;
END
GO

-- Crear especificación de auditoría para capturar eventos de inicio de sesión y cambios de permisos en el servidor
CREATE SERVER AUDIT SPECIFICATION Especificacion_Acceso_Seguridad
    FOR SERVER AUDIT Acceso_Seguridad_Auditoria
    ADD (FAILED_LOGIN_GROUP),               -- Registrar intentos de login fallidos
    ADD (SUCCESSFUL_LOGIN_GROUP),            -- Registrar intentos de login exitosos
    ADD (DATABASE_PERMISSION_CHANGE_GROUP);  -- Registrar cambios de permisos en la base de datos
GO

-- Activar especificación de auditoría de servidor
ALTER SERVER AUDIT SPECIFICATION Especificacion_Acceso_Seguridad WITH (STATE = ON);
GO

-- Paso 3: Configuración en la Base de Datos EjemploAuditoria
-- Cambiar a la base de datos EjemploAuditoria
USE EjemploAuditoria;
GO

-- Eliminar cualquier especificación de auditoría de base de datos existente con el mismo nombre
IF EXISTS (SELECT * FROM sys.database_audit_specifications WHERE name = 'Auditoria_Combinada_EjemploAuditoria')
BEGIN
    ALTER DATABASE AUDIT SPECIFICATION Auditoria_Combinada_EjemploAuditoria WITH (STATE = OFF);
    DROP DATABASE AUDIT SPECIFICATION Auditoria_Combinada_EjemploAuditoria;
END
GO

-- Crear especificación de auditoría combinada en la base de datos para registrar cambios en la estructura y operaciones de datos
CREATE DATABASE AUDIT SPECIFICATION Auditoria_Combinada_EjemploAuditoria
    FOR SERVER AUDIT Acceso_Seguridad_Auditoria
    ADD (SCHEMA_OBJECT_CHANGE_GROUP)      -- Registrar cambios en la estructura
    ADD (SCHEMA_OBJECT_ACCESS_GROUP);     -- Registrar operaciones en datos (INSERT, UPDATE, DELETE)
GO

-- Activar especificación de auditoría de base de datos
ALTER DATABASE AUDIT SPECIFICATION Auditoria_Combinada_EjemploAuditoria WITH (STATE = ON);
GO
