-- Cambiar a la base de datos master
USE master;
GO

-- Crear una auditoría en el servidor que registre eventos en un archivo
CREATE SERVER AUDIT AuditoriaLogins
    TO FILE (
    FILEPATH = '/var/opt/mssql/audit/',  -- Ruta donde se almacenarán los archivos de auditoría
    MAXSIZE = 5 MB,                       -- Tamaño máximo del archivo de auditoría
    MAX_ROLLOVER_FILES = 10               -- Número máximo de archivos de auditoría
    );
GO

-- Activar la auditoría en el servidor
ALTER SERVER AUDIT AuditoriaLogins
    WITH (STATE = ON);
GO

-- Crear la especificación de auditoría para capturar eventos de login
CREATE SERVER AUDIT SPECIFICATION AuditoriaLoginEspecifica
    FOR SERVER AUDIT AuditoriaLogins
    ADD (SUCCESSFUL_LOGIN_GROUP),  -- Auditar logins exitosos
    ADD (FAILED_LOGIN_GROUP);      -- Auditar logins fallidos
GO

-- Activar la especificación de auditoría
ALTER SERVER AUDIT SPECIFICATION AuditoriaLoginEspecifica
    WITH (STATE = ON);
GO

-- Consultar los registros de auditoría de logins
SELECT *
FROM sys.fn_get_audit_file ('/var/opt/mssql/audit/AuditoriaLogins*.sqlaudit', DEFAULT, DEFAULT);
GO
