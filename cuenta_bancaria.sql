CREATE TABLE cuentas_bancarias (
	id_cuenta int PRIMARY KEY UNIQUE,
    id_cliente int,
    saldo DECIMAL(10, 2),
	tipo_cuenta varchar(20) NOT NULL,
    fecha_apertura date,
    FOREIGN KEY (id_cuenta) REFERENCES clientes(id_cliente)
    );