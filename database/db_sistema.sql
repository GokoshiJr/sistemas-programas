-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:4000
-- Generation Time: Apr 16, 2021 at 04:20 AM
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
-- Database: `db_sistema`
--

-- --------------------------------------------------------

--
-- Table structure for table `almacenes`
--

CREATE TABLE `almacenes` (
  `almacen_id` int(10) UNSIGNED NOT NULL,
  `sector` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `almacenes`
--

INSERT INTO `almacenes` (`almacen_id`, `sector`) VALUES
(1, 'Norte'),
(3, 'Norte/Sur'),
(2, 'Sur');

-- --------------------------------------------------------

--
-- Table structure for table `cargos`
--

CREATE TABLE `cargos` (
  `cargo_id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cargos`
--

INSERT INTO `cargos` (`cargo_id`, `nombre`) VALUES
(1, 'Administrador'),
(3, 'Almacenista'),
(2, 'Supervisor');

-- --------------------------------------------------------

--
-- Table structure for table `empleados`
--

CREATE TABLE `empleados` (
  `empleado_id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `cedula` int(10) UNSIGNED NOT NULL,
  `telefono` int(10) UNSIGNED NOT NULL,
  `cargo_id` int(10) UNSIGNED NOT NULL,
  `almacen_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `empleados`
--

INSERT INTO `empleados` (`empleado_id`, `nombre`, `apellido`, `fecha_nacimiento`, `cedula`, `telefono`, `cargo_id`, `almacen_id`) VALUES
(1, 'Julio', 'Gonzalez', '2000-12-12', 28195303, 4247300796, 1, 3),
(2, 'Marcel', 'Gonzalez', '2000-09-22', 27925394, 4244718714, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `instrucciones`
--

CREATE TABLE `instrucciones` (
  `instruccion_id` int(10) UNSIGNED NOT NULL,
  `tipoinstruccion_id` int(10) UNSIGNED NOT NULL,
  `producto_id` int(10) UNSIGNED NOT NULL,
  `cantidad_producto` int(10) UNSIGNED NOT NULL,
  `especificacion` varchar(200) NOT NULL,
  `almacen_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `instrucciones`
--

INSERT INTO `instrucciones` (`instruccion_id`, `tipoinstruccion_id`, `producto_id`, `cantidad_producto`, `especificacion`, `almacen_id`) VALUES
(1, 1, 5, 5, 'Ingresaron 5 kilos de albahaca del mercado municipal', 1),
(2, 2, 20, 4, 'Ajuste de cafe para el pana Marcel que quiere tomarlo en las mañanas', 2);

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
  `almacen_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `productos`
--

INSERT INTO `productos` (`producto_id`, `nombre`, `codigo`, `cantidad`, `tipoproducto_id`, `almacen_id`) VALUES
(1, 'SEMOLA 45KG', 1111, 3, 1, 1),
(2, 'HARINA DE TRIGO 45KG', 1112, 3, 1, 1),
(3, 'SAL REFINADA 21KG', 1211, 2, 2, 1),
(4, 'CARTON DE HUEVOS', 1311, 5, 3, 1),
(5, 'ALBAHACA 1KG', 1411, 3, 4, 1),
(6, 'QUESO PARMESANO 1KG', 1511, 3, 5, 1),
(7, 'SEMOLA 45KG', 1111, 3, 1, 1),
(8, 'HARINA DE TRIGO 45KG', 1112, 3, 1, 1),
(9, 'SAL REFINADA 21KG', 1211, 2, 2, 1),
(10, 'CARTON DE HUEVOS', 1311, 5, 3, 1),
(11, 'ALBAHACA 1KG', 1411, 3, 4, 1),
(12, 'QUESO PARMESANO 1KG', 1511, 3, 5, 1),
(13, 'PIÑONES 1KG', 1611, 3, 6, 1),
(14, 'QUESO RICOTA 1KG', 1512, 2, 5, 1),
(15, 'ESPINACA 1KG', 1412, 3, 4, 1),
(16, 'QUESO MASCARPONE 1KG', 1513, 2, 5, 1),
(17, 'CACAO EN POLVO 5KG', 1711, 2, 7, 1),
(18, 'AZUCAR GLASS 11KG', 1712, 1, 7, 1),
(19, 'BIZCOCHO DE SOLETILLA 1KG', 1811, 3, 8, 1),
(20, 'CAFÉ MOLIDO 1KG', 1713, 3, 7, 1),
(21, 'OSOBUCO 1KG', 1312, 5, 3, 1),
(22, 'CARNE DE RES 1KG', 1313, 11, 3, 1),
(23, 'PAPA 1KG', 1911, 5, 9, 1),
(24, 'SALCHICHA 1KG', 1314, 5, 3, 1),
(25, 'AUYAMA 1KG', 1912, 2, 9, 1),
(26, 'TORTELLONES RICOTA ESPINACA', 1001, 10, 10, 2),
(27, 'RAVIOLIS OSOBUCO', 1101, 13, 11, 2),
(28, 'RAVIOLIS MILANESA', 1102, 13, 11, 2),
(29, 'RAVIOLIS SALCHICHA Y PAPA', 1103, 11, 11, 2),
(30, 'TORTELLONES QUESO CREMA AUYAMA', 1002, 8, 10, 2),
(31, 'TORTELLONES CARNE', 1003, 9, 10, 2),
(32, 'SALSA PESTO', 1201, 15, 12, 2),
(33, 'SALSA AMATRICIANA', 1202, 15, 12, 2),
(34, 'GNOCCHIS PAPA', 1301, 5, 13, 2),
(35, 'GNOCCHIS AUYAMA', 1302, 5, 13, 2),
(36, 'TIRAMISU', 1401, 3, 14, 2),
(37, 'SPAGHETTI', 1501, 20, 15, 2);

-- --------------------------------------------------------

--
-- Table structure for table `registros`
--

CREATE TABLE `registros` (
  `registro_id` int(10) UNSIGNED NOT NULL,
  `codigo` int(10) UNSIGNED NOT NULL,
  `producto_id` int(10) UNSIGNED NOT NULL,
  `instruccion_id` int(10) UNSIGNED NOT NULL,
  `fecha` timestamp NOT NULL,
  `cantidad_producto` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tipoinstrucciones`
--

CREATE TABLE `tipoinstrucciones` (
  `tipoinstruccion_id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tipoinstrucciones`
--

INSERT INTO `tipoinstrucciones` (`tipoinstruccion_id`, `nombre`) VALUES
(1, 'Entrada'),
(2, 'Salida');

-- --------------------------------------------------------

--
-- Table structure for table `tipoproductos`
--

CREATE TABLE `tipoproductos` (
  `tipoproducto_id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tipoproductos`
--

INSERT INTO `tipoproductos` (`tipoproducto_id`, `nombre`) VALUES
(3, 'ANIMAL'),
(8, 'BIZCOCHOS'),
(4, 'ESPECIAS'),
(6, 'FRUTOS SECOS'),
(13, 'GNOCCHIS'),
(1, 'HARINA'),
(2, 'MINERALES'),
(15, 'PASTA'),
(7, 'POLVOS'),
(14, 'POSTRE'),
(5, 'QUESOS'),
(11, 'RAVIOLIS'),
(12, 'SALSA'),
(10, 'TORTELLONES'),
(9, 'VEGETALES');

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `usuario_id` int(10) UNSIGNED NOT NULL,
  `empleado_id` int(10) UNSIGNED NOT NULL,
  `correo` varchar(100) NOT NULL,
  `clave` varchar(100) NOT NULL,
  `ultima_conexion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`usuario_id`, `empleado_id`, `correo`, `clave`, `ultima_conexion`) VALUES
(1, 1, 'julioagonzalez18@gmail.com', '123', '2021-04-16 04:00:01'),
(2, 2, 'marcel202101@gmail.com', 'ABC', '2021-04-16 04:01:30');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `almacenes`
--
ALTER TABLE `almacenes`
  ADD PRIMARY KEY (`almacen_id`),
  ADD UNIQUE KEY `sector` (`sector`);

--
-- Indexes for table `cargos`
--
ALTER TABLE `cargos`
  ADD PRIMARY KEY (`cargo_id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indexes for table `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`empleado_id`),
  ADD UNIQUE KEY `cedula` (`cedula`),
  ADD UNIQUE KEY `telefono` (`telefono`),
  ADD KEY `empleados_cargos_fk` (`cargo_id`),
  ADD KEY `empleados_almacenes_fk` (`almacen_id`);

--
-- Indexes for table `instrucciones`
--
ALTER TABLE `instrucciones`
  ADD PRIMARY KEY (`instruccion_id`),
  ADD KEY `instrucciones_tipoinstrucciones_fk` (`tipoinstruccion_id`),
  ADD KEY `instrucciones_almacenes_fk` (`almacen_id`),
  ADD KEY `instrucciones_producto_fk` (`producto_id`);

--
-- Indexes for table `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`producto_id`),
  ADD KEY `productos_tipoproductos_fk` (`tipoproducto_id`),
  ADD KEY `productos_almacenes_fk` (`almacen_id`);

--
-- Indexes for table `registros`
--
ALTER TABLE `registros`
  ADD PRIMARY KEY (`registro_id`),
  ADD KEY `registros_productos_fk` (`producto_id`),
  ADD KEY `registros_instrucciones_fk` (`instruccion_id`);

--
-- Indexes for table `tipoinstrucciones`
--
ALTER TABLE `tipoinstrucciones`
  ADD PRIMARY KEY (`tipoinstruccion_id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indexes for table `tipoproductos`
--
ALTER TABLE `tipoproductos`
  ADD PRIMARY KEY (`tipoproducto_id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usuario_id`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `usuarios_empleados_fk` (`empleado_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `almacenes`
--
ALTER TABLE `almacenes`
  MODIFY `almacen_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cargos`
--
ALTER TABLE `cargos`
  MODIFY `cargo_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `empleados`
--
ALTER TABLE `empleados`
  MODIFY `empleado_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `instrucciones`
--
ALTER TABLE `instrucciones`
  MODIFY `instruccion_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `productos`
--
ALTER TABLE `productos`
  MODIFY `producto_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `registros`
--
ALTER TABLE `registros`
  MODIFY `registro_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tipoinstrucciones`
--
ALTER TABLE `tipoinstrucciones`
  MODIFY `tipoinstruccion_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tipoproductos`
--
ALTER TABLE `tipoproductos`
  MODIFY `tipoproducto_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usuario_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `empleados`
--
ALTER TABLE `empleados`
  ADD CONSTRAINT `empleados_almacenes_fk` FOREIGN KEY (`almacen_id`) REFERENCES `almacenes` (`almacen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `empleados_cargos_fk` FOREIGN KEY (`cargo_id`) REFERENCES `cargos` (`cargo_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `instrucciones`
--
ALTER TABLE `instrucciones`
  ADD CONSTRAINT `instrucciones_almacenes_fk` FOREIGN KEY (`almacen_id`) REFERENCES `almacenes` (`almacen_id`),
  ADD CONSTRAINT `instrucciones_producto_fk` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`producto_id`),
  ADD CONSTRAINT `instrucciones_tipoinstrucciones_fk` FOREIGN KEY (`tipoinstruccion_id`) REFERENCES `tipoinstrucciones` (`tipoinstruccion_id`);

--
-- Constraints for table `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_almacenes_fk` FOREIGN KEY (`almacen_id`) REFERENCES `almacenes` (`almacen_id`),
  ADD CONSTRAINT `productos_tipoproductos_fk` FOREIGN KEY (`tipoproducto_id`) REFERENCES `tipoproductos` (`tipoproducto_id`);

--
-- Constraints for table `registros`
--
ALTER TABLE `registros`
  ADD CONSTRAINT `registros_instrucciones_fk` FOREIGN KEY (`instruccion_id`) REFERENCES `tipoinstrucciones` (`tipoinstruccion_id`),
  ADD CONSTRAINT `registros_productos_fk` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`producto_id`);

--
-- Constraints for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_empleados_fk` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`empleado_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
