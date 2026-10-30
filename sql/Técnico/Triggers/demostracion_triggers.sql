USE ICE_SQL;
GO

--DEMOSTRACION, se ejecuta una sola vez despues de la creacion de los triggers
--se hace el abm de un producto de prueba, ya que los productos reales tienen ventas y no se pueden borrar
DECLARE @IdPrueba INT;
-- alta del producto de prueba
INSERT INTO dbo.Producto (descripcion, stock, estado)
VALUES ('Helado prueba', 20, 1);

--recupera el ID del producto insertado
SET @IdPrueba = CONVERT(INT, SCOPE_IDENTITY());

--verifica que el producto se agregó con stock 20
SELECT id_producto, descripcion, stock, estado
FROM dbo.Producto
WHERE id_producto = @IdPrueba;

--como realizamos una modificacion real se debe auditar
UPDATE dbo.Producto SET stock = 15 WHERE id_producto = @IdPrueba;
--no se realiza ningun cambio real por lo que NO debe generar auditoría
UPDATE dbo.Producto SET stock = 15 WHERE id_producto = @IdPrueba;
--verificar que el stock cambió (ahora con stock 15)
SELECT id_producto, descripcion, stock, estado
FROM dbo.Producto 
WHERE id_producto = @IdPrueba;

--baja del producto se debe auditar
DELETE FROM dbo.Producto WHERE id_producto = @IdPrueba;
--verifificar que el delete borro el producto de prueba
SELECT * FROM dbo.Producto WHERE id_producto = @IdPrueba;

--consultar los movimientos del producto de prueba
SELECT * FROM dbo.Auditoria_Producto
WHERE id_producto = @IdPrueba
ORDER BY id_auditoria_producto;
GO

--demostracion de update con un producto existente 
SELECT id_producto, descripcion, stock FROM dbo.Producto WHERE id_producto = 3;

UPDATE dbo.Producto SET stock = 35 WHERE id_producto = 3; --nuevo stock

SELECT * FROM dbo.Auditoria_Producto WHERE id_producto = 3 ORDER BY id_auditoria_producto;

--se restaura el stock original (tambien queda auditada)
UPDATE dbo.Producto SET stock = 40 WHERE id_producto = 3;
SELECT * FROM dbo.Auditoria_Producto WHERE id_producto = 3 ORDER BY id_auditoria_producto;
GO

--DEMOSTRACION PRECIO
SELECT id_precio, id_presentacion, precio
FROM dbo.Precio
WHERE id_precio = 1;

-- Modificar el precio
UPDATE dbo.Precio
SET precio = 2800.00
WHERE id_precio = 1;

--verifico el cambio
SELECT id_precio, id_presentacion, precio
FROM dbo.Precio
WHERE id_precio = 1;

-- verifico el historial de auditoria de ese precio
SELECT
    A.id_auditoria_precio,
    A.id_precio,
    PR.descripcion AS presentacion,
    A.operacion_precio,
    A.precio_anterior,
    A.precio_nuevo,
    A.fecha_hora,
    A.usuario
FROM dbo.Auditoria_Precio AS A
LEFT JOIN dbo.Presentacion AS PR
    ON A.id_presentacion = PR.id_presentacion
WHERE A.id_precio = 1
ORDER BY A.id_auditoria_precio;

--restaura el importe original
UPDATE dbo.Precio
SET precio = 2500.00
WHERE id_precio = 1;

--verifico el precio restaurado
SELECT id_precio, id_presentacion, precio
FROM dbo.Precio
WHERE id_precio = 1;

--consulta de nuevo la auditoria
SELECT
    id_auditoria_precio,
    id_precio,
    operacion_precio,
    precio_anterior,
    precio_nuevo,
    fecha_hora,
    usuario
FROM dbo.Auditoria_Precio
WHERE id_precio = 1
ORDER BY id_auditoria_precio;
GO
