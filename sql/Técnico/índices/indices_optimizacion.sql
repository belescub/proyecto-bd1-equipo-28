USE ICE_SQL;
GO

-- Tabla de prueba
IF OBJECT_ID('dbo.VentaHistorica_Prueba', 'U') IS NULL
    CREATE TABLE dbo.VentaHistorica_Prueba (
        id_venta BIGINT IDENTITY(1,1),
        fecha_venta DATE NOT NULL,
        importe DECIMAL(12,2) NOT NULL
    );
GO

IF NOT EXISTS (SELECT 1 FROM dbo.VentaHistorica_Prueba)
BEGIN
    ;WITH Numeros AS (
        SELECT TOP (1000000) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
        FROM sys.all_objects a CROSS JOIN sys.all_objects b
    )
    INSERT INTO dbo.VentaHistorica_Prueba (fecha_venta, importe)
    SELECT DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 1825), '2020-01-01'),
           CAST(100 + ABS(CHECKSUM(NEWID()) % 100000) AS DECIMAL(12,2))
    FROM Numeros;
END;
GO

SELECT COUNT(*) AS Cantidad_Registros FROM dbo.VentaHistorica_Prueba;
GO

SET STATISTICS TIME ON;
SET STATISTICS IO ON;
GO

-- Sin indice
IF EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.VentaHistorica_Prueba') AND name = 'IX_VentaHistorica_Fecha_Cobertura')
    DROP INDEX IX_VentaHistorica_Fecha_Cobertura ON dbo.VentaHistorica_Prueba;
IF EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.VentaHistorica_Prueba') AND name = 'IX_VentaHistorica_Fecha')
    DROP INDEX IX_VentaHistorica_Fecha ON dbo.VentaHistorica_Prueba;
GO

SELECT id_venta, fecha_venta, importe
FROM dbo.VentaHistorica_Prueba
WHERE fecha_venta BETWEEN '2023-01-01' AND '2023-03-31';
GO

-- Indice agrupado
CREATE CLUSTERED INDEX IX_VentaHistorica_Fecha
ON dbo.VentaHistorica_Prueba(fecha_venta);
GO

SELECT id_venta, fecha_venta, importe
FROM dbo.VentaHistorica_Prueba
WHERE fecha_venta BETWEEN '2023-01-01' AND '2023-03-31';
GO

DROP INDEX IX_VentaHistorica_Fecha ON dbo.VentaHistorica_Prueba;
GO

-- Indice de cobertura
CREATE NONCLUSTERED INDEX IX_VentaHistorica_Fecha_Cobertura
ON dbo.VentaHistorica_Prueba(fecha_venta)
INCLUDE (importe);
GO

SELECT fecha_venta, importe
FROM dbo.VentaHistorica_Prueba
WHERE fecha_venta BETWEEN '2023-01-01' AND '2023-03-31';
GO
