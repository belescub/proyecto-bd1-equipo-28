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
('Nicolas', 'Romero', 34876543);

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

