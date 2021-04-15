-- MySQL Script generated by MySQL Workbench
-- 04/15/21 01:52:58
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema db_sistema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_sistema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_sistema` DEFAULT CHARACTER SET latin1 ;
USE `db_sistema` ;

-- -----------------------------------------------------
-- Table `db_sistema`.`almacenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_sistema`.`almacenes` (
  `almacen_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sector` VARCHAR(10) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`almacen_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;

-- -----------------------------------------------------
-- Table `db_sistema`.`cargos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_sistema`.`cargos` (
  `cargo_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`cargo_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;

-- -----------------------------------------------------
-- Table `db_sistema`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_sistema`.`empleados` (
  `empleado_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(100) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `cedula` INT(10) UNSIGNED NOT NULL,
  `telefono` INT(10) UNSIGNED NOT NULL,
  `cargo_id` INT(10) UNSIGNED NOT NULL,
  `almacen_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`empleado_id`),
  UNIQUE INDEX `cedula` (`cedula` ASC),
  UNIQUE INDEX `telefono` (`telefono` ASC),
  INDEX `empleados_cargos_fk` (`cargo_id` ASC),
  INDEX `empleados_almacenes_fk` (`almacen_id` ASC),
  CONSTRAINT `empleados_almacenes_fk`
    FOREIGN KEY (`almacen_id`)
    REFERENCES `db_sistema`.`almacenes` (`almacen_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `empleados_cargos_fk`
    FOREIGN KEY (`cargo_id`)
    REFERENCES `db_sistema`.`cargos` (`cargo_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `db_sistema`.`estatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_sistema`.`estatus` (
  `estatus_id` INT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`estatus_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `db_sistema`.`instrucciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_sistema`.`instrucciones` (
  `instruccion_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`instruccion_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `db_sistema`.`tipoproductos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_sistema`.`tipoproductos` (
  `tipoproducto_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `estatus_id` INT(1) UNSIGNED NOT NULL,
  PRIMARY KEY (`tipoproducto_id`),
  INDEX `tipoproductos_estatus_fk` (`estatus_id` ASC),
  CONSTRAINT `tipoproductos_estatus_fk`
    FOREIGN KEY (`estatus_id`)
    REFERENCES `db_sistema`.`estatus` (`estatus_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `db_sistema`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_sistema`.`productos` (
  `producto_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `codigo` INT(10) UNSIGNED NOT NULL,
  `cantidad` INT(10) UNSIGNED NOT NULL,
  `tipoproducto_id` INT(10) UNSIGNED NOT NULL,
  `almacen_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`producto_id`),
  INDEX `productos_tipoproductos_fk` (`tipoproducto_id` ASC),
  CONSTRAINT `productos_tipoproductos_fk`
    FOREIGN KEY (`tipoproducto_id`)
    REFERENCES `db_sistema`.`tipoproductos` (`tipoproducto_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 38
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `db_sistema`.`registros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_sistema`.`registros` (
  `registro_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `codigo` INT(10) UNSIGNED NOT NULL,
  `producto_id` INT(10) UNSIGNED NOT NULL,
  `instruccion_id` INT(10) UNSIGNED NOT NULL,
  `fecha` DATE NOT NULL,
  `cantidad_producto` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`registro_id`),
  INDEX `registros_productos_fk` (`producto_id` ASC),
  INDEX `registros_instrucciones_fk` (`instruccion_id` ASC),
  CONSTRAINT `registros_instrucciones_fk`
    FOREIGN KEY (`instruccion_id`)
    REFERENCES `db_sistema`.`instrucciones` (`instruccion_id`),
  CONSTRAINT `registros_productos_fk`
    FOREIGN KEY (`producto_id`)
    REFERENCES `db_sistema`.`productos` (`producto_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `db_sistema`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_sistema`.`usuarios` (
  `usuario_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `empleado_id` INT(10) UNSIGNED NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `clave` VARCHAR(100) NOT NULL,
  `fecha_registro` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ultima_conexion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`usuario_id`),
  UNIQUE INDEX `correo` (`correo` ASC),
  INDEX `usuarios_empleados_fk` (`empleado_id` ASC),
  CONSTRAINT `usuarios_empleados_fk`
    FOREIGN KEY (`empleado_id`)
    REFERENCES `db_sistema`.`empleados` (`empleado_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;