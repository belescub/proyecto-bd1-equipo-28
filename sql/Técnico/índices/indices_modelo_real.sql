USE ICE_SQL;
GO

-- Propuestas para las tablas reales (sin mediciones)

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID('dbo.Venta')
      AND name = 'IX_Venta_FechaVenta'
)
    CREATE NONCLUSTERED INDEX IX_Venta_FechaVenta
    ON dbo.Venta(fecha_venta);
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID('dbo.Detalle_venta')
      AND name = 'IX_DetalleVenta_Producto'
)
    CREATE NONCLUSTERED INDEX IX_DetalleVenta_Producto
    ON dbo.Detalle_venta(id_producto)
    INCLUDE (id_venta, cantidad, precio_unitario);
GO

SELECT OBJECT_NAME(object_id) AS Tabla, name AS Indice
FROM sys.indexes
WHERE name IN ('IX_Venta_FechaVenta', 'IX_DetalleVenta_Producto');
GO
