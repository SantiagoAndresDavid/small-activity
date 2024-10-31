-- Intento de inicio de sesión fallido (Cambia el nombre de usuario o la contraseña a algo incorrecto)
-- Debe generar un registro de login fallido
BEGIN TRY
    EXECUTE AS LOGIN = 'usuario_incorrecto'; -- Cambia 'usuario_incorrecto' a un nombre no válido
END TRY
BEGIN CATCH
    PRINT 'Error de login (intento fallido)';
END CATCH;
GO

-- Intento de inicio de sesión exitoso (Cambia a un usuario válido)
-- Debe generar un registro de login exitoso
EXECUTE AS LOGIN = 'sa'; -- Cambia 'sa' a un usuario válido si es necesario
GO
REVERT;

-- Cambio de permisos (otorga y revoca un permiso temporal)
-- Debe generar un registro de cambio de permisos
USE EjemploAuditoria;
GO
GRANT SELECT ON dbo.Clientes TO public;
REVOKE SELECT ON dbo.Clientes FROM public;
GO
