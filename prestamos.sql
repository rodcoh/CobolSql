CREATE TABLE prestamos (
	id_prestamos int PRIMARY KEY AUTO_INCREMENT,
    id_cliente int,
    monto decimal(10, 2),
    tasa_interes decimal(5, 2),
    plazo_meses int,
    saldo_actual decimal(10, 2),
    fecha_otorgamiento date,
    fecha_vencimiento date,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
    );