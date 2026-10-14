USE ICE_SQL;
GO

DECLARE @NuevoDetalle TABLE (id_detalle_venta INT); --@NuevoDetalle es una variable de tabla temporal

-- Se agrega un nuevo producto a la venta 1 para luego verificar que funcione bien los subtotales y totales
INSERT INTO Detalle_venta
    (id_venta, cantidad, id_producto, precio_unitario, id_presentacion)
OUTPUT INSERTED.id_detalle_venta
    INTO @NuevoDetalle (id_detalle_venta)
VALUES
    (1, 1, 2, 3000.00, 4);

-- Asocio el sabor al nuevo detalle
INSERT INTO Incluye (id_sabor, id_venta, id_detalle_venta)
SELECT 2, 1, id_detalle_venta
FROM @NuevoDetalle;
GO

SELECT * FROM Detalle_venta
WHERE id_venta = 1;
GO

--FACTURA/COMPROBANTE DE VENTA

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