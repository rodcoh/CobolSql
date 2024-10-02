CREATE TABLE clientes (
	id_cliente int PRIMARY KEY UNIQUE,
    nombre_cliente varchar(50) NOT NULL,
    direccion_cliente varchar(100),
    telefono_cliente varchar(20) NOT NULL
    );