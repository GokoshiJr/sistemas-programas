-- MySQL dump 10.13  Distrib 5.6.23, for Win32 (x86)
--
-- Host: localhost    Database: db_sistema
-- ------------------------------------------------------
-- Server version	5.7.18-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `almacenes`
--

DROP TABLE IF EXISTS `almacenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `almacenes` (
  `almacen_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sector` varchar(10) NOT NULL,
  PRIMARY KEY (`almacen_id`),
  UNIQUE KEY `sector` (`sector`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `almacenes`
--

LOCK TABLES `almacenes` WRITE;
/*!40000 ALTER TABLE `almacenes` DISABLE KEYS */;
INSERT INTO `almacenes` VALUES (1,'Norte'),(3,'Norte/Sur'),(2,'Sur');
/*!40000 ALTER TABLE `almacenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cargos`
--

DROP TABLE IF EXISTS `cargos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cargos` (
  `cargo_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) NOT NULL,
  PRIMARY KEY (`cargo_id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargos`
--

LOCK TABLES `cargos` WRITE;
/*!40000 ALTER TABLE `cargos` DISABLE KEYS */;
INSERT INTO `cargos` VALUES (1,'Administrador'),(3,'Almacenista'),(2,'Supervisor');
/*!40000 ALTER TABLE `cargos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleados` (
  `empleado_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `cedula` int(10) unsigned NOT NULL,
  `telefono` int(10) unsigned NOT NULL,
  `cargo_id` int(10) unsigned NOT NULL,
  `almacen_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`empleado_id`),
  UNIQUE KEY `cedula` (`cedula`),
  UNIQUE KEY `telefono` (`telefono`),
  KEY `empleados_cargos_fk` (`cargo_id`),
  KEY `empleados_almacenes_fk` (`almacen_id`),
  CONSTRAINT `empleados_almacenes_fk` FOREIGN KEY (`almacen_id`) REFERENCES `almacenes` (`almacen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `empleados_cargos_fk` FOREIGN KEY (`cargo_id`) REFERENCES `cargos` (`cargo_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (1,'Julio','Gonzalez','2000-12-12',28195303,4247300796,1,3),(2,'Marcel','Gonzalez','2000-09-22',27925394,4244718714,2,1),(3,'Diego','Lozada','2001-10-20',27123394,4244000714,3,1);
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estatusinstrucciones`
--

DROP TABLE IF EXISTS `estatusinstrucciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estatusinstrucciones` (
  `estatusinstruccion_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) NOT NULL,
  PRIMARY KEY (`estatusinstruccion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estatusinstrucciones`
--

LOCK TABLES `estatusinstrucciones` WRITE;
/*!40000 ALTER TABLE `estatusinstrucciones` DISABLE KEYS */;
INSERT INTO `estatusinstrucciones` VALUES (1,'Autorizada'),(2,'No Autorizada'),(5,'Revision'),(6,'Ejecutada');
/*!40000 ALTER TABLE `estatusinstrucciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instrucciones`
--

DROP TABLE IF EXISTS `instrucciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instrucciones` (
  `instruccion_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tipoinstruccion_id` int(10) unsigned NOT NULL,
  `producto_id` int(10) unsigned NOT NULL,
  `cantidad_producto` int(10) unsigned NOT NULL,
  `especificacion` varchar(200) NOT NULL,
  `almacen_id` int(10) unsigned NOT NULL,
  `estatusinstruccion_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`instruccion_id`),
  KEY `instrucciones_tipoinstrucciones_fk` (`tipoinstruccion_id`),
  KEY `instrucciones_almacenes_fk` (`almacen_id`),
  KEY `instrucciones_producto_fk` (`producto_id`),
  KEY `instrucciones_estatusinstrucciones_fk` (`estatusinstruccion_id`),
  CONSTRAINT `instrucciones_almacenes_fk` FOREIGN KEY (`almacen_id`) REFERENCES `almacenes` (`almacen_id`),
  CONSTRAINT `instrucciones_estatusinstrucciones_fk` FOREIGN KEY (`estatusinstruccion_id`) REFERENCES `estatusinstrucciones` (`estatusinstruccion_id`),
  CONSTRAINT `instrucciones_producto_fk` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`producto_id`),
  CONSTRAINT `instrucciones_tipoinstrucciones_fk` FOREIGN KEY (`tipoinstruccion_id`) REFERENCES `tipoinstrucciones` (`tipoinstruccion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instrucciones`
--

LOCK TABLES `instrucciones` WRITE;
/*!40000 ALTER TABLE `instrucciones` DISABLE KEYS */;
INSERT INTO `instrucciones` VALUES (1,1,5,5,'Ingresaron 5 kilos de albahaca del mercado municipal',1,6),(2,2,20,4,'Ajuste de cafe para el pana Marcel que quiere tomarlo en las mañanas',2,2),(3,1,18,10,'Ingreso de lotes de salchicha\r\n',1,6),(4,2,17,13,'salida a la planta de papas',1,1),(5,1,19,2,'donación de auyumas',1,6);
/*!40000 ALTER TABLE `instrucciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productos` (
  `producto_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `codigo` int(10) unsigned NOT NULL,
  `cantidad` int(10) unsigned NOT NULL,
  `tipoproducto_id` int(10) unsigned NOT NULL,
  `almacen_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`producto_id`),
  KEY `productos_tipoproductos_fk` (`tipoproducto_id`),
  KEY `productos_almacenes_fk` (`almacen_id`),
  CONSTRAINT `productos_almacenes_fk` FOREIGN KEY (`almacen_id`) REFERENCES `almacenes` (`almacen_id`),
  CONSTRAINT `productos_tipoproductos_fk` FOREIGN KEY (`tipoproducto_id`) REFERENCES `tipoproductos` (`tipoproducto_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'SEMOLA 45KG',1111,3,1,1),(2,'HARINA DE TRIGO 45KG',1112,3,1,1),(3,'SAL REFINADA 21KG',1211,2,2,1),(4,'CARTON DE HUEVOS',1311,5,3,1),(5,'ALBAHACA 1KG',1411,8,4,1),(6,'QUESO PARMESANO 1KG',1511,3,5,1),(7,'PIÑONES 1KG',1611,3,6,1),(8,'QUESO RICOTA 1KG',1512,2,5,1),(9,'ESPINACA 1KG',1412,3,4,1),(10,'QUESO MASCARPONE 1KG',1513,2,5,1),(11,'CACAO EN POLVO 5KG',1711,2,7,1),(12,'AZUCAR GLASS 11KG',1712,1,7,1),(13,'BIZCOCHO DE SOLETILLA 1KG',1811,3,8,1),(14,'CAFÉ MOLIDO 1KG',1713,3,7,1),(15,'OSOBUCO 1KG',1312,5,3,1),(16,'CARNE DE RES 1KG',1313,11,3,1),(17,'PAPA 1KG',1911,5,9,1),(18,'SALCHICHA 1KG',1314,15,3,1),(19,'AUYAMA 1KG',1912,4,9,1),(20,'TORTELLONES RICOTA ESPINACA',1001,10,10,2),(21,'RAVIOLIS OSOBUCO',1101,13,11,2),(22,'RAVIOLIS MILANESA',1102,13,11,2),(23,'RAVIOLIS SALCHICHA Y PAPA',1103,11,11,2),(24,'TORTELLONES QUESO CREMA AUYAMA',1002,8,10,2),(25,'TORTELLONES CARNE',1003,9,10,2),(26,'SALSA PESTO',1201,15,12,2),(27,'SALSA AMATRICIANA',1202,15,12,2),(28,'GNOCCHIS PAPA',1301,5,13,2),(29,'GNOCCHIS AUYAMA',1302,5,13,2),(30,'TIRAMISU',1401,3,14,2),(31,'SPAGHETTI',1501,20,15,2);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registros`
--

DROP TABLE IF EXISTS `registros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registros` (
  `registro_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` int(10) unsigned NOT NULL,
  `producto_id` int(10) unsigned NOT NULL,
  `instruccion_id` int(10) unsigned NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cantidad_producto` int(10) unsigned NOT NULL,
  PRIMARY KEY (`registro_id`),
  KEY `registros_productos_fk` (`producto_id`),
  KEY `registros_instrucciones_fk` (`instruccion_id`),
  CONSTRAINT `registros_instrucciones_fk` FOREIGN KEY (`instruccion_id`) REFERENCES `tipoinstrucciones` (`tipoinstruccion_id`),
  CONSTRAINT `registros_productos_fk` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`producto_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registros`
--

LOCK TABLES `registros` WRITE;
/*!40000 ALTER TABLE `registros` DISABLE KEYS */;
/*!40000 ALTER TABLE `registros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoinstrucciones`
--

DROP TABLE IF EXISTS `tipoinstrucciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipoinstrucciones` (
  `tipoinstruccion_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`tipoinstruccion_id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoinstrucciones`
--

LOCK TABLES `tipoinstrucciones` WRITE;
/*!40000 ALTER TABLE `tipoinstrucciones` DISABLE KEYS */;
INSERT INTO `tipoinstrucciones` VALUES (1,'Entrada'),(2,'Salida');
/*!40000 ALTER TABLE `tipoinstrucciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoproductos`
--

DROP TABLE IF EXISTS `tipoproductos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipoproductos` (
  `tipoproducto_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`tipoproducto_id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoproductos`
--

LOCK TABLES `tipoproductos` WRITE;
/*!40000 ALTER TABLE `tipoproductos` DISABLE KEYS */;
INSERT INTO `tipoproductos` VALUES (3,'ANIMAL'),(8,'BIZCOCHOS'),(4,'ESPECIAS'),(6,'FRUTOS SECOS'),(13,'GNOCCHIS'),(1,'HARINA'),(2,'MINERALES'),(15,'PASTA'),(7,'POLVOS'),(14,'POSTRE'),(5,'QUESOS'),(11,'RAVIOLIS'),(12,'SALSA'),(10,'TORTELLONES'),(9,'VEGETALES');
/*!40000 ALTER TABLE `tipoproductos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `usuario_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `empleado_id` int(10) unsigned NOT NULL,
  `correo` varchar(100) NOT NULL,
  `clave` varchar(100) NOT NULL,
  `ultima_conexion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`usuario_id`),
  UNIQUE KEY `correo` (`correo`),
  KEY `usuarios_empleados_fk` (`empleado_id`),
  CONSTRAINT `usuarios_empleados_fk` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`empleado_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,1,'julioagonzalez18@gmail.com','123','2021-04-18 04:26:01'),(2,2,'marcel202101@gmail.com','ABC','2021-04-18 04:24:54'),(3,3,'diegolo@gmail.com','QWE','2021-04-18 04:29:24');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-18  0:40:45
