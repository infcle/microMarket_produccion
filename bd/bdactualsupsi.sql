/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.19 : Database - marketbd
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`marketbd` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `marketbd`;

/*Table structure for table `cliente` */

DROP TABLE IF EXISTS `cliente`;

CREATE TABLE `cliente` (
  `id_cliente` bigint(20) NOT NULL AUTO_INCREMENT,
  `ci` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `nombre` varchar(200) COLLATE utf8_spanish2_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `ci_UNIQUE` (`ci`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

/*Data for the table `cliente` */

insert  into `cliente`(`id_cliente`,`ci`,`nombre`,`estado`,`fecha_registro`) values (2,'4038952','peppito',1,'2018-08-11 21:00:42'),(3,'1234567','juan',1,'2018-08-11 21:27:02'),(4,'123456','pepito',1,'2018-08-11 22:38:44');

/*Table structure for table `compra_r` */

DROP TABLE IF EXISTS `compra_r`;

CREATE TABLE `compra_r` (
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

/*Data for the table `compra_r` */

insert  into `compra_r`(`id_compra`,`nro_recibo`,`total`,`total_literal`,`fecha`,`id_cliente`,`id_usuario`,`estado`) values (1,'1',73.75,'SETENTA Y TRES con 75/100 Bs.','2018-08-11 21:00:53',2,2,NULL),(2,'2',73.75,'SETENTA Y TRES con 75/100 Bs.','2018-08-11 21:04:00',2,2,NULL),(3,'3',1.35,'UNO con 35/100 Bs.','2018-08-11 22:03:14',3,2,NULL),(4,'4',15.7,'QUINCE con 70 100 Bs.','2018-08-11 22:20:54',3,2,NULL),(5,'5',32.15,'TREINTA Y DOS con 15/100 Bs.','2018-08-11 22:40:18',4,3,NULL);

/*Table structure for table `producto` */

DROP TABLE IF EXISTS `producto`;

CREATE TABLE `producto` (
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

/*Data for the table `producto` */

insert  into `producto`(`id_prod`,`nro_plu`,`nombre`,`tipo`,`precio`,`cod_plu`,`estado`,`fecha_registro`,`fecha_actualizacion`,`id_limite`,`idseccion`) values (62,1,'filete',2,50,'2001',1,'2018-08-09 14:32:32','2018-08-09 14:32:32',NULL,1),(63,2,'pulpa',2,45,'2002',1,'2018-08-09 14:33:18','2018-08-09 14:33:18',NULL,1),(64,3,'cabeza de lomo',2,45,'2003',1,'2018-08-09 14:33:51','2018-08-09 14:33:51',NULL,1),(65,4,'peceto',2,42,'2004',1,'2018-08-09 14:34:13','2018-08-09 14:34:13',NULL,1),(66,5,'punta de s',2,45,'2005',1,'2018-08-09 14:34:35','2018-08-09 14:34:35',NULL,1),(67,6,'molida',2,38,'2006',1,'2018-08-09 14:34:57','2018-08-09 14:34:57',NULL,1),(68,7,'albondiga',2,26,'2007',1,'2018-08-09 14:35:21','2018-08-09 14:35:21',NULL,1),(69,8,'milaneza de carne',2,18,'2008',1,'2018-08-09 14:35:46','2018-08-09 14:35:46',NULL,1),(70,9,'lapimg',2,36,'2009',1,'2018-08-09 14:36:25','2018-08-09 14:36:25',NULL,1),(71,10,'chuleta',2,38,'2010',1,'2018-08-09 14:36:53','2018-08-09 14:36:53',NULL,1),(72,11,'witu',2,36,'2011',1,'2018-08-09 14:37:17','2018-08-09 14:37:17',NULL,1),(73,12,'churrasco',2,36,'2012',1,'2018-08-09 14:38:04','2018-08-09 14:38:04',NULL,1),(74,13,'cadera',2,36,'2013',1,'2018-08-09 14:38:27','2018-08-09 14:38:27',NULL,1),(75,14,'paleta',2,36,'2014',1,'2018-08-09 14:39:09','2018-08-09 14:39:09',NULL,1),(76,15,'pecho',2,30,'2015',1,'2018-08-09 14:39:35','2018-08-09 14:39:35',NULL,1),(77,16,'jiba',2,30,'2016',1,'2018-08-09 14:40:03','2018-08-09 14:40:03',NULL,1),(78,17,'aujilla',2,30,'2017',1,'2018-08-09 14:40:28','2018-08-09 14:40:28',NULL,1),(79,18,'tira/costilla',2,34,'2018',1,'2018-08-09 14:41:02','2018-08-09 14:41:02',NULL,1),(80,19,'ozubuco',2,28,'2019',1,'2018-08-09 14:41:27','2018-08-09 14:41:27',NULL,1),(81,20,'canastitas',2,18,'2020',1,'2018-08-09 14:41:49','2018-08-09 14:41:49',NULL,1),(82,21,'chorizo',2,36,'2021',1,'2018-08-09 14:42:11','2018-08-09 14:42:11',NULL,1),(83,22,'corazon',2,30,'2022',1,'2018-08-09 14:42:39','2018-08-09 14:42:39',NULL,1),(84,23,'higado',2,22,'2023',1,'2018-08-09 14:42:55','2018-08-09 14:42:55',NULL,1),(85,24,'panza cocida',2,32,'2024',1,'2018-08-09 14:43:20','2018-08-09 14:43:20',NULL,1),(86,25,'pollo',2,15,'2025',1,'2018-08-09 14:43:52','2018-08-09 14:43:52',NULL,1),(87,26,'pierna de pollo',2,15,'2026',1,'2018-08-09 14:44:09','2018-08-09 14:44:09',NULL,1),(88,27,'alas de pollo',2,15,'2027',1,'2018-08-09 14:44:32','2018-08-09 14:44:32',NULL,1),(89,28,'pecho de pollo',2,15,'2028',1,'2018-08-09 14:44:56','2018-08-09 14:44:56',NULL,1),(90,29,'molida de pollo',2,12,'2029',1,'2018-08-09 14:45:32','2018-08-09 14:45:32',NULL,1),(91,30,'milaneza de pollo',2,16,'2030',1,'2018-08-09 14:45:51','2018-08-09 14:45:51',NULL,1),(92,31,'pescado trucha',2,45,'2031',1,'2018-08-09 14:46:16','2018-08-09 14:46:16',NULL,1),(93,32,'pescado pacu',2,50,'2032',1,'2018-08-09 14:46:48','2018-08-09 14:46:48',NULL,1),(94,33,'pescado surubi',2,50,'2033',1,'2018-08-09 14:47:16','2018-08-09 14:47:16',NULL,1),(95,34,'huevo25',1,25,'1034',1,'2018-08-09 14:47:42','2018-08-09 14:47:42',NULL,1),(96,35,'huevo22',1,0.73,'1035',1,'2018-08-09 14:48:04','2018-08-09 14:48:04',NULL,1),(97,36,'zanahoria',2,4,'2036',1,'2018-08-09 14:49:13','2018-08-09 14:49:13',NULL,2),(98,37,'haba',2,8,'2037',1,'2018-08-09 14:49:54','2018-08-09 14:49:54',NULL,2),(99,38,'zapallo',2,6,'2038',1,'2018-08-09 14:58:25','2018-08-09 14:58:25',NULL,2),(100,39,'cebolla con cola',2,4.5,'2039',1,'2018-08-09 14:58:46','2018-08-09 14:58:46',NULL,2),(101,40,'cebolla/cabeza',2,6,'2040',1,'2018-08-09 14:59:08','2018-08-09 14:59:08',NULL,2),(102,41,'tomate',2,9,'2041',1,'2018-08-09 14:59:45','2018-08-09 14:59:45',NULL,2),(103,42,'achojcha',2,3,'2042',1,'2018-08-09 15:00:44','2018-08-09 15:00:44',NULL,2),(104,43,'remolacha',2,4,'2043',1,'2018-08-09 15:01:24','2018-08-09 15:01:24',NULL,2),(105,44,'vainita',2,9,'2044',1,'2018-08-09 15:01:49','2018-08-09 15:01:49',NULL,2),(106,45,'arveja',2,15,'2045',1,'2018-08-09 15:02:35','2018-08-09 15:02:35',NULL,2),(107,46,'yuca',2,8.5,'2046',1,'2018-08-09 15:02:54','2018-08-09 15:02:54',NULL,2),(108,47,'perejil',2,3,'2047',1,'2018-08-09 15:03:16','2018-08-09 15:03:16',NULL,2),(109,48,'camote',2,11.5,'2048',1,'2018-08-09 15:03:41','2018-08-09 15:03:41',NULL,2),(110,49,'papa grande',2,6.5,'2049',1,'2018-08-09 15:04:03','2018-08-09 15:04:03',NULL,2),(111,50,'papa pequeÃ±a',2,5,'2050',1,'2018-08-09 15:04:28','2018-08-09 15:04:28',NULL,2),(112,51,'papa holandesa',2,6,'2051',1,'2018-08-09 15:04:56','2018-08-09 15:04:56',NULL,2),(113,52,'papa liza',2,4,'2052',1,'2018-08-09 15:05:10','2018-08-09 15:05:10',NULL,2),(114,53,'papa morada',2,4.5,'2053',1,'2018-08-09 15:05:30','2018-08-09 15:05:30',NULL,2),(115,54,'espinaca',2,10,'2054',1,'2018-08-09 15:07:15','2018-08-09 15:07:15',NULL,2),(116,55,'brocoli',2,10,'2055',1,'2018-08-09 15:07:33','2018-08-09 15:07:33',NULL,2),(117,56,'apio',2,3,'2056',1,'2018-08-09 15:08:09','2018-08-09 15:08:09',NULL,2),(118,57,'acelga',2,4,'2057',1,'2018-08-09 15:08:47','2018-08-09 15:08:47',NULL,2),(119,58,'repollo',2,4,'2058',1,'2018-08-09 15:09:06','2018-08-09 15:09:06',NULL,2),(120,59,'coliflor',2,3,'2059',1,'2018-08-09 15:09:29','2018-08-09 15:09:29',NULL,2),(121,60,'berro',2,5,'2060',1,'2018-08-09 15:09:54','2018-08-09 15:09:54',NULL,2),(122,61,'pepino',2,2,'2061',1,'2018-08-09 15:10:10','2018-08-09 15:10:10',NULL,2),(123,62,'berenjena',2,5,'2062',1,'2018-08-09 15:10:24','2018-08-09 15:10:24',NULL,2),(124,63,'pimenton',2,1.5,'2063',1,'2018-08-09 15:10:42','2018-08-09 15:10:42',NULL,2),(125,64,'platano de freir',1,1.5,'1064',1,'2018-08-09 15:11:00','2018-08-09 15:11:00',NULL,2),(126,65,'durazno',2,1,'2065',1,'2018-08-09 15:19:44','2018-08-09 15:19:44',NULL,3),(127,66,'uva',2,1,'2066',1,'2018-08-09 15:20:04','2018-08-09 15:20:04',NULL,3),(128,67,'frutilla',2,1,'2067',1,'2018-08-09 15:20:18','2018-08-09 15:20:18',NULL,3),(129,68,'achachairu',2,1,'2068',1,'2018-08-09 15:20:50','2018-08-09 15:20:50',NULL,3),(130,69,'asai',2,1,'2069',1,'2018-08-09 15:21:22','2018-08-09 15:21:22',NULL,3),(131,70,'sandia',2,1,'2070',1,'2018-08-09 15:22:01','2018-08-09 15:22:01',NULL,3),(132,71,'chirimoya',1,1,'1071',1,'2018-08-09 15:22:22','2018-08-09 15:22:22',NULL,3),(133,72,'mango',1,1,'1072',1,'2018-08-09 15:22:45','2018-08-09 15:22:45',NULL,3),(134,73,'papaya',1,1,'1073',1,'2018-08-09 15:23:00','2018-08-09 15:23:00',NULL,3),(135,74,'pera',1,1,'1074',1,'2018-08-09 15:23:17','2018-08-09 15:23:17',NULL,3),(136,75,'tuna',1,1,'1075',1,'2018-08-09 15:23:34','2018-08-09 15:23:34',NULL,3),(137,76,'pomelo',1,1,'1076',1,'2018-08-09 15:23:46','2018-08-09 15:23:46',NULL,3),(138,77,'granada',1,1,'1077',1,'2018-08-09 15:24:01','2018-08-09 15:24:01',NULL,3),(139,78,'guayaba',1,1,'1078',1,'2018-08-09 15:24:14','2018-08-09 15:24:14',NULL,3),(140,79,'lima',1,1,'1079',1,'2018-08-09 15:24:26','2018-08-09 15:24:26',NULL,3),(141,80,'ciruelo',1,1,'1080',1,'2018-08-09 15:24:40','2018-08-09 15:24:40',NULL,3),(142,81,'palta',1,1,'1081',1,'2018-08-09 15:24:54','2018-08-09 15:24:54',NULL,3),(143,82,'menbrillo',1,1,'1082',1,'2018-08-09 15:25:07','2018-08-09 15:25:07',NULL,3),(144,83,'maracuya',1,1,'1083',1,'2018-08-09 15:25:41','2018-08-09 15:25:41',NULL,3),(145,84,'mandarina',1,1,'1084',1,'2018-08-09 15:25:59','2018-08-09 15:25:59',NULL,3),(146,85,'melon',1,1,'1085',1,'2018-08-09 15:26:13','2018-08-09 15:26:13',NULL,3),(147,86,'higo',1,1,'1086',1,'2018-08-09 15:26:25','2018-08-09 15:26:25',NULL,3),(148,87,'platano',1,1,'1087',1,'2018-08-09 15:26:38','2018-08-09 15:26:38',NULL,3),(149,88,'manzana',1,1,'1088',1,'2018-08-09 15:26:58','2018-08-09 15:26:58',NULL,3),(150,89,'piÃ±a',1,1,'1089',1,'2018-08-09 15:27:12','2018-08-09 15:27:12',NULL,3),(151,90,'copoazu',1,1,'1090',1,'2018-08-09 15:27:25','2018-08-09 15:27:25',NULL,3),(152,91,'durazno (oregon)',2,1,'2091',1,'2018-08-09 15:27:39','2018-08-09 15:27:39',NULL,3),(153,92,'limon',1,1,'1092',1,'2018-08-09 15:27:52','2018-08-09 15:27:52',NULL,3),(154,93,'naranja',1,5,'1093',1,'2018-08-09 15:28:06','2018-08-09 15:28:06',NULL,3);

/*Table structure for table `producto_etiquetado` */

DROP TABLE IF EXISTS `producto_etiquetado`;

CREATE TABLE `producto_etiquetado` (
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

/*Data for the table `producto_etiquetado` */

insert  into `producto_etiquetado`(`id_etiqueta`,`cod_barras`,`preciototal`,`peso_cantidad`,`estado`,`id_prod`,`id_compra`) values (16,2020010029516,14.75,0.295,1,62,1),(17,2020010029516,14.75,0.295,1,62,1),(18,2020010029516,14.75,0.295,1,62,1),(19,2020010029516,14.75,0.295,1,62,1),(20,2020010029516,14.75,0.295,1,62,1),(21,2020010029516,14.75,0.295,1,62,2),(22,2020010029516,14.75,0.295,1,62,2),(23,2020010029516,14.75,0.295,1,62,2),(24,2020010029516,14.75,0.295,1,62,2),(25,2020010029516,14.75,0.295,1,62,2),(26,2020440015035,1.35,0.15,1,105,3),(27,2110890001037,10,10,1,150,4),(28,2020060015033,5.7,0.15,1,67,4),(29,1034,20.75,25,1,95,5),(30,2020060015033,5.7,0.15,1,67,5),(31,2020060015033,5.7,0.15,1,67,5);

/*Table structure for table `seccion` */

DROP TABLE IF EXISTS `seccion`;

CREATE TABLE `seccion` (
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

/*Data for the table `seccion` */

insert  into `seccion`(`id_seccion`,`nombre`,`limite`,`estado`,`fecha_registro`,`fecha_actualizacion`,`id_categoria`) values (1,'CARNE Y DERIVADOS',0,1,'2018-08-02 22:34:31','2018-08-02 16:34:31',NULL),(2,'VERDURAS RAICES Y TUBERCULOS',0,1,'2018-08-02 22:35:08','2018-08-02 16:35:08',NULL),(3,'FRUTAS',0,1,'2018-08-02 22:35:40','2018-08-02 16:35:40',NULL);

/*Table structure for table `usuario_login` */

DROP TABLE IF EXISTS `usuario_login`;

CREATE TABLE `usuario_login` (
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

/*Data for the table `usuario_login` */

insert  into `usuario_login`(`id_usuario`,`nombre`,`usuario`,`contrasenia`,`estado`,`tipo`,`fecha_registro`,`fecha_actualizacion`) values (1,'Haki Ari','hakiari.com','$2y$10$kFXCe9R5NugF6b4PzarJqulRGCqbIk4E22F3Ouw/RWp2YLH/g41oe',1,0,'2018-02-01 02:26:10','2018-02-07 10:11:35'),(2,'josue daniel gutierrez quispe','josuedg','$2y$10$haU7WOd1e8lFE/pG0HhJcumVGv4QcqV1Yp2CT3U9/l27LYTsoEr.u',1,1,'2018-08-11 18:48:59','2018-08-11 14:48:59'),(3,'abad alvarez claros','aalvarez','$2y$10$c2iKNzURy0P5AVfg0KWrj.7gaI/Fu.9hRZIL7zNrsSTjixmX8/dPu',1,1,'2018-08-11 22:27:43','2018-08-11 18:27:43'),(4,'delia olguin orihuela','dolguin','$2y$10$I8mvCGNI.2wjeI/hEb7rhOSCvgmFAY7bk1kouZlE4jFlEth0mjI9.',1,2,'2018-08-11 22:34:45','2018-08-11 18:34:45');

/* Procedure structure for procedure `buscar_cliente` */

/*!50003 DROP PROCEDURE IF EXISTS  `buscar_cliente` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_cliente`(in carnet varchar(20))
BEGIN
      SELECT * FROM cliente WHERE ci=carnet;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `buscar_usuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `buscar_usuario` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_usuario`(
in usu varchar(100)
)
BEGIN
SELECT id_usuario,nombre, usuario, estado, contrasenia, tipo
                            FROM usuario_login
                            WHERE usuario = usu AND estado=1;
end */$$
DELIMITER ;

/* Procedure structure for procedure `cantidad_peso` */

/*!50003 DROP PROCEDURE IF EXISTS  `cantidad_peso` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cantidad_peso`()
BEGIN
       SELECT p.id_prod,p.nro_plu
			, p.nombre as nomProducto
			, CASE p.tipo WHEN 1 THEN 'Cantidad' WHEN 2 THEN 'Peso' END AS tipo
			, p.precio, p.cod_plu, s.nombre as nomSeccion
		FROM producto p, seccion s
		WHERE p.idseccion = s.id_seccion and p.estado=1;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `detalle_venta` */

/*!50003 DROP PROCEDURE IF EXISTS  `detalle_venta` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `detalle_venta`(in id int)
BEGIN
select p.nro_plu, p.nombre, p.precio, pe.peso_cantidad, pe.preciototal  
		from producto p, producto_etiquetado pe, compra_r c 
				where p.id_prod=pe.id_prod and pe.id_compra= c.id_compra and pe.id_compra=id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `eliminarCliente` */

/*!50003 DROP PROCEDURE IF EXISTS  `eliminarCliente` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarCliente`(
in id_c int
)
BEGIN
delete from cliente where id_cliente=id_c;
END */$$
DELIMITER ;

/* Procedure structure for procedure `eliminarProducto` */

/*!50003 DROP PROCEDURE IF EXISTS  `eliminarProducto` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarProducto`(
in id_p int
)
BEGIN
UPDATE producto set estado=0 where id_prod=id_p;
end */$$
DELIMITER ;

/* Procedure structure for procedure `eliminarUsuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `eliminarUsuario` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarUsuario`(
in id_u int
)
BEGIN
delete from usuario_login where id_usuario=id_u;
END */$$
DELIMITER ;

/* Procedure structure for procedure `existe_usuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `existe_usuario` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `existe_usuario`(in usu varchar(100), out valor bool)
BEGIN
set valor =false;
if exists(select usuario from usuario_login where usuario=usu)
    
    then
        set valor= true;
    else 
        set valor = false;
    end if;
END */$$
DELIMITER ;

/* Procedure structure for procedure `genera_plu` */

/*!50003 DROP PROCEDURE IF EXISTS  `genera_plu` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `genera_plu`()
BEGIN
      SELECT IFNULL(MAX(nro_plu),0)+1  AS numero FROM producto;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `insertarcliente` */

/*!50003 DROP PROCEDURE IF EXISTS  `insertarcliente` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarcliente`(
in ci varchar(20),
in Nombre varchar(200)
)
BEGIN
insert into cliente(ci,nombre) values(ci,nombre);
END */$$
DELIMITER ;

/* Procedure structure for procedure `insertarProducto` */

/*!50003 DROP PROCEDURE IF EXISTS  `insertarProducto` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarProducto`(
IN nro_plu_p INT,
IN nombre_p VARCHAR(100),
IN tipo_p INT,
IN precio_p FLOAT,
IN cod_plu_p VARCHAR(200),
IN id_seccion BIGINT(11)
)
BEGIN
INSERT INTO producto (nro_plu,nombre,tipo,precio,cod_plu,fecha_registro,idseccion)VALUES(nro_plu_p,nombre_p,tipo_p,precio_p,cod_plu_p,NOW(),id_seccion);
END */$$
DELIMITER ;

/* Procedure structure for procedure `insertarTiene` */

/*!50003 DROP PROCEDURE IF EXISTS  `insertarTiene` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarTiene`( in idp bigint, in ids bigint)
BEGIN
    insert into tiene values(ids,idp);	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `insertarUsuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `insertarUsuario` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarUsuario`(
in Nombre varchar(200),
in fecha_registro datetime,
in Usuario varchar(100),
in contrasenia varchar(255),
in tipo int(11)
)
BEGIN
insert into usuario_login(nombre, fecha_registro, usuario, contrasenia, tipo) values(Nombre,fecha_registro,Usuario,contrasenia,tipo);
END */$$
DELIMITER ;

/* Procedure structure for procedure `listar_seccion` */

/*!50003 DROP PROCEDURE IF EXISTS  `listar_seccion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_seccion`()
BEGIN
      SELECT * FROM seccion where estado=1;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `lista_clientes` */

/*!50003 DROP PROCEDURE IF EXISTS  `lista_clientes` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_clientes`(
in cat bigint)
BEGIN
select * from cliente;
END */$$
DELIMITER ;

/* Procedure structure for procedure `lista_productos` */

/*!50003 DROP PROCEDURE IF EXISTS  `lista_productos` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_productos`()
BEGIN
select p.nro_plu, p.nombre as nombreuno ,p.tipo as tipo,p.precio,p.cod_plu, s.nombre as nombredos  from producto p, seccion s where idseccion=id_seccion order by p.nro_plu; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `modificarCliente` */

/*!50003 DROP PROCEDURE IF EXISTS  `modificarCliente` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarCliente`(
in id_c int,
in ci varchar(20),
in Nombre varchar(200)
)
BEGIN
update cliente set nombre=Nombre, ci=ci where id_cliente=id_c;
END */$$
DELIMITER ;

/* Procedure structure for procedure `modificarUsuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `modificarUsuario` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarUsuario`(
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
END */$$
DELIMITER ;

/* Procedure structure for procedure `modificar_producto` */

/*!50003 DROP PROCEDURE IF EXISTS  `modificar_producto` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_producto`(
in nombre_p varchar(100),
in precio_p float,
in tipo_p int,
in plu varchar(200),
in seccion bigint,
in id_p bigint
)
BEGIN
UPDATE producto set nombre=nombre_p, precio=precio_p, tipo=tipo_p, cod_plu=plu, idSeccion=seccion where id_prod=id_p;
end */$$
DELIMITER ;

/* Procedure structure for procedure `Numeros_a_Letras` */

/*!50003 DROP PROCEDURE IF EXISTS  `Numeros_a_Letras` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Numeros_a_Letras`(IN lnEntero TEXT)
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
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtener_id_producto` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtener_id_producto` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_id_producto`( in nro_plu_F int)
BEGIN
       select id_prod from producto where nro_plu=nro_plu_F;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `producto_categoria` */

/*!50003 DROP PROCEDURE IF EXISTS  `producto_categoria` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `producto_categoria`(
in cat bigint)
BEGIN
select * from producto where id_cat=cat;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Recibo_cliente` */

/*!50003 DROP PROCEDURE IF EXISTS  `Recibo_cliente` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Recibo_cliente`(in id_r int)
BEGIN
select r.nro_recibo, r.fecha , c.nombre , c.ci, r.total, r.total_literal, r.fecha from compra_r r, cliente c where c.id_cliente=r.id_cliente and r.id_compra=id_r;
END */$$
DELIMITER ;

/* Procedure structure for procedure `usuario_estado1` */

/*!50003 DROP PROCEDURE IF EXISTS  `usuario_estado1` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `usuario_estado1`()
BEGIN
select * from usuario_login where estado=1;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
