
USE ICE_SQL;
GO

CREATE PROCEDURE sp_RegistrarVenta
    @id_cliente INT,
    @id_vendedor INT,
    @id_apertura_caja INT,
    @id_metodo_pago INT,
    @id_producto INT,
    @id_presentacion INT,
    @id_sabor INT,
    @cantidad INT,
    @precio_unitario DECIMAL(10,2)
AS
BEGIN
    DECLARE @id_venta INT;
    DECLARE @id_detalle_venta INT;

    -- Registrar la venta
    INSERT INTO Venta
        (fecha_venta, hora_venta, id_cliente,
         id_apertura_caja, id_metodo_pago, id_vendedor)
    VALUES
        (CAST(GETDATE() AS DATE),
         CAST(GETDATE() AS TIME),
         @id_cliente, @id_apertura_caja,
         @id_metodo_pago, @id_vendedor);

    -- Obtener el ID de la venta
    SET @id_venta = SCOPE_IDENTITY();

    -- Registrar el detalle
    INSERT INTO Detalle_venta
        (id_venta, cantidad, id_producto,
         precio_unitario, id_presentacion)
    VALUES
        (@id_venta, @cantidad, @id_producto,
         @precio_unitario, @id_presentacion);

    -- Obtener el ID del detalle
    SET @id_detalle_venta = SCOPE_IDENTITY();

    -- Registrar el sabor
    INSERT INTO Incluye
        (id_sabor, id_venta, id_detalle_venta)
    VALUES
        (@id_sabor, @id_venta, @id_detalle_venta);

    -- Actualizar el stock
    UPDATE Producto
    SET stock = stock - @cantidad
    WHERE id_producto = @id_producto;

    SELECT @id_venta AS Venta_Registrada;
END;
GO
