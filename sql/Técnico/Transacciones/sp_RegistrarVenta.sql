USE ICE_SQL;
GO 
 
CREATE   PROCEDURE dbo.sp_RegistrarVenta  
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
  
    -- Validar la cantidad  
    IF @cantidad <= 0  
    BEGIN  
        PRINT 'La cantidad debe ser mayor que cero.';  
        RETURN;  
    END;  
  
    -- Validar el precio  
    IF @precio_unitario < 0  
    BEGIN  
        PRINT 'El precio no puede ser negativo.';  
        RETURN;  
    END;  
  
    -- Validar que el producto exista, esté activo y tenga stock  
    IF NOT EXISTS (  
        SELECT 1  
        FROM Producto  
        WHERE id_producto = @id_producto  
          AND estado = 1  
          AND stock >= @cantidad  
    )  
    BEGIN  
        PRINT 'El producto no existe, está inactivo o no tiene stock suficiente.';  
        RETURN;  
    END;  
  
    -- Validar que el producto se venda en esa presentación  
    IF NOT EXISTS (  
        SELECT 1  
        FROM Se_vende_en  
        WHERE id_producto = @id_producto  
          AND id_presentacion = @id_presentacion  
    )  
    BEGIN  
        PRINT 'La presentación no corresponde al producto.';  
        RETURN;  
    END;  
  
    -- Validar que el sabor exista y esté activo  
    IF NOT EXISTS (  
        SELECT 1  
        FROM Sabor  
        WHERE id_sabor = @id_sabor  
          AND estado = 1  
    )  
    BEGIN  
        PRINT 'El sabor no existe o está inactivo.';  
        RETURN;  
    END;  
  
    BEGIN TRY  
        BEGIN TRANSACTION;  
  
        -- Descontar el stock solamente si sigue siendo suficiente  
        UPDATE Producto  
        SET stock = stock - @cantidad  
        WHERE id_producto = @id_producto  
          AND estado = 1  
          AND stock >= @cantidad;  
  
        IF @@ROWCOUNT = 0  
        BEGIN  
            ROLLBACK TRANSACTION;  
            PRINT 'Stock insuficiente para registrar la venta.';  
            RETURN;  
        END;  
  
        -- Registrar la venta  
        INSERT INTO Venta  
            (fecha_venta, hora_venta, id_cliente,  
             id_apertura_caja, id_metodo_pago, id_vendedor)  
        VALUES  
            (CAST(GETDATE() AS DATE),  
             CAST(GETDATE() AS TIME),  
             @id_cliente,  
             @id_apertura_caja,  
             @id_metodo_pago,  
             @id_vendedor);  
  
        SET @id_venta = SCOPE_IDENTITY();  
  
        -- Registrar el detalle de la venta  
        INSERT INTO Detalle_venta  
            (id_venta, cantidad, id_producto,  
             precio_unitario, id_presentacion)  
        VALUES  
            (@id_venta,  
             @cantidad,  
             @id_producto,  
             @precio_unitario,  
             @id_presentacion);  
  
        SET @id_detalle_venta = SCOPE_IDENTITY();  
  
        -- Registrar el sabor incluido en el detalle  
        INSERT INTO Incluye  
            (id_sabor, id_venta, id_detalle_venta)  
        VALUES  
            (@id_sabor, @id_venta, @id_detalle_venta);  
  
        -- Confirmar todos los cambios  
        COMMIT TRANSACTION;  
  
        SELECT @id_venta AS Venta_Registrada;  
  
        PRINT 'Venta registrada correctamente.';  
  
    END TRY  
    BEGIN CATCH  
  
        -- Deshacer los cambios si ocurre un error  
        IF @@TRANCOUNT > 0  
            ROLLBACK TRANSACTION;  
  
        PRINT 'Ocurrio un error al registrar la venta.';  
        PRINT ERROR_MESSAGE();  
  
    END CATCH;  
END;  