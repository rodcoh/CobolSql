CREATE TABLE pagos_prestasmos (
	id_pago int PRIMARY KEY AUTO_INCREMENT,
    id_prestamos int,
    monto_pago decimal(10, 2),
    fecha_pago date,
    FOREIGN KEY (id_prestamos) REFERENCES prestamos(id_prestamos)
    );