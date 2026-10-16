
USE ICE_SQL;
GO


-- PUNTO 1 - FACTURA / COMPROBANTE DE VENTA
SELECT
    V.id_venta AS Numero_Venta,
    V.fecha_venta AS Fecha,
    V.hora_venta AS Hora,
    C.nombre AS Cliente,
    VE.nombre + ' ' + VE.apellido AS Vendedor,
    MP.nombre_metodo AS Metodo_Pago,
    P.descripcion AS Producto,
    PR.descripcion AS Presentacion,
    DV.cantidad AS Cantidad,
    DV.precio_unitario AS Precio_Unitario,
    --calculo del subtotal por cada renglón (Cantidad x Precio Unitario)
    (DV.cantidad * DV.precio_unitario) AS Subtotal_Renglon,
    --calculo del total acumulado de la factura
    SUM(DV.cantidad * DV.precio_unitario) OVER (PARTITION BY V.id_venta) AS Total_Factura
--tabla principal
FROM Venta AS V
--uniones con las demás tablas para traer los datos descriptivos
INNER JOIN Cliente AS C
    ON V.id_cliente = C.id_cliente
INNER JOIN Vendedor AS VE
    ON V.id_vendedor = VE.id_vendedor
INNER JOIN Metodo_pago AS MP
    ON V.id_metodo_pago = MP.id_metodo_pago
INNER JOIN Detalle_venta AS DV
    ON V.id_venta = DV.id_venta
INNER JOIN Producto AS P
    ON DV.id_producto = P.id_producto
INNER JOIN Presentacion AS PR
    ON DV.id_presentacion = PR.id_presentacion

-- Ordena primero por venta y después por detalle de venta
ORDER BY V.id_venta, DV.id_detalle_venta;

GO

-- VERIFICACION DE LOS TOTALES DE CADA FACTURA
-- Definimos una CTE (tabla virtual temporal llamada 'Factura') para calcular los montos previos
WITH Factura AS (
    SELECT
        V.id_venta AS Numero_Venta,

        -- subtotal del renglon cantidad x precio unitario
        DV.cantidad * DV.precio_unitario AS Subtotal_Renglon,
        -- total de la factura, suma de todos los renglones de la misma venta 
        SUM(DV.cantidad * DV.precio_unitario) OVER (PARTITION BY V.id_venta) AS Total_Factura

    FROM Venta AS V
    --une cada venta con sus detalles 
    INNER JOIN Detalle_venta AS DV
        ON V.id_venta = DV.id_venta
)

--compara que el total de la factura sea igual a la suma de sus subtotales
SELECT
    Numero_Venta,
    MAX(Total_Factura) AS Total_Factura,
    SUM(Subtotal_Renglon) AS Suma_Subtotales,
    --si coinciden muestra 'OK', si hay diferencia muestra 'ERROR'
    CASE
        WHEN MAX(Total_Factura) = SUM(Subtotal_Renglon)
            THEN 'OK'
        ELSE 'ERROR'
    END AS Verificacion

FROM Factura
GROUP BY Numero_Venta
ORDER BY Numero_Venta ASC; --se agrupo y ordena por numero de venta de forma ascendente


GO

-- PUNTO 2 - REPORTE AGREGADO POR VENDEDOR Y FECHAS
--Ventas por vendedor en un rango de fechas
--Este periodo se puede modificar
DECLARE @FechaDesde DATE = '2026-09-21';
DECLARE @FechaHasta DATE = '2026-09-30';


SELECT VE.id_vendedor AS ID_Vendedor, VE.nombre + ' ' + VE.apellido AS Vendedor, 

--Se utiliza DISTINCT porque al unir con el detalle, una venta con varios renglones 
--aparece varias veces y se contaria de mas 
COUNT (DISTINCT V.id_venta) AS Cantidad_Ventas, 

--Suma las cantidades de cada renglon
SUM (DV.cantidad) AS Unidades_Vendidas,

--Suma de cant. x precio unitario de todos los renglones
SUM (DV.cantidad * DV.precio_unitario) AS Recaudacion_Total 
FROM Vendedor AS VE
INNER JOIN Venta AS V
	ON VE.id_vendedor = V.id_vendedor
INNER JOIN Detalle_venta AS DV 
	ON V.id_venta = DV.id_venta

--El filtro por fecha se aplica antes de agrupar
WHERE V.fecha_venta BETWEEN @FechaDesde AND @FechaHasta

--Una fila por vendedor
GROUP BY VE.id_vendedor, VE.nombre, VE.apellido

--Mayor recaudacion primero, el nombre es el que desempata
ORDER BY Recaudacion_Total DESC, Vendedor;


GO

-- PUNTO 3 - PRODUCTOS CON RECAUDACION SUPERIOR AL PROMEDIO
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
