USE ICE_SQL;
GO

-- 1. VENDEDOR
INSERT INTO Vendedor (nombre, apellido, dni)
VALUES
('Juan', 'Gomez', 30123456),
('Maria', 'Fernandez', 32456789),
('Carlos', 'Ramirez', 28765432),
('Lucia', 'Martinez', 35678901),
('Diego', 'Lopez', 33987654),
('Sofia', 'Rodriguez', 37123456),
('Martin', 'Acosta', 31567890),
('Camila', 'Benitez', 38234567),
('Nicolas', 'Romero', 34876543),

-- 2. CLIENTE
INSERT INTO Cliente (nombre, dni, telefono, email)
VALUES
('Juan Perez', 40111222, '3794112233', 'juan.perez@email.com'),
('Luis Sanchez', 39222333, '3794223344', 'luis.sanchez@email.com'),
('Carla Aguirre', 41333444, '3794334455', 'carla.aguirre@email.com'),
('Pedro Ortiz', 38444555, '3794445566', 'pedro.ortiz@email.com'),
('Laura Rios', 42555666, '3794556677', 'laura.rios@email.com'),
('Tomas Vera', 37666777, '3794667788', 'tomas.vera@email.com'),
('Federico Silva', 36888999, '3794889900', 'federico.silva@email.com'),
('Matias Cabral', 35110111, '3794101122', 'matias.cabral@email.com');

-- 3. SABOR
INSERT INTO Sabor (nombre_sabor, descripcion, estado)
VALUES
('Chocolate', 'Helado sabor chocolate', 1),
('Dulce de leche', 'Helado sabor dulce de leche', 1),
('Frutilla', 'Helado sabor frutilla', 1),
('Vainilla', 'Helado sabor vainilla', 1),
('Banana split', 'Helado de banana con dulce de leche', 1),
('Chocolate blanco', 'Helado sabor chocolate blanco', 1),
('Tramontana', 'Dulce de leche con galletitas', 1),
('Americana', 'Helado sabor crema americana', 1);

-- 4. PRESENTACION
INSERT INTO Presentacion
(descripcion, cantidad, cant_min_sabores, cant_max_sabores)
VALUES
('Vaso chico', 0.15, 1, 2),
('Vaso mediano', 0.25, 1, 2),
('Vaso grande', 0.35, 1, 3),
('Cucurucho', 0.20, 1, 2),
('Cuarto kilo', 0.25, 1, 3),
('Medio kilo', 0.50, 1, 3),
('Tres cuartos kilo', 0.75, 1, 4),
('Un kilo', 1.00, 1, 4),

-- 5. CAJAS
INSERT INTO Cajas (numero_caja, estado)
VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1);

-- 6. PRODUCTO
INSERT INTO Producto (descripcion, stock, estado)
VALUES
('Helado sin TACC', 60, 1),
('Helado sin azucar', 50, 1),
('Helado vegano', 40, 1),
('Helado frutal', 75, 1),
('Helado crema', 90, 1),
('Helado chocolate', 85, 1),
('Helado especial', 45, 1),
('Helado clasico', 100, 1);

-- 7. METODO_PAGO
INSERT INTO Metodo_pago (nombre_metodo)
VALUES
('Efectivo'),
('Tarjeta de debito'),
('Tarjeta de credito'),
('Transferencia bancaria'),
('Pago con QR'),
('Billetera virtual'),
('Tarjeta prepaga'),
('Cuenta corriente'),

-- 8. APERTURA_CAJA
INSERT INTO Apertura_Caja
(monto_inicial, monto_cierre, fecha_hora_apertura, fecha_hora_cierre, id_vendedor, id_caja)
VALUES
(50000.00, 128500.00, '2026-09-21T10:00:00', '2026-09-21T18:00:00', 1, 1),
(45000.00, 112300.00, '2026-09-22T10:00:00', '2026-09-22T18:00:00', 2, 2),
(50000.00, 136700.00, '2026-09-23T10:00:00', '2026-09-23T18:00:00', 3, 3),
(55000.00, 145600.00, '2026-09-24T10:00:00', '2026-09-24T18:00:00', 4, 4),
(50000.00, 121900.00, '2026-09-25T10:00:00', '2026-09-25T18:00:00', 5, 5),
(60000.00, 158400.00, '2026-09-26T10:00:00', '2026-09-26T18:00:00', 6, 6),
(50000.00, 132700.00, '2026-09-27T10:00:00', '2026-09-27T18:00:00', 7, 7),
(45000.00, 119500.00, '2026-09-28T10:00:00', '2026-09-28T18:00:00', 8, 8),
(50000.00, 141200.00, '2026-09-29T10:00:00', '2026-09-29T18:00:00', 9, 9),
(55000.00, 151600.00, '2026-09-30T10:00:00', '2026-09-30T18:00:00', 10, 10);

-- 9. PRECIO
INSERT INTO Precio (fecha_desde, fecha_hasta, precio, id_presentacion)
VALUES
('2026-09-01', '2026-12-31', 2500.00, 1),
('2026-09-01', '2026-12-31', 3500.00, 2),
('2026-09-01', '2026-12-31', 4500.00, 3),
('2026-09-01', '2026-12-31', 3000.00, 4),
('2026-09-01', '2026-12-31', 5500.00, 5),
('2026-09-01', '2026-12-31', 9500.00, 6),
('2026-09-01', '2026-12-31', 13500.00, 7),
('2026-09-01', '2026-12-31', 17000.00, 8),
('2026-09-01', '2026-12-31', 23500.00, 9),
('2026-09-01', '2026-12-31', 30000.00, 10);

-- 10. SE_VENDE_EN
INSERT INTO Se_vende_en (id_producto, id_presentacion)
VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(3, 5),
(4, 6),
(5, 7),
(6, 8),
(7, 9),
(8, 10);

-- 11. VENTA
INSERT INTO Venta
(fecha_venta, hora_venta, id_cliente, id_apertura_caja, id_metodo_pago, id_vendedor)
VALUES
('2026-09-21', '11:15:00', 1, 1, 1, 1),
('2026-09-22', '12:30:00', 2, 2, 2, 2),
('2026-09-23', '13:10:00', 3, 3, 3, 3),
('2026-09-24', '14:20:00', 4, 4, 4, 4),
('2026-09-25', '15:05:00', 5, 5, 5, 5),
('2026-09-26', '16:15:00', 6, 6, 6, 6),
('2026-09-27', '12:45:00', 7, 7, 7, 7),
('2026-09-28', '13:35:00', 8, 8, 8, 8),
('2026-09-29', '14:50:00', 9, 9, 9, 9),
('2026-09-30', '16:40:00', 10, 10, 10, 10);

-- 12. DETALLE_VENTA
INSERT INTO Detalle_venta
(id_venta, cantidad, id_producto, precio_unitario, id_presentacion)
VALUES
(1, 2, 1, 2500.00, 1),
(2, 1, 1, 3500.00, 2),
(3, 2, 1, 4500.00, 3),
(4, 1, 2, 3000.00, 4),
(5, 1, 3, 5500.00, 5),
(6, 1, 4, 9500.00, 6),
(7, 1, 5, 13500.00, 7),
(8, 1, 6, 17000.00, 8),
(9, 1, 7, 23500.00, 9),
(10, 1, 8, 30000.00, 10);

-- 13. INCLUYE
INSERT INTO Incluye (id_sabor, id_venta, id_detalle_venta)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10);


-- CONSULTAS DE VERIFICACION
SELECT * FROM Vendedor;
SELECT * FROM Cliente;
SELECT * FROM Sabor;
SELECT * FROM Presentacion;
SELECT * FROM Cajas;
SELECT * FROM Producto;
SELECT * FROM Apertura_Caja;
SELECT * FROM Precio;
SELECT * FROM Se_vende_en;
SELECT * FROM Metodo_pago;
SELECT * FROM Venta;
SELECT * FROM Detalle_venta;
SELECT * FROM Incluye;
