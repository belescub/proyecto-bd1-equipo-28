CREATE DATABASE ICE_SQL
USE ICE_SQL;
GO

CREATE TABLE Vendedor (
id_vendedor INT IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(50) NOT NULL,
dni BIGINT UNIQUE NOT NULL
);

CREATE TABLE Cliente(
id_cliente INT IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
dni BIGINT UNIQUE NOT NULL,
telefono VARCHAR(20) NOT NULL,
email VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Sabor(
id_sabor INT IDENTITY(1,1) PRIMARY KEY,
nombre_sabor VARCHAR(50) NOT NULL,
descripcion VARCHAR(100) NOT NULL,
estado BIT NOT NULL DEFAULT 1
);

CREATE TABLE Presentacion(
id_presentacion INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
descripcion VARCHAR(100) NOT NULL,
cantidad DECIMAL (5,2) NULL,
cant_min_sabores INT NOT NULL DEFAULT 1,
cant_max_sabores INT NOT NULL
);

CREATE TABLE Cajas(
id_caja INT IDENTITY(1,1) PRIMARY KEY,
numero_caja INT UNIQUE NOT NULL,
estado BIT NOT NULL DEFAULT 1
);

--TABLAS MAURICIO (NO SE RELACIONA CON NINGUNA)
CREATE TABLE Producto(
id_producto INT IDENTITY (1,1) PRIMARY KEY,
descripción VARCHAR(30) NOT NULL,
stock INT NOT NULL,
estado BIT NOT NULL DEFAULT 1
);
--TABLAS INGRID
CREATE TABLE Apertura_Caja (
	id_apertura_caja INT IDENTITY(1,1) PRIMARY KEY, 	
	monto_inicial DECIMAL (10,2) NOT NULL, 
	monto_cierre DECIMAL (10,2) NOT NULL, 
	fecha_hora_apertura DATETIME NOT NULL, 
	fecha_hora_cierre DATETIME NOT NULL, 
	id_vendedor INT, 
	id_caja INT, 
	CONSTRAINT fk_id_vendedor FOREIGN KEY (id_vendedor) REFERENCES Vendedor(id_vendedor), 
	CONSTRAINT fk_id_caja FOREIGN KEY (id_caja) REFERENCES Cajas (id_caja)
);

CREATE TABLE Precio (
	id_precio INT IDENTITY (1,1) PRIMARY KEY, 
	fecha_desde DATE NOT NULL, 
	fecha_hasta DATE NOT NULL, 
	precio DECIMAL (10,2) NOT NULL, 
	id_presentacion INT, 
	CONSTRAINT fk_id_presentacion FOREIGN KEY (id_presentacion) REFERENCES Presentacion(id_presentacion) 
);

--TABLAS MAURICIO
CREATE TABLE Se_vende_en(
id_producto INT IDENTITY (1,1),
id_presentacion INT NOT NULL,
CONSTRAINT pk_se_vende_en PRIMARY KEY (id_producto, id_presentacion),
CONSTRAINT fk_id_presentacion_2 FOREIGN KEY (id_presentacion) REFERENCES Presentacion
(id_presentacion),
CONSTRAINT  fk_id_producto FOREIGN KEY (id_producto) REFERENCES Producto (id_producto)
);

CREATE TABLE Metodo_pago(
id_metodo_pago INT IDENTITY (1,1) PRIMARY KEY,
nombre_metodo VARCHAR(50) NOT NULL
);

--TABLAS INGRID
CREATE TABLE Venta (
	id_venta INT IDENTITY(1,1) PRIMARY KEY, 
	fecha_venta DATE NOT NULL, 
	hora_venta TIME NOT NULL, 
	id_cliente INT, 
	id_apertura_caja INT, 
	id_metodo_pago INT, 
	id_vendedor INT, 
	CONSTRAINT fk_id_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente), 
	CONSTRAINT fk_id_apertura_caja FOREIGN KEY (id_apertura_caja) REFERENCES Apertura_Caja(id_apertura_caja), 
	CONSTRAINT fk_id_metodo_pago FOREIGN KEY (id_metodo_pago) REFERENCES Metodo_Pago(id_metodo_pago), 
	CONSTRAINT fk_id_vendedor_2 FOREIGN KEY (id_vendedor) REFERENCES Vendedor(id_vendedor)
);

--TABLAS MAURICIO
CREATE TABLE Detalle_venta(
id_detalle_venta INT IDENTITY (1,1),
id_venta INT NOT NULL,
cantidad INT NOT NULL,
id_producto INT NOT NULL,
precio_unitario DECIMAL (10,2) NOT NULL,
id_presentacion INT NOT NULL,
CONSTRAINT pk_detalle_venta PRIMARY KEY (id_venta, id_detalle_venta),
CONSTRAINT fk_id_venta FOREIGN KEY (id_venta) REFERENCES Venta(id_venta),
CONSTRAINT fk_se_vende_en FOREIGN KEY (id_producto,id_presentacion) REFERENCES Se_vende_en(id_producto, id_presentacion)
);

--TABLAS INGRID
CREATE TABLE Incluye (
	id_sabor INT, 
	id_venta INT NOT NULL,
	id_detalle_venta INT, 
	CONSTRAINT pk_incluye PRIMARY KEY (id_sabor, id_detalle_venta),
    CONSTRAINT fk_inc_sabor FOREIGN KEY (id_sabor) REFERENCES Sabor(id_sabor),
    CONSTRAINT fk_inc_detalle FOREIGN KEY (id_venta, id_detalle_venta) REFERENCES Detalle_venta(id_venta, id_detalle_venta)
);
