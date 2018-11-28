/*
SQLyog Community Edition- MySQL GUI v8.05 
MySQL - 5.5.5-10.1.34-MariaDB : Database - marketbbdd
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`marketbbdd` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `marketbbdd`;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

/*Data for the table `cliente` */

insert  into `cliente`(`id_cliente`,`ci`,`nombre`,`estado`,`fecha_registro`) values (2,'4038952','peppito',1,'2018-08-11 21:00:42'),(3,'1234567','juan',1,'2018-08-11 21:27:02'),(4,'123456','pepito',1,'2018-08-11 22:38:44'),(5,'4554545','MARCO vidal',1,'2018-11-22 16:35:06');

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

insert  into `compra_r`(`id_compra`,`nro_recibo`,`total`,`total_literal`,`fecha`,`id_cliente`,`id_usuario`,`estado`) values (1,'1',73.75,'SETENTA Y TRES con 75/100 Bs.','2018-08-11 21:00:53',2,2,NULL),(2,'2',73.75,'SETENTA Y TRES con 75/100 Bs.','2018-08-11 21:04:00',2,2,NULL),(3,'3',1.35,'UNO con 35/100 Bs.','2018-08-11 22:03:14',3,2,NULL),(4,'4',15.7,'QUINCE con 70 100 Bs.','2018-08-11 22:20:54',3,2,NULL),(5,'5',32.15,'TREINTA Y DOS con 15/100 Bs.','2018-08-11 22:40:18',4,3,NULL),(6,'6',180,'CIENTO OCHENTA con 00/100 Bs.','2018-10-25 16:24:29',4,5,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

/*Data for the table `producto` */

insert  into `producto`(`id_prod`,`nro_plu`,`nombre`,`tipo`,`precio`,`cod_plu`,`estado`,`fecha_registro`,`fecha_actualizacion`,`id_limite`,`idseccion`) values (1,1,'filete',2,50,'2001',1,'2018-11-28 11:49:31','2018-11-28 11:49:31',NULL,1),(2,2,'pulpa',2,48,'2002',1,'2018-11-28 11:51:39','2018-11-28 11:51:39',NULL,1),(3,3,'cabeza de lomo',2,45,'2003',1,'2018-11-28 18:42:13','2018-11-28 18:42:13',NULL,1),(4,4,'peceto',2,42,'2004',1,'2018-11-28 18:43:06','2018-11-28 18:43:06',NULL,1),(5,5,'punta de s',2,45,'2005',1,'2018-11-28 18:43:31','2018-11-28 18:43:31',NULL,1),(6,6,'molida',2,38,'2006',1,'2018-11-28 18:44:39','2018-11-28 18:44:39',NULL,1),(7,7,'albondiga',2,26,'2007',1,'2018-11-28 18:45:05','2018-11-28 18:45:05',NULL,1),(8,8,'milaneza de carne',1,28,'1008',1,'2018-11-28 18:45:51','2018-11-28 18:45:51',NULL,1),(9,9,'lapimg',2,36,'2009',1,'2018-11-28 18:46:16','2018-11-28 18:46:16',NULL,1),(10,10,'chuleta',2,43,'2010',1,'2018-11-28 18:47:11','2018-11-28 18:47:11',NULL,1),(11,11,'witu',2,36,'2011',1,'2018-11-28 19:06:40','2018-11-28 19:06:40',NULL,1),(12,12,'churrasco',2,36,'2012',1,'2018-11-28 19:07:10','2018-11-28 19:07:10',NULL,1),(13,13,'cadera',2,36,'2013',1,'2018-11-28 19:07:38','2018-11-28 19:07:38',NULL,1),(14,14,'paleta',2,36,'2014',1,'2018-11-28 19:08:16','2018-11-28 19:08:16',NULL,1),(15,15,'pecho',2,30,'2015',1,'2018-11-28 19:08:45','2018-11-28 19:08:45',NULL,1),(16,16,'jiba',2,30,'2016',1,'2018-11-28 19:09:19','2018-11-28 19:09:19',NULL,1),(17,17,'aujilla',2,34,'2017',1,'2018-11-28 19:09:54','2018-11-28 19:09:54',NULL,1),(18,18,'tira/costilla',2,34,'2018',1,'2018-11-28 19:10:22','2018-11-28 19:10:22',NULL,1),(19,19,'ozubuco',2,28,'2019',1,'2018-11-28 19:10:44','2018-11-28 19:10:44',NULL,1),(20,20,'canastitas',2,18,'2020',1,'2018-11-28 19:11:26','2018-11-28 19:11:26',NULL,1),(21,21,'chorizo',2,36,'2021',1,'2018-11-28 19:12:09','2018-11-28 19:12:09',NULL,1),(22,22,'corazon',2,30,'2022',1,'2018-11-28 19:12:56','2018-11-28 19:12:56',NULL,1),(23,23,'higado',2,22,'2023',1,'2018-11-28 19:14:12','2018-11-28 19:14:12',NULL,1),(24,24,'panza cocida',2,32,'2024',1,'2018-11-28 19:14:43','2018-11-28 19:14:43',NULL,1),(25,25,'hamburguesa de res',2,29,'2025',1,'2018-11-28 19:15:47','2018-11-28 19:15:47',NULL,1),(26,26,'silpancho de res',1,34,'1026',1,'2018-11-28 19:16:18','2018-11-28 19:16:18',NULL,1),(27,27,'huevo25',1,0.85,'1027',1,'2018-11-28 19:17:47','2018-11-28 19:17:47',NULL,1),(28,28,'huevo22',1,0.75,'1028',1,'2018-11-28 19:18:13','2018-11-28 19:18:13',NULL,1),(29,29,'pollo',2,16.5,'2029',1,'2018-11-28 19:36:09','2018-11-28 19:36:09',NULL,2),(30,30,'pierna de pollo',2,15,'2030',1,'2018-11-28 19:36:42','2018-11-28 19:36:42',NULL,2),(31,31,'alas de pollo',2,15,'2031',1,'2018-11-28 19:37:48','2018-11-28 19:37:48',NULL,2),(32,32,'pecho de pollo',2,15,'2032',1,'2018-11-28 19:38:22','2018-11-28 19:38:22',NULL,2),(33,33,'pescado trucha',2,45,'2033',1,'2018-11-28 19:39:05','2018-11-28 19:39:05',NULL,2),(34,34,'pescado pacu',2,50,'2034',1,'2018-11-28 19:39:35','2018-11-28 19:39:35',NULL,2),(35,35,'pescado surubi',2,50,'2035',1,'2018-11-28 19:40:00','2018-11-28 19:40:00',NULL,2),(36,36,'zanahoria',2,5,'2036',1,'2018-11-28 19:42:30','2018-11-28 19:42:30',NULL,3),(37,37,'haba',2,6,'2037',1,'2018-11-28 19:43:16','2018-11-28 19:43:16',NULL,3),(38,38,'zapallo',2,5.7,'2038',1,'2018-11-28 19:43:48','2018-11-28 19:43:48',NULL,3),(39,39,'cebolla con cola',2,4.5,'2039',1,'2018-11-28 19:45:05','2018-11-28 19:45:05',NULL,3),(40,40,'cebolla/cabeza',2,4.2,'2040',1,'2018-11-28 19:45:28','2018-11-28 19:45:28',NULL,3),(41,41,'tomate',2,8.3,'2041',1,'2018-11-28 19:46:05','2018-11-28 19:46:05',NULL,3),(42,42,'achojcha',2,12,'2042',1,'2018-11-28 19:47:52','2018-11-28 19:47:52',NULL,3),(43,43,'remolacha',2,3,'2043',1,'2018-11-28 19:48:30','2018-11-28 19:48:30',NULL,3),(44,44,'vainita',2,7,'2044',1,'2018-11-28 19:49:01','2018-11-28 19:49:01',NULL,3),(45,45,'arveja',2,8,'2045',1,'2018-11-28 19:57:28','2018-11-28 19:57:28',NULL,3),(46,46,'perejil',2,12,'2046',1,'2018-11-28 19:57:54','2018-11-28 19:57:54',NULL,3),(47,47,'espinaca',2,6,'2047',1,'2018-11-28 19:58:26','2018-11-28 19:58:26',NULL,3),(48,48,'brocoli',1,5,'1048',1,'2018-11-28 19:58:58','2018-11-28 19:58:58',NULL,3),(49,49,'apio',2,9,'2049',1,'2018-11-28 19:59:25','2018-11-28 19:59:25',NULL,3),(50,50,'acelga',2,8,'2050',1,'2018-11-28 19:59:55','2018-11-28 19:59:55',NULL,3),(51,51,'repollo',1,5,'1051',1,'2018-11-28 20:00:23','2018-11-28 20:00:23',NULL,3),(52,52,'coliflor',2,3,'2052',1,'2018-11-28 20:01:22','2018-11-28 20:01:22',NULL,3),(53,53,'berro',2,5,'2053',1,'2018-11-28 20:01:53','2018-11-28 20:01:53',NULL,3),(54,54,'pepino',1,5,'1054',1,'2018-11-28 20:02:25','2018-11-28 20:02:25',NULL,3),(55,55,'berenjena',2,5,'2055',1,'2018-11-28 20:02:48','2018-11-28 20:02:48',NULL,3),(56,56,'pimenton',2,7,'2056',1,'2018-11-28 20:03:14','2018-11-28 20:03:14',NULL,3),(57,57,'platano de freir',1,1,'1057',1,'2018-11-28 20:03:49','2018-11-28 20:03:49',NULL,3),(58,58,'yuca',2,4.3,'2058',1,'2018-11-28 20:07:28','2018-11-28 20:07:28',NULL,4),(59,59,'camote',2,6.5,'2059',1,'2018-11-28 20:07:53','2018-11-28 20:07:53',NULL,4),(60,60,'papa grande',2,3.8,'2060',1,'2018-11-28 20:08:33','2018-11-28 20:08:33',NULL,4),(61,61,'papa pequeÃ±a',2,5,'2061',1,'2018-11-28 20:11:03','2018-11-28 20:11:03',NULL,4),(62,62,'papa holandesa',2,6,'2062',1,'2018-11-28 20:12:03','2018-11-28 20:12:03',NULL,4),(63,63,'papa liza',2,4,'2063',1,'2018-11-28 20:12:25','2018-11-28 20:12:25',NULL,4),(64,64,'papa morada',2,4.5,'2064',1,'2018-11-28 20:12:53','2018-11-28 20:12:53',NULL,4),(65,65,'durazno',2,9,'2065',1,'2018-11-28 20:15:24','2018-11-28 20:15:24',NULL,5),(66,66,'uva',2,25,'2066',1,'2018-11-28 20:16:06','2018-11-28 20:16:06',NULL,5),(67,67,'frutilla',2,1,'2067',1,'2018-11-28 20:16:41','2018-11-28 20:16:41',NULL,5),(68,68,'achachairu',2,1,'2068',1,'2018-11-28 20:17:22','2018-11-28 20:17:22',NULL,5),(69,69,'asai',2,1,'2069',1,'2018-11-28 20:17:45','2018-11-28 20:17:45',NULL,5),(70,70,'sandia',1,10,'1070',1,'2018-11-28 20:19:01','2018-11-28 20:19:01',NULL,5),(71,71,'chirimoya',1,1,'1071',1,'2018-11-28 20:19:24','2018-11-28 20:19:24',NULL,5),(72,72,'mango',1,1.5,'1072',1,'2018-11-28 20:19:55','2018-11-28 20:19:55',NULL,5),(73,73,'papaya',1,10,'1073',1,'2018-11-28 20:20:25','2018-11-28 20:20:25',NULL,5),(74,74,'pera',1,1,'1074',1,'2018-11-28 20:20:52','2018-11-28 20:20:52',NULL,5),(75,75,'tuna',1,1,'1075',1,'2018-11-28 20:21:22','2018-11-28 20:21:22',NULL,5),(76,76,'pomelo',1,1,'1076',1,'2018-11-28 20:21:41','2018-11-28 20:21:41',NULL,5),(77,77,'granada',1,1,'1077',1,'2018-11-28 20:22:02','2018-11-28 20:22:02',NULL,5),(78,78,'guayaba',1,1,'1078',1,'2018-11-28 20:22:28','2018-11-28 20:22:28',NULL,5),(79,79,'lima',1,1,'1079',1,'2018-11-28 20:22:49','2018-11-28 20:22:49',NULL,5),(80,80,'ciruelo',1,1,'1080',1,'2018-11-28 20:23:04','2018-11-28 20:23:04',NULL,5),(81,81,'palta',1,3.5,'1081',1,'2018-11-28 20:23:28','2018-11-28 20:23:28',NULL,5),(82,82,'menbrillo',1,1,'1082',1,'2018-11-28 20:23:52','2018-11-28 20:23:52',NULL,5),(83,83,'maracuya',1,1,'1083',1,'2018-11-28 20:24:10','2018-11-28 20:24:10',NULL,5),(84,84,'mandarina',1,1,'1084',1,'2018-11-28 20:24:32','2018-11-28 20:24:32',NULL,5),(85,85,'melon',1,1,'1085',1,'2018-11-28 20:25:03','2018-11-28 20:25:03',NULL,5),(86,86,'higo',1,1,'1086',1,'2018-11-28 20:25:24','2018-11-28 20:25:24',NULL,5),(87,87,'platano',1,0.6,'1087',1,'2018-11-28 20:25:40','2018-11-28 20:25:40',NULL,5),(88,88,'manzana',1,1.5,'1088',1,'2018-11-28 20:26:23','2018-11-28 20:26:23',NULL,5),(89,89,'piÃ±a',1,7,'1089',1,'2018-11-28 20:26:53','2018-11-28 20:26:53',NULL,5),(90,90,'copoazu',1,1,'1090',1,'2018-11-28 20:27:17','2018-11-28 20:27:17',NULL,5),(91,91,'durazno (oregon)',2,1,'2091',1,'2018-11-28 20:27:55','2018-11-28 20:27:55',NULL,5),(92,92,'limon',1,0.6,'1092',1,'2018-11-28 20:28:19','2018-11-28 20:28:19',NULL,5),(93,93,'naranja',1,0.6,'1093',1,'2018-11-28 20:28:47','2018-11-28 20:28:47',NULL,5),(94,94,'mango pequeÃ±o',1,0.6,'1094',1,'2018-11-28 20:29:22','2018-11-28 20:29:22',NULL,5);

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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

/*Data for the table `producto_etiquetado` */

/*Table structure for table `seccion` */

DROP TABLE IF EXISTS `seccion`;

CREATE TABLE `seccion` (
  `id_seccion` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) COLLATE utf8_spanish2_ci NOT NULL,
  `valor_ticket` varchar(50) COLLATE utf8_spanish2_ci NOT NULL DEFAULT '0',
  `fecha_registro` datetime NOT NULL,
  `fecha_actualizacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_seccion`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

/*Data for the table `seccion` */

insert  into `seccion`(`id_seccion`,`nombre`,`valor_ticket`,`fecha_registro`,`fecha_actualizacion`,`estado`) values (1,'CARNE Y/O DERIVADOS','100 100 80','2018-11-28 16:41:41','2018-11-28 11:41:41',1),(2,'POLLO Y/O PESCADO','50 50 49.20','2018-11-28 16:42:56','2018-11-28 11:42:56',1),(3,'VERDURAS','80 0 0','2018-11-28 16:44:24','2018-11-28 11:44:24',1),(4,'TUBERCULOS','60 0 0','2018-11-28 16:44:56','2018-11-28 11:44:56',1),(5,'FRUTAS','45 0 0','2018-11-28 16:45:48','2018-11-28 11:45:48',1);

/*Table structure for table `ticket` */

DROP TABLE IF EXISTS `ticket`;

CREATE TABLE `ticket` (
  `id_ticket` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL DEFAULT '0',
  `id_venta` int(11) NOT NULL DEFAULT '0',
  `total_ticket` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_ticket`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ticket` */

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

/*Data for the table `usuario_login` */

insert  into `usuario_login`(`id_usuario`,`nombre`,`usuario`,`contrasenia`,`estado`,`tipo`,`fecha_registro`,`fecha_actualizacion`) values (1,'Haki Ari','hakiari.com','$2y$10$kFXCe9R5NugF6b4PzarJqulRGCqbIk4E22F3Ouw/RWp2YLH/g41oe',1,0,'2018-02-01 02:26:10','2018-02-07 10:11:35'),(2,'josue daniel gutierrez quispe','josuedg','$2y$10$haU7WOd1e8lFE/pG0HhJcumVGv4QcqV1Yp2CT3U9/l27LYTsoEr.u',1,1,'2018-08-11 18:48:59','2018-08-11 14:48:59'),(3,'abad alvarez claros','aalvarez','$2y$10$c2iKNzURy0P5AVfg0KWrj.7gaI/Fu.9hRZIL7zNrsSTjixmX8/dPu',1,1,'2018-08-11 22:27:43','2018-08-11 18:27:43'),(4,'delia olguin orihuela','dolguin','$2y$10$I8mvCGNI.2wjeI/hEb7rhOSCvgmFAY7bk1kouZlE4jFlEth0mjI9.',1,2,'2018-08-11 22:34:45','2018-08-11 18:34:45'),(5,'Luis Miguel Mendoza Ticona','lmendoza','$2y$10$cX8BWe4o.TWTu2uoHt.16exSpaDaUfIckgVVVe5KlPhcqb/pieZGK',1,1,'2018-10-06 19:23:09','2018-10-06 13:23:09');

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

/* Procedure structure for procedure `detalleVentasPorRangoFechas` */

/*!50003 DROP PROCEDURE IF EXISTS  `detalleVentasPorRangoFechas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `detalleVentasPorRangoFechas`(
  IN `fecha_a` DATE,
  IN `fecha_b` DATE
)
BEGIN
select p.nro_plu, p.nombre, p.precio, pe.peso_cantidad, pe.preciototal,date(c.fecha) as fecha 
    from producto p, producto_etiquetado pe, compra_r c 
        where p.id_prod=pe.id_prod and pe.id_compra= c.id_compra and date(c.fecha) BETWEEN fecha_a and fecha_b;
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

/* Procedure structure for procedure `reporte_dia` */

/*!50003 DROP PROCEDURE IF EXISTS  `reporte_dia` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `reporte_dia`()
    COMMENT 'crea el reporte de ventas por dia por caja o usuario que atendia'
BEGIN
select r.nro_recibo, r.fecha , c.nombre , c.ci, r.total,p.nombre, p.precio, pe.peso_cantidad, pe.preciototal
  from cliente c,producto p, producto_etiquetado pe, compra_r r 
    where c.id_cliente=r.id_cliente 
      and c.ci='6846341' and r.fecha='2018-03-05 15:25:14'  
            and p.id_prod=pe.id_prod ;
END */$$
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
