
USE ICE_SQL;
GO

-- 1. Verificar que existen ventas, detalles y datos para el rango del reporte.
SELECT
    (SELECT COUNT(*) FROM Venta) AS Ventas,
    (SELECT COUNT(*) FROM Detalle_venta) AS Renglones_Detalle,
    (SELECT COUNT(*) FROM Venta WHERE fecha_venta BETWEEN '2026-09-21' AND '2026-09-30') AS Ventas_En_Rango;
GO

-- 2. Verificar integridad de claves de ventas y detalles.
SELECT
    (SELECT COUNT(*) FROM Detalle_venta DV LEFT JOIN Venta V ON V.id_venta = DV.id_venta WHERE V.id_venta IS NULL) AS Detalles_Sin_Venta,
    (SELECT COUNT(*) FROM Detalle_venta DV LEFT JOIN Producto P ON P.id_producto = DV.id_producto WHERE P.id_producto IS NULL) AS Detalles_Sin_Producto,
    (SELECT COUNT(*) FROM Detalle_venta DV LEFT JOIN Presentacion PR ON PR.id_presentacion = DV.id_presentacion WHERE PR.id_presentacion IS NULL) AS Detalles_Sin_Presentacion;
GO

-- 3. Conciliacion del total de ventas versus el total agregado por vendedores
DECLARE @FechaDesde DATE = '2026-09-21';
DECLARE @FechaHasta DATE = '2026-09-30';
WITH Total_Detalles AS (
    SELECT SUM(DV.cantidad * DV.precio_unitario) AS Total
    FROM Venta V INNER JOIN Detalle_venta DV ON V.id_venta = DV.id_venta
    WHERE V.fecha_venta BETWEEN @FechaDesde AND @FechaHasta
), Por_Vendedor AS (
    SELECT V.id_vendedor, SUM(DV.cantidad * DV.precio_unitario) AS Total
    FROM Venta V INNER JOIN Detalle_venta DV ON V.id_venta = DV.id_venta
    WHERE V.fecha_venta BETWEEN @FechaDesde AND @FechaHasta
    GROUP BY V.id_vendedor
)
SELECT
    TD.Total AS Total_General,
    (SELECT SUM(PV.Total) FROM Por_Vendedor PV) AS Total_Por_Vendedores,
    COALESCE(TD.Total,0) - COALESCE((SELECT SUM(PV.Total) FROM Por_Vendedor PV),0) AS Diferencia
FROM Total_Detalles TD;
GO

-- 4. Comprobar que cada venta tiene al menos un renglon de detalle.
SELECT COUNT(*) AS Ventas_Sin_Detalle
FROM Venta V
WHERE NOT EXISTS (SELECT 1 FROM Detalle_venta DV WHERE DV.id_venta = V.id_venta);
GO

-- 5. Comprobar que existen productos que superan el promedio de recaudacion
WITH Recaudacion_Producto AS (
    SELECT id_producto, SUM(cantidad * precio_unitario) AS Total
    FROM Detalle_venta
    GROUP BY id_producto
)
SELECT COUNT(*) AS Productos_Sobre_Promedio
FROM Recaudacion_Producto
WHERE Total > (SELECT AVG(Total) FROM Recaudacion_Producto);
GO
