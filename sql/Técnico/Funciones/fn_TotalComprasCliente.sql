
USE ICE_SQL;
GO

CREATE FUNCTION fn_TotalComprasCliente
(
    @id_cliente INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @total DECIMAL(10,2);

    SELECT @total = ISNULL(SUM(d.cantidad * d.precio_unitario), 0)
    FROM Venta v
    INNER JOIN Detalle_venta d
        ON v.id_venta = d.id_venta
    WHERE v.id_cliente = @id_cliente;

    RETURN @total;
END;
GO

-- Prueba de la funcion
SELECT dbo.fn_TotalComprasCliente(1) AS Total_Compras;

-- Total gastado por cada cliente
SELECT
    c.id_cliente,
    c.nombre,
    dbo.fn_TotalComprasCliente(c.id_cliente) AS Total_Compras
FROM Cliente c;
GO
