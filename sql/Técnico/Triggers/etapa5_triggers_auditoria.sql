USE ICE_SQL;
GO

--TABLAS DE AUDITORIA
IF OBJECT_ID('dbo.Auditoria_Producto', 'U') IS NULL
BEGIN
CREATE TABLE dbo.Auditoria_Producto(
    id_auditoria_producto INT IDENTITY(1,1) PRIMARY KEY,
    id_producto INT NOT NULL,
    operacion_producto VARCHAR(10) NOT NULL, --insert, update y delete
    descripcion_anterior VARCHAR(30) NULL,
    descripcion_nueva VARCHAR(30) NULL,
    stock_anterior INT NULL,
    stock_nuevo INT NULL,
    estado_anterior BIT NULL,
    estado_nuevo BIT NULL,
    fecha_hora DATETIME2(0) NOT NULL DEFAULT SYSDATETIME(),
    usuario SYSNAME NOT NULL DEFAULT SUSER_SNAME()
    );
END
GO

IF OBJECT_ID('dbo.Auditoria_Precio', 'U') IS NULL
BEGIN
CREATE TABLE dbo.Auditoria_Precio(
    id_auditoria_precio INT IDENTITY(1,1) PRIMARY KEY,
    id_precio INT NOT NULL,
    id_presentacion INT NULL,
    operacion_precio VARCHAR(10) NOT NULL, --insert, update y delete
    precio_anterior DECIMAL(10,2) NULL,
    precio_nuevo DECIMAL(10,2) NULL,
    fecha_hora DATETIME2(0) NOT NULL DEFAULT SYSDATETIME(),
    usuario SYSNAME NOT NULL DEFAULT SUSER_SNAME()
    );
END
GO

--TRIGGER DE PRODUCTO
CREATE OR ALTER TRIGGER dbo.trg_Producto_Auditoria
ON dbo.Producto
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Auditoria_Producto
        (id_producto, operacion_producto,
         descripcion_anterior, descripcion_nueva,
         stock_anterior, stock_nuevo,
         estado_anterior, estado_nuevo)
    SELECT
        COALESCE(i.id_producto, d.id_producto),
        CASE
            WHEN d.id_producto IS NULL THEN 'INSERT'
            WHEN i.id_producto IS NULL THEN 'DELETE'
            ELSE 'UPDATE'
        END,
        d.descripcion, i.descripcion,
        d.stock,       i.stock,
        d.estado,      i.estado
    FROM inserted AS i
    FULL OUTER JOIN deleted AS d
        ON i.id_producto = d.id_producto
    WHERE d.id_producto IS NULL            -- alta
       OR i.id_producto IS NULL            -- baja
       OR i.descripcion <> d.descripcion   -- modificacion con cambio real
       OR i.stock       <> d.stock
       OR i.estado      <> d.estado;
END;
GO

--TRIGGER DE PRECIO
CREATE OR ALTER TRIGGER dbo.trg_Precio_Auditoria
ON dbo.Precio
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Auditoria_Precio
        (id_precio, id_presentacion, operacion_precio,
         precio_anterior, precio_nuevo)
    SELECT
        COALESCE(i.id_precio, d.id_precio),
        COALESCE(i.id_presentacion, d.id_presentacion),
        CASE
            WHEN d.id_precio IS NULL THEN 'INSERT'
            WHEN i.id_precio IS NULL THEN 'DELETE'
            ELSE 'UPDATE'
        END,
        d.precio, i.precio
    FROM inserted AS i
    FULL OUTER JOIN deleted AS d
        ON i.id_precio = d.id_precio
    WHERE d.id_precio IS NULL
       OR i.id_precio IS NULL
       OR i.precio <> d.precio;
END;
GO






