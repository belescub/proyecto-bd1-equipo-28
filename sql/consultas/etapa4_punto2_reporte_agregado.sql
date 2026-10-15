USE ICE_SQL;
GO

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

