DROP DATABASE BibliotecaArcana;
CREATE DATABASE BibliotecaArcana;
USE BibliotecaArcana;

CREATE TABLE SeccionEsoterica (
    id_seccion INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE Custodio (
    id_custodio INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    runico_id VARCHAR(12) UNIQUE,
    nivel_acceso ENUM('iniciado', 'archivero', 'maestro del saber'),
    correo_etereo VARCHAR(100)
);

CREATE TABLE TomoArcano (
    id_tomo INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200),
    sigla_magica VARCHAR(20) UNIQUE,
    autor VARCHAR(100),
    editorial_oculta VARCHAR(100),
    anio_descubrimiento INT,
    id_seccion INT,
    FOREIGN KEY (id_seccion) REFERENCES SeccionEsoterica(id_seccion)
);

CREATE TABLE ConjuroPrestamo (
    id_conjuro INT AUTO_INCREMENT PRIMARY KEY,
    fecha_invocacion DATE,
    fecha_retorno DATE,
    estado ENUM('activo', 'sellado', 'corrompido'),
    id_custodio INT,
    FOREIGN KEY (id_custodio) REFERENCES Custodio(id_custodio)
);

CREATE TABLE PactoDetalle (
    id_conjuro INT,
    id_tomo INT,
    PRIMARY KEY(id_conjuro, id_tomo),
    FOREIGN KEY (id_conjuro) REFERENCES ConjuroPrestamo(id_conjuro),
    FOREIGN KEY (id_tomo) REFERENCES TomoArcano(id_tomo)
);

--Función para ver cuantos prestamos hay activos
DELIMITER //
CREATE FUNCTION ConjurosActivos(custodio_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM ConjuroPrestamo
    WHERE id_custodio = custodio_id AND estado = 'activo';
    RETURN total;
END;
//
DELIMITER ;

--Procedimiento
DELIMITER //
CREATE PROCEDURE InvocarConjuro (
    IN fecha_ini DATE,
    IN fecha_fin DATE,
    IN estado_ ENUM('activo', 'sellado', 'corrompido'),
    IN id_custodio_ INT
)
BEGIN
    INSERT INTO ConjuroPrestamo(fecha_invocacion, fecha_retorno, estado, id_custodio)
    VALUES (fecha_ini, fecha_fin, estado_, id_custodio_);
END;
//
DELIMITER ;

--Vista para registro de Prestamos
CREATE VIEW RegistroArcano AS
SELECT 
    cp.id_conjuro,
    c.nombre AS custodio,
    ta.titulo AS tomo_arcano,
    se.nombre AS seccion,
    cp.fecha_invocacion,
    cp.fecha_retorno,
    cp.estado
FROM ConjuroPrestamo cp
JOIN Custodio c ON cp.id_custodio = c.id_custodio
JOIN PactoDetalle pd ON cp.id_conjuro = pd.id_conjuro
JOIN TomoArcano ta ON pd.id_tomo = ta.id_tomo
JOIN SeccionEsoterica se ON ta.id_seccion = se.id_seccion;

--Trigger Para evitar colocar mal la fecha 
DELIMITER //
CREATE TRIGGER evitar_conjuros_futuros
BEFORE INSERT ON ConjuroPrestamo
FOR EACH ROW
BEGIN
    IF NEW.fecha_invocacion > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Los conjuros no pueden invocarse desde el futuro.';
    END IF;
END;
//
DELIMITER ;

--Indices
CREATE INDEX runa_custodio ON Custodio(runico_id);
CREATE INDEX sigla_tomo ON TomoArcano(sigla_magica);
