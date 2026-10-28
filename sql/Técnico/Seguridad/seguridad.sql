USE ICE_SQL;
GO

-- 1.Creamos logins con sus respectivas contraseñas
CREATE LOGIN login_admin WITH PASSWORD = 'Admin123!';
CREATE LOGIN login_vendedor WITH PASSWORD = 'Vendedor123!';
CREATE LOGIN login_consulta WITH PASSWORD = 'Consulta123!';
GO

-- 2.Creamos los roles
CREATE ROLE Administrador;
CREATE ROLE Vendedor;
CREATE ROLE Consulta;
GO

-- 3.Creamos los usuarios de base de datos vinculados a sus logins
CREATE USER usuario_admin FOR LOGIN login_admin;
CREATE USER usuario_vendedor FOR LOGIN login_vendedor;
CREATE USER usuario_consulta FOR LOGIN login_consulta;
GO

-- 4.Asignamos usuarios a sus respectivos roles
ALTER ROLE Administrador ADD MEMBER usuario_admin;
ALTER ROLE Vendedor ADD MEMBER usuario_vendedor;
ALTER ROLE Consulta ADD MEMBER usuario_consulta;
GO


-- 5. Asignación de permisos por Rol

-- Rol Administrador: Control total sobre el esquema dbo (Consultar, Insertar, Modificar y Eliminar)
GRANT SELECT, INSERT, UPDATE, DELETE 
ON SCHEMA::dbo 
TO Administrador;
GO

-- Rol Vendedor: Principio de minimo privilegio
-- Permisos de lectura requeridos para la operacion comercial
GRANT SELECT ON dbo.Cliente TO Vendedor;

GRANT SELECT ON dbo.Producto TO Vendedor;

GRANT SELECT ON dbo.Presentacion TO Vendedor;

GRANT SELECT ON dbo.Precio TO Vendedor;

GRANT SELECT ON dbo.Sabor TO Vendedor;

GRANT SELECT ON dbo.Metodo_pago TO Vendedor;

GRANT SELECT ON dbo.Cajas TO Vendedor;

GRANT SELECT ON dbo.Apertura_Caja TO Vendedor;

GRANT SELECT ON dbo.Venta TO Vendedor;

GRANT SELECT ON dbo.Detalle_Venta TO Vendedor;

GRANT SELECT ON dbo.Incluye TO Vendedor;

-- Permisos de Escritura (Registrar operaciones)
GRANT INSERT ON dbo.Venta TO Vendedor;

GRANT INSERT ON dbo.Detalle_Venta TO Vendedor;

GRANT INSERT ON dbo.Incluye TO Vendedor;

GRANT INSERT ON dbo.Apertura_Caja TO Vendedor;

-- Restricciones Explicitas (Impedir modificaciones de precios o borrado de historial)
DENY DELETE ON dbo.Venta TO Vendedor;

DENY DELETE ON dbo.Detalle_Venta TO Vendedor;

DENY DELETE ON dbo.Incluye TO Vendedor;

DENY UPDATE, DELETE ON dbo.Precio TO Vendedor;
GO

-- Rol Consulta: Solo lectura sobre todas las tablas del esquema
GRANT SELECT ON SCHEMA::dbo TO Consulta;

-- Bloqueo explicito de modificaciones para el rol Consulta
DENY INSERT, UPDATE, DELETE ON SCHEMA::dbo TO Consulta;
GO