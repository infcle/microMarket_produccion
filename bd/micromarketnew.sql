-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.26-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para marketbbdd
CREATE DATABASE IF NOT EXISTS `marketbbdd` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `marketbbdd`;

-- Volcando estructura para procedimiento marketbbdd.buscar_cliente
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_cliente`(in carnet varchar(20))
BEGIN
      SELECT * FROM cliente WHERE ci=carnet;
    END//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.buscar_usuario
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_usuario`(
in usu varchar(100)
)
BEGIN
SELECT id_usuario,nombre, usuario, estado, contrasenia, tipo
                            FROM usuario_login
                            WHERE usuario = usu AND estado=1;
end//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.cantidad_peso
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `cantidad_peso`()
BEGIN
       SELECT p.id_prod,p.nro_plu
			, p.nombre as nomProducto
			, CASE p.tipo WHEN 1 THEN 'Cantidad' WHEN 2 THEN 'Peso' END AS tipo
			, p.precio, p.cod_plu, s.nombre as nomSeccion
		FROM producto p, seccion s
		WHERE p.idseccion = s.id_seccion and p.estado=1;
    END//
DELIMITER ;

-- Volcando estructura para tabla marketbbdd.cliente
CREATE TABLE IF NOT EXISTS `cliente` (
  `id_cliente` bigint(20) NOT NULL AUTO_INCREMENT,
  `ci` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `nombre` varchar(200) COLLATE utf8_spanish2_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `ci_UNIQUE` (`ci`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla marketbbdd.compra_r
CREATE TABLE IF NOT EXISTS `compra_r` (
  `id_compra` bigint(20) NOT NULL,
  `nro_recibo` varchar(500) COLLATE utf8_spanish2_ci NOT NULL,
  `total` float NOT NULL,
  `total_literal` varchar(150) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fecha` datetime NOT NULL,
  `id_cliente` bigint(20) NOT NULL,
  `id_usuario` bigint(20) NOT NULL,
  `estado` int(11) DEFAULT NULL COMMENT 'esta pordefinirse los estados que se tendra',
  PRIMARY KEY (`id_compra`),
  KEY `FK_CLI_DET` (`id_cliente`),
  KEY `FK_USER_DET` (`id_usuario`),
  CONSTRAINT `FK_CLI_DET` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_USER_DET` FOREIGN KEY (`id_usuario`) REFERENCES `usuario_login` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para procedimiento marketbbdd.detalleVentasPorRangoFechas
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `detalleVentasPorRangoFechas`(
	IN `fecha_a` DATE,
	IN `fecha_b` DATE



)
BEGIN
select p.nro_plu, p.nombre, p.precio, pe.peso_cantidad, pe.preciototal,date(c.fecha) as fecha 
		from producto p, producto_etiquetado pe, compra_r c 
				where p.id_prod=pe.id_prod and pe.id_compra= c.id_compra and date(c.fecha) BETWEEN fecha_a and fecha_b;
END//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.detalle_venta
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `detalle_venta`(in id int)
BEGIN
select p.nro_plu, p.nombre, p.precio, pe.peso_cantidad, pe.preciototal  
		from producto p, producto_etiquetado pe, compra_r c 
				where p.id_prod=pe.id_prod and pe.id_compra= c.id_compra and pe.id_compra=id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.eliminarCliente
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarCliente`(
in id_c int
)
BEGIN
delete from cliente where id_cliente=id_c;
END//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.eliminarProducto
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarProducto`(
in id_p int
)
BEGIN
UPDATE producto set estado=0 where id_prod=id_p;
end//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.eliminarUsuario
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarUsuario`(
in id_u int
)
BEGIN
delete from usuario_login where id_usuario=id_u;
END//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.existe_usuario
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `existe_usuario`(in usu varchar(100), out valor bool)
BEGIN
set valor =false;
if exists(select usuario from usuario_login where usuario=usu)
    
    then
        set valor= true;
    else 
        set valor = false;
    end if;
END//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.genera_plu
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `genera_plu`()
BEGIN
      SELECT IFNULL(MAX(nro_plu),0)+1  AS numero FROM producto;
    END//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.insertarcliente
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarcliente`(
in ci varchar(20),
in Nombre varchar(200)
)
BEGIN
insert into cliente(ci,nombre) values(ci,nombre);
END//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.insertarProducto
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarProducto`(
IN nro_plu_p INT,
IN nombre_p VARCHAR(100),
IN tipo_p INT,
IN precio_p FLOAT,
IN cod_plu_p VARCHAR(200),
IN id_seccion BIGINT(11)
)
BEGIN
INSERT INTO producto (nro_plu,nombre,tipo,precio,cod_plu,fecha_registro,idseccion)VALUES(nro_plu_p,nombre_p,tipo_p,precio_p,cod_plu_p,NOW(),id_seccion);
END//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.insertarTiene
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarTiene`( in idp bigint, in ids bigint)
BEGIN
    insert into tiene values(ids,idp);	
    END//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.insertarUsuario
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarUsuario`(
in Nombre varchar(200),
in fecha_registro datetime,
in Usuario varchar(100),
in contrasenia varchar(255),
in tipo int(11)
)
BEGIN
insert into usuario_login(nombre, fecha_registro, usuario, contrasenia, tipo) values(Nombre,fecha_registro,Usuario,contrasenia,tipo);
END//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.listar_seccion
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_seccion`()
BEGIN
      SELECT * FROM seccion where estado=1;
    END//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.lista_clientes
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_clientes`(
in cat bigint)
BEGIN
select * from cliente;
END//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.lista_productos
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_productos`()
BEGIN
select p.nro_plu, p.nombre as nombreuno ,p.tipo as tipo,p.precio,p.cod_plu, s.nombre as nombredos  from producto p, seccion s where idseccion=id_seccion order by p.nro_plu; 
END//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.modificarCliente
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarCliente`(
in id_c int,
in ci varchar(20),
in Nombre varchar(200)
)
BEGIN
update cliente set nombre=Nombre, ci=ci where id_cliente=id_c;
END//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.modificarUsuario
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarUsuario`(
in id_u int,
in Nombre varchar(200),
in fecha_reg datetime,
in Usuario varchar(100),
in contrasenia varchar(255),
in estado tinyint(1),
in tipo int(11)
)
BEGIN
update usuario_login set nombre=Nombre, fecha_registro=fecha_reg,usuario=Usuario,contrasenia=contrasenia,estado=estado,tipo=tipo where id_usuario=id_u;
END//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.modificar_producto
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_producto`(
in nombre_p varchar(100),
in precio_p float,
in tipo_p int,
in plu varchar(200),
in seccion bigint,
in id_p bigint
)
BEGIN
UPDATE producto set nombre=nombre_p, precio=precio_p, tipo=tipo_p, cod_plu=plu, idSeccion=seccion where id_prod=id_p;
end//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.Numeros_a_Letras
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Numeros_a_Letras`(IN lnEntero TEXT)
BEGIN
DECLARE lcRetorno VARCHAR(512);
DECLARE lnTerna INT;
DECLARE lcMiles VARCHAR(512);
DECLARE lcCadena VARCHAR(512);
DECLARE lnUnidades INT;
DECLARE lnDecenas INT;
DECLARE lnCentenas INT;
IF lnEntero > 0 THEN
SET lcRetorno = '';
SET lnTerna = 1 ;
WHILE lnEntero > 0 DO
-- Recorro columna por columna
SET lcCadena = '';
SET lnUnidades = RIGHT(lnEntero,1);
SET lnEntero = LEFT(lnEntero,LENGTH(lnEntero)-1) ;
SET lnDecenas = RIGHT(lnEntero,1);
SET lnEntero = LEFT(lnEntero,LENGTH(lnEntero)-1) ;
SET lnCentenas = RIGHT(lnEntero,1);
SET lnEntero = LEFT(lnEntero,LENGTH(lnEntero)-1) ;
-- Analizo las unidades
SET lcCadena =
CASE /* UNIDADES */
WHEN lnUnidades = 1 AND lnTerna = 1 THEN CONCAT('UNO ',lcCadena)
WHEN lnUnidades = 1 AND lnTerna <> 1 THEN CONCAT('',lcCadena)
WHEN lnUnidades = 2 THEN CONCAT('DOS ',lcCadena)
WHEN lnUnidades = 3 THEN CONCAT('TRES ',lcCadena)
WHEN lnUnidades = 4 THEN CONCAT('CUATRO ',lcCadena)
WHEN lnUnidades = 5 THEN CONCAT('CINCO ',lcCadena)
WHEN lnUnidades = 6 THEN CONCAT('SEIS ',lcCadena)
WHEN lnUnidades = 7 THEN CONCAT('SIETE ',lcCadena)
WHEN lnUnidades = 8 THEN CONCAT('OCHO ',lcCadena)
WHEN lnUnidades = 9 THEN CONCAT('NUEVE ',lcCadena)
ELSE lcCadena
END ;/* UNIDADES */
-- Analizo las decenas
SET lcCadena =
CASE /* DECENAS */
WHEN lnDecenas = 1 THEN
CASE lnUnidades
WHEN 0 THEN 'DIEZ '
WHEN 1 THEN 'ONCE '
WHEN 2 THEN 'DOCE '
WHEN 3 THEN 'TRECE '
WHEN 4 THEN 'CATORCE '
WHEN 5 THEN 'QUINCE '
ELSE CONCAT('DIECI',lcCadena)
END
WHEN lnDecenas = 2 AND lnUnidades = 0 THEN CONCAT('VEINTE ',lcCadena)
WHEN lnDecenas = 2 AND lnUnidades <> 0 THEN CONCAT('VEINTI',lcCadena)
WHEN lnDecenas = 3 AND lnUnidades = 0 THEN CONCAT('TREINTA ',lcCadena)
WHEN lnDecenas = 3 AND lnUnidades <> 0 THEN CONCAT('TREINTA Y ',lcCadena)
WHEN lnDecenas = 4 AND lnUnidades = 0 THEN CONCAT('CUARENTA ',lcCadena)
WHEN lnDecenas = 4 AND lnUnidades <> 0 THEN CONCAT('CUARENTA Y ',lcCadena)
WHEN lnDecenas = 5 AND lnUnidades = 0 THEN CONCAT('CINCUENTA ',lcCadena)
WHEN lnDecenas = 5 AND lnUnidades <> 0 THEN CONCAT('CINCUENTA Y ',lcCadena)
WHEN lnDecenas = 6 AND lnUnidades = 0 THEN CONCAT('SESENTA ',lcCadena)
WHEN lnDecenas = 6 AND lnUnidades <> 0 THEN CONCAT('SESENTA Y ',lcCadena)
WHEN lnDecenas = 7 AND lnUnidades = 0 THEN CONCAT('SETENTA ',lcCadena)
WHEN lnDecenas = 7 AND lnUnidades <> 0 THEN CONCAT('SETENTA Y ',lcCadena)
WHEN lnDecenas = 8 AND lnUnidades = 0 THEN CONCAT('OCHENTA ',lcCadena)
WHEN lnDecenas = 8 AND lnUnidades <> 0 THEN CONCAT('OCHENTA Y ',lcCadena)
WHEN lnDecenas = 9 AND lnUnidades = 0 THEN CONCAT('NOVENTA ',lcCadena)
WHEN lnDecenas = 9 AND lnUnidades <> 0 THEN CONCAT('NOVENTA Y ',lcCadena)
ELSE lcCadena
END ;/* DECENAS */
-- Analizo las centenas
SET lcCadena =
CASE /* CENTENAS */
WHEN lnCentenas = 1 AND lnUnidades = 0 AND lnDecenas = 0 THEN CONCAT('CIEN ',lcCadena)
WHEN lnCentenas = 1 AND NOT(lnUnidades = 0 AND lnDecenas = 0) THEN CONCAT('CIENTO ',lcCadena)
WHEN lnCentenas = 2 THEN CONCAT('DOSCIENTOS ',lcCadena)
WHEN lnCentenas = 3 THEN CONCAT('TRESCIENTOS ',lcCadena)
WHEN lnCentenas = 4 THEN CONCAT('CUATROCIENTOS ',lcCadena)
WHEN lnCentenas = 5 THEN CONCAT('QUINIENTOS ',lcCadena)
WHEN lnCentenas = 6 THEN CONCAT('SEISCIENTOS ',lcCadena)
WHEN lnCentenas = 7 THEN CONCAT('SETECIENTOS ',lcCadena)
WHEN lnCentenas = 8 THEN CONCAT('OCHOCIENTOS ',lcCadena)
WHEN lnCentenas = 9 THEN CONCAT('NOVECIENTOS ',lcCadena)
ELSE lcCadena
END ;/* CENTENAS */
-- Analizo los millares
SET lcCadena =
CASE /* TERNA */
WHEN lnTerna = 1 THEN lcCadena
WHEN lnTerna = 2 AND (lnUnidades + lnDecenas + lnCentenas <> 0) THEN CONCAT(lcCadena,' MIL ')
WHEN lnTerna = 3 AND (lnUnidades + lnDecenas + lnCentenas <> 0) AND lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0 THEN CONCAT(lcCadena,' MILLON ')
WHEN lnTerna = 3 AND (lnUnidades + lnDecenas + lnCentenas <> 0) AND NOT (lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0) THEN CONCAT(lcCadena,' MILLONES ')
WHEN lnTerna = 4 AND (lnUnidades + lnDecenas + lnCentenas <> 0) THEN CONCAT(lcCadena,' MIL MILLONES ')
WHEN lnTerna = 5 AND (lnUnidades + lnDecenas + lnCentenas <> 0) AND lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0 THEN CONCAT(lcCadena,' BILLON ')
WHEN lnTerna = 5 AND (lnUnidades + lnDecenas + lnCentenas <> 0) AND NOT (lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0) THEN CONCAT(lcCadena,' BILLONES ')
WHEN lnTerna = 6 AND (lnUnidades + lnDecenas + lnCentenas <> 0) THEN CONCAT(lcCadena,' MIL BILLONES ')
WHEN lnTerna = 7 AND (lnUnidades + lnDecenas + lnCentenas <> 0) AND lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0 THEN CONCAT(lcCadena,' TRILLON ')
WHEN lnTerna = 7 AND (lnUnidades + lnDecenas + lnCentenas <> 0) AND NOT (lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0) THEN CONCAT(lcCadena,' TRILLONES ')
WHEN lnTerna = 8 AND (lnUnidades + lnDecenas + lnCentenas <> 0) THEN CONCAT(lcCadena,' MIL TRILLONES ')
ELSE ''
END ;/* MILLARES */
-- Armo el retorno columna a columna
SET lcRetorno = CONCAT(lcCadena,lcRetorno);
SET lnTerna = lnTerna + 1;
END WHILE ; /* WHILE */
ELSE
SET lcRetorno = 'CERO' ;
END IF ;
SELECT RTRIM(lcRetorno) ;
END//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.obtener_id_producto
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_id_producto`( in nro_plu_F int)
BEGIN
       select id_prod from producto where nro_plu=nro_plu_F;
    END//
DELIMITER ;

-- Volcando estructura para tabla marketbbdd.producto
CREATE TABLE IF NOT EXISTS `producto` (
  `id_prod` bigint(20) NOT NULL AUTO_INCREMENT,
  `nro_plu` int(11) NOT NULL COMMENT 'es el numero que esta registrado en la balanza',
  `nombre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `tipo` int(11) NOT NULL COMMENT 'si es pesable 2 y si es unidad 1',
  `precio` float NOT NULL,
  `cod_plu` varchar(200) COLLATE utf8_spanish2_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `fecha_registro` datetime NOT NULL,
  `fecha_actualizacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_limite` bigint(11) DEFAULT NULL,
  `idseccion` bigint(20) NOT NULL,
  PRIMARY KEY (`id_prod`),
  UNIQUE KEY `nro_plu_UNIQUE` (`nro_plu`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  UNIQUE KEY `cod_plu_UNIQUE` (`cod_plu`),
  KEY `fk_producto_seccion1_idx` (`idseccion`),
  CONSTRAINT `fk_producto_seccion1` FOREIGN KEY (`idseccion`) REFERENCES `seccion` (`id_seccion`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para procedimiento marketbbdd.producto_categoria
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `producto_categoria`(
in cat bigint)
BEGIN
select * from producto where id_cat=cat;
END//
DELIMITER ;

-- Volcando estructura para tabla marketbbdd.producto_etiquetado
CREATE TABLE IF NOT EXISTS `producto_etiquetado` (
  `id_etiqueta` bigint(20) NOT NULL AUTO_INCREMENT,
  `cod_barras` bigint(11) NOT NULL COMMENT 'codigo de barras generado por productos etiquetados',
  `preciototal` float NOT NULL COMMENT 'precio deacurdo al peso o cantidad del producto',
  `peso_cantidad` float NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'estado si se vendio o no',
  `id_prod` bigint(20) DEFAULT NULL,
  `id_compra` bigint(20) DEFAULT NULL COMMENT 'aqui esta el id de la compra si es que se vende este producto',
  PRIMARY KEY (`id_etiqueta`),
  KEY `FK_PROD_DET` (`id_prod`),
  KEY `FK_COMPRA_DET` (`id_compra`),
  CONSTRAINT `FK_COMPRA_DET` FOREIGN KEY (`id_compra`) REFERENCES `compra_r` (`id_compra`),
  CONSTRAINT `FK_PROD_DET` FOREIGN KEY (`id_prod`) REFERENCES `producto` (`id_prod`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para procedimiento marketbbdd.Recibo_cliente
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Recibo_cliente`(in id_r int)
BEGIN
select r.nro_recibo, r.fecha , c.nombre , c.ci, r.total, r.total_literal, r.fecha from compra_r r, cliente c where c.id_cliente=r.id_cliente and r.id_compra=id_r;
END//
DELIMITER ;

-- Volcando estructura para procedimiento marketbbdd.reporte_dia
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `reporte_dia`()
    COMMENT 'crea el reporte de ventas por dia por caja o usuario que atendia'
BEGIN
select r.nro_recibo, r.fecha , c.nombre , c.ci, r.total,p.nombre, p.precio, pe.peso_cantidad, pe.preciototal
	from cliente c,producto p, producto_etiquetado pe, compra_r r 
		where c.id_cliente=r.id_cliente 
			and c.ci='6846341' and r.fecha='2018-03-05 15:25:14'  
            and p.id_prod=pe.id_prod ;
END//
DELIMITER ;

-- Volcando estructura para tabla marketbbdd.seccion
CREATE TABLE IF NOT EXISTS `seccion` (
  `id_seccion` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) COLLATE utf8_spanish2_ci NOT NULL,
  `limite` int(11) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `fecha_registro` datetime NOT NULL,
  `fecha_actualizacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_categoria` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_seccion`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para procedimiento marketbbdd.usuario_estado1
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `usuario_estado1`()
BEGIN
select * from usuario_login where estado=1;
END//
DELIMITER ;

-- Volcando estructura para tabla marketbbdd.usuario_login
CREATE TABLE IF NOT EXISTS `usuario_login` (
  `id_usuario` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) COLLATE utf8_spanish2_ci NOT NULL,
  `usuario` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `contrasenia` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `tipo` int(11) NOT NULL DEFAULT '2',
  `fecha_registro` datetime NOT NULL,
  `fecha_actualizacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `usuario_UNIQUE` (`usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- La exportación de datos fue deseleccionada.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
