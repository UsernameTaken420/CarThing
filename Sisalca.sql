-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: sisalca
-- ------------------------------------------------------
-- Server version	5.7.11-enterprise-commercial-advanced-log

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
-- Table structure for table `apartamento`
--

DROP TABLE IF EXISTS `apartamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apartamento` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `Piso` int(2) NOT NULL,
  `DispEspacio` enum('Si','No') DEFAULT NULL,
  `Seguridad` enum('Si','No') DEFAULT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `apartamento_ibfk_1` FOREIGN KEY (`ID`) REFERENCES `propiedad` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apartamento`
--

LOCK TABLES `apartamento` WRITE;
/*!40000 ALTER TABLE `apartamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `apartamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `casa`
--

DROP TABLE IF EXISTS `casa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `casa` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `MatPiso` varchar(15) NOT NULL,
  `MatTecho` varchar(15) NOT NULL,
  `Parrillero` int(2) NOT NULL,
  `Barbacoa` int(2) NOT NULL,
  `Tipo` enum('Una planta','Dos plantas','Más de dos plantas') DEFAULT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `casa_ibfk_1` FOREIGN KEY (`ID`) REFERENCES `propiedad` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `casa`
--

LOCK TABLES `casa` WRITE;
/*!40000 ALTER TABLE `casa` DISABLE KEYS */;
/*!40000 ALTER TABLE `casa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `propiedad`
--

DROP TABLE IF EXISTS `propiedad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `propiedad` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `Superficie` int(10) NOT NULL,
  `CantidadBaños` int(2) NOT NULL,
  `Cocina` enum('Si','No') NOT NULL,
  `CantidadDorm` int(2) NOT NULL,
  `Cochera` enum('Si','No') NOT NULL,
  `OtrasHab` int(3) NOT NULL,
  `Ubicacion` varchar(100) NOT NULL,
  `PrecioAlq` int(10) NOT NULL,
  `PrecioVenta` int(10) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `propiedad`
--

LOCK TABLES `propiedad` WRITE;
/*!40000 ALTER TABLE `propiedad` DISABLE KEYS */;
/*!40000 ALTER TABLE `propiedad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehiculo`
--

DROP TABLE IF EXISTS `vehiculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehiculo` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `Marcha` varchar(15) NOT NULL,
  `Kilometraje` int(15) NOT NULL,
  `Modelo` varchar(10) NOT NULL,
  `Año` year(4) NOT NULL,
  `CantidadPuertas` int(2) NOT NULL,
  `Baul` enum('Si','No') NOT NULL,
  `Capacidad` int(10) NOT NULL,
  `Cilindros` int(2) NOT NULL,
  `Color` varchar(15) NOT NULL,
  `AireAcond` enum('Si','No') NOT NULL,
  `DirecHidr` enum('Si','No') NOT NULL,
  `Precio` int(10) NOT NULL,
  `Estado` enum('Vendido','Disponible','No Disponible','Taller') DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehiculo`
--

LOCK TABLES `vehiculo` WRITE;
/*!40000 ALTER TABLE `vehiculo` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehiculo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-29 15:07:50
