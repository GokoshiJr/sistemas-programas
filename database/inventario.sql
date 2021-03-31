-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:4000
-- Generation Time: Mar 31, 2021 at 05:39 PM
-- Server version: 5.7.24
-- PHP Version: 7.2.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventario`
--

-- --------------------------------------------------------

--
-- Table structure for table `administradores`
--

CREATE TABLE `administradores` (
  `administrador_id` int(10) UNSIGNED NOT NULL,
  `empleado_id` int(10) UNSIGNED NOT NULL,
  `estatus_id` int(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `almacenistas`
--

CREATE TABLE `almacenistas` (
  `almacenista_id` int(10) UNSIGNED NOT NULL,
  `empleado_id` int(10) UNSIGNED NOT NULL,
  `estatus_id` int(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `empleados`
--

CREATE TABLE `empleados` (
  `empleado_id` int(10) UNSIGNED NOT NULL,
  `estatus_id` int(1) UNSIGNED NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `cedula` int(10) UNSIGNED NOT NULL,
  `telefono` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `estatus`
--

CREATE TABLE `estatus` (
  `estatus_id` int(1) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `estatus`
--

INSERT INTO `estatus` (`estatus_id`, `nombre`) VALUES
(1, 'Activo'),
(2, 'Inactivo');

-- --------------------------------------------------------

--
-- Table structure for table `instrucciones`
--

CREATE TABLE `instrucciones` (
  `instruccion_id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `estatus_id` int(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `productos`
--

CREATE TABLE `productos` (
  `producto_id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `codigo` int(10) UNSIGNED NOT NULL,
  `cantidad` int(10) UNSIGNED NOT NULL,
  `tipoproducto_id` int(10) UNSIGNED NOT NULL,
  `estatus_id` int(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `registros`
--

CREATE TABLE `registros` (
  `registro_id` int(10) UNSIGNED NOT NULL,
  `codigo` int(10) UNSIGNED NOT NULL,
  `producto_id` int(10) UNSIGNED NOT NULL,
  `instruccion_id` int(10) UNSIGNED NOT NULL,
  `fecha` date NOT NULL,
  `cantidad_producto` int(10) UNSIGNED NOT NULL,
  `estatus_id` int(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `supervisores`
--

CREATE TABLE `supervisores` (
  `supervisor_id` int(10) UNSIGNED NOT NULL,
  `empleado_id` int(10) UNSIGNED NOT NULL,
  `estatus_id` int(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tipoproductos`
--

CREATE TABLE `tipoproductos` (
  `tipoproducto_id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `estatus_id` int(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `usuario_id` int(10) UNSIGNED NOT NULL,
  `empleado_id` int(10) UNSIGNED NOT NULL,
  `correo` varchar(100) NOT NULL,
  `clave` varchar(100) NOT NULL,
  `fecha_registro` timestamp NOT NULL,
  `ultima_conexion` timestamp NOT NULL,
  `estatus_id` int(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administradores`
--
ALTER TABLE `administradores`
  ADD PRIMARY KEY (`administrador_id`),
  ADD KEY `administradores_empleados_fk` (`empleado_id`),
  ADD KEY `estatus_administradores_fk` (`estatus_id`);

--
-- Indexes for table `almacenistas`
--
ALTER TABLE `almacenistas`
  ADD PRIMARY KEY (`almacenista_id`),
  ADD KEY `almacenistas_empleados_fk` (`empleado_id`),
  ADD KEY `almacenistas_estatus_pk` (`estatus_id`);

--
-- Indexes for table `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`empleado_id`),
  ADD UNIQUE KEY `cedula` (`cedula`),
  ADD UNIQUE KEY `telefono` (`telefono`),
  ADD KEY `empleados_estatus_fk` (`estatus_id`);

--
-- Indexes for table `estatus`
--
ALTER TABLE `estatus`
  ADD PRIMARY KEY (`estatus_id`);

--
-- Indexes for table `instrucciones`
--
ALTER TABLE `instrucciones`
  ADD PRIMARY KEY (`instruccion_id`),
  ADD KEY `instrucciones_estatus_fk` (`estatus_id`);

--
-- Indexes for table `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`producto_id`),
  ADD KEY `productos_tipoproductos_fk` (`tipoproducto_id`),
  ADD KEY `productos_estatus_fk` (`estatus_id`);

--
-- Indexes for table `registros`
--
ALTER TABLE `registros`
  ADD PRIMARY KEY (`registro_id`),
  ADD KEY `registros_productos_fk` (`producto_id`),
  ADD KEY `registros_instrucciones_fk` (`instruccion_id`),
  ADD KEY `registros_estatus_fk` (`estatus_id`);

--
-- Indexes for table `supervisores`
--
ALTER TABLE `supervisores`
  ADD PRIMARY KEY (`supervisor_id`),
  ADD KEY `supervisores_empleados_fk` (`empleado_id`),
  ADD KEY `supervisores_estatus_fk` (`estatus_id`);

--
-- Indexes for table `tipoproductos`
--
ALTER TABLE `tipoproductos`
  ADD PRIMARY KEY (`tipoproducto_id`),
  ADD KEY `tipoproductos_estatus_fk` (`estatus_id`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usuario_id`),
  ADD KEY `usuarios_empleados_fk` (`empleado_id`),
  ADD KEY `usuarios_estatus_fk` (`estatus_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `administradores`
--
ALTER TABLE `administradores`
  MODIFY `administrador_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `almacenistas`
--
ALTER TABLE `almacenistas`
  MODIFY `almacenista_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `empleados`
--
ALTER TABLE `empleados`
  MODIFY `empleado_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `estatus`
--
ALTER TABLE `estatus`
  MODIFY `estatus_id` int(1) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `instrucciones`
--
ALTER TABLE `instrucciones`
  MODIFY `instruccion_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `productos`
--
ALTER TABLE `productos`
  MODIFY `producto_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `registros`
--
ALTER TABLE `registros`
  MODIFY `registro_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supervisores`
--
ALTER TABLE `supervisores`
  MODIFY `supervisor_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tipoproductos`
--
ALTER TABLE `tipoproductos`
  MODIFY `tipoproducto_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usuario_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `administradores`
--
ALTER TABLE `administradores`
  ADD CONSTRAINT `administradores_empleados_fk` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`empleado_id`),
  ADD CONSTRAINT `estatus_administradores_fk` FOREIGN KEY (`estatus_id`) REFERENCES `estatus` (`estatus_id`);

--
-- Constraints for table `almacenistas`
--
ALTER TABLE `almacenistas`
  ADD CONSTRAINT `almacenistas_empleados_fk` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`empleado_id`),
  ADD CONSTRAINT `almacenistas_estatus_pk` FOREIGN KEY (`estatus_id`) REFERENCES `estatus` (`estatus_id`);

--
-- Constraints for table `empleados`
--
ALTER TABLE `empleados`
  ADD CONSTRAINT `empleados_estatus_fk` FOREIGN KEY (`estatus_id`) REFERENCES `estatus` (`estatus_id`);

--
-- Constraints for table `instrucciones`
--
ALTER TABLE `instrucciones`
  ADD CONSTRAINT `instrucciones_estatus_fk` FOREIGN KEY (`estatus_id`) REFERENCES `estatus` (`estatus_id`);

--
-- Constraints for table `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_estatus_fk` FOREIGN KEY (`estatus_id`) REFERENCES `estatus` (`estatus_id`),
  ADD CONSTRAINT `productos_tipoproductos_fk` FOREIGN KEY (`tipoproducto_id`) REFERENCES `tipoproductos` (`tipoproducto_id`);

--
-- Constraints for table `registros`
--
ALTER TABLE `registros`
  ADD CONSTRAINT `registros_estatus_fk` FOREIGN KEY (`estatus_id`) REFERENCES `estatus` (`estatus_id`),
  ADD CONSTRAINT `registros_instrucciones_fk` FOREIGN KEY (`instruccion_id`) REFERENCES `instrucciones` (`instruccion_id`),
  ADD CONSTRAINT `registros_productos_fk` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`producto_id`);

--
-- Constraints for table `supervisores`
--
ALTER TABLE `supervisores`
  ADD CONSTRAINT `supervisores_empleados_fk` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`empleado_id`),
  ADD CONSTRAINT `supervisores_estatus_fk` FOREIGN KEY (`estatus_id`) REFERENCES `estatus` (`estatus_id`);

--
-- Constraints for table `tipoproductos`
--
ALTER TABLE `tipoproductos`
  ADD CONSTRAINT `tipoproductos_estatus_fk` FOREIGN KEY (`estatus_id`) REFERENCES `estatus` (`estatus_id`);

--
-- Constraints for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_empleados_fk` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`empleado_id`),
  ADD CONSTRAINT `usuarios_estatus_fk` FOREIGN KEY (`estatus_id`) REFERENCES `estatus` (`estatus_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
