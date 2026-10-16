
USE ICE_SQL;
GO

-- Productos con recaudacion superior al promedio

SELECT
    P.descripcion AS Producto,
    COUNT(DISTINCT V.id_venta) AS Cantidad_Ventas,
    SUM(DV.cantidad) AS Unidades_Vendidas,
    SUM(DV.cantidad * DV.precio_unitario) AS Recaudacion_Total

FROM Producto AS P
INNER JOIN Detalle_venta AS DV
    ON P.id_producto = DV.id_producto
INNER JOIN Venta AS V
    ON DV.id_venta = V.id_venta

-- Agrupamos por producto
GROUP BY P.id_producto, P.descripcion

-- Mostramos los productos que superan el promedio
HAVING SUM(DV.cantidad * DV.precio_unitario) >
(
    SELECT AVG(T.Total)
    FROM (
        SELECT SUM(cantidad * precio_unitario) AS Total
        FROM Detalle_venta
        GROUP BY id_producto
    ) AS T
)

-- Ordenamos de mayor a menor recaudacion
ORDER BY Recaudacion_Total DESC;
GO
