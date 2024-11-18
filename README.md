# auth-database

Este documento describe los campos comunes que se generan al consultar registros de auditoría en SQL Server mediante la función `sys.fn_get_audit_file`. Esta consulta permite analizar los eventos de auditoría registrados en el sistema.

## Campos Comunes en los Registros de Auditoría

A continuación se detalla el significado de los campos más comunes que aparecen en los registros de auditoría generados:

- **event_time**:  
  Fecha y hora en que ocurrió el evento de auditoría. Este campo es útil para rastrear la secuencia temporal de los eventos registrados.

- **sequence_number**:  
  Número secuencial asignado por SQL Server a cada evento de auditoría, utilizado para mantener el orden de los eventos.

- **action_id**:  
  Código que representa el tipo de evento de auditoría. Algunos valores comunes incluyen:
  - `LGIS`: Inicio de sesión exitoso.
  - `FAI`: Intento de inicio de sesión fallido.
  - `AUSC`: Cambios o configuraciones en la auditoría.
  - `SC`: Cambio de estructura en la base de datos.
  - `LX`: se refieren a intentos de inicio de sesión (exitosos o fallidos)  

- **succeeded**:  
  Indica si la acción fue exitosa (`true`) o fallida (`false`). Este campo es particularmente útil para eventos como intentos de inicio de sesión.

- **session_id**:  
  Identificador de la sesión en SQL Server en la cual ocurrió el evento. Esto permite agrupar eventos relacionados a la misma sesión y analizar el comportamiento de los usuarios dentro de una sesión específica.

- **server_principal_name**:  
  Nombre del usuario o entidad que generó el evento. Permite identificar qué usuario realizó la acción registrada.

- **database_name**:  
  Nombre de la base de datos en la que ocurrió el evento (si aplica). Este campo ayuda a identificar el contexto en el que se realizó la acción.

- **statement**:  
  Instrucción SQL ejecutada, si el evento implica una operación de datos. Este campo es útil para eventos de auditoría relacionados con modificaciones de datos, ya que muestra el comando SQL específico ejecutado.

- **target_object_name**:  
  Nombre del objeto (como una tabla) afectado por el evento. Esto es relevante para eventos que involucran cambios en los datos o la estructura de objetos en la base de datos.

- **additional_information**:  
  Información adicional que proporciona detalles específicos sobre el evento, como la dirección IP de un intento de inicio de sesión. Este campo puede variar en función del tipo de evento registrado.

## Ejemplo de Consulta de Auditoría

Para consultar los registros de auditoría generados en SQL Server, puedes utilizar el siguiente comando:

```sql
SELECT *
FROM sys.fn_get_audit_file ('/var/opt/mssql/audit/*.sqlaudit', DEFAULT, DEFAULT);
GO
