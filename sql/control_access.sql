-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-04-2024 a las 04:59:44
-- Versión del servidor: 10.4.18-MariaDB
-- Versión de PHP: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `control_access`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `accesos`
--

CREATE TABLE `accesos` (
  `n_acceso` int(11) NOT NULL,
  `hora` time NOT NULL,
  `fecha` date NOT NULL,
  `n_identificacion` VARCHAR(11) NOT NULL,
  `ci_empleados` VARCHAR(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `ci_empleados` VARCHAR(11) NOT NULL,
  `nombre_empleado` varchar(60) NOT NULL,
  `apellido_empleado` varchar(60) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `celular` int(8) NOT NULL,
  `cargo` varchar(30) NOT NULL,
  `contraseña` varchar(100) NOT NULL,
  `correo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tickets`
--

CREATE TABLE `tickets` (
  `token_acceso` VARCHAR(15) NOT NULL,
  `n_identificacion` int(11) NOT NULL,
  `celular` int(8) NOT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `ci_empleados` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_extranjeros`
--

CREATE TABLE `usuarios_extranjeros` (
  `n_identificacion` VARCHAR(15) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `apellido_paterno_usuario` varchar(30) NOT NULL,
  `apellido_materno_usuario` varchar(30) NOT NULL,
  `nacionalidad` varchar(30) NOT NULL,
  `estado` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_nacionales`
--

CREATE TABLE `usuarios_nacionales` (
  `n_identificacion` VARCHAR(11) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `apellido_paterno_usuario` varchar(30) NOT NULL,
  `apellido_materno_usuario` varchar(30) DEFAULT NULL,
  `ciudad` varchar(20) NOT NULL,
  `estado` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `accesos`
--
ALTER TABLE `accesos`
  ADD PRIMARY KEY (`n_acceso`),
  ADD KEY `fk_CiEmpleado_empleados` (`ci_empleados`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`ci_empleados`);

--
-- Indices de la tabla `tickets`
--
ALTER TABLE `tickets`
  ADD KEY `fk_ci_empleados_tickets_nacionales` (`ci_empleados`),
  ADD KEY `fk_Nidentificacion_usuariosNacionales_tickets` (`n_identificacion`);

--
-- Indices de la tabla `usuarios_extranjeros`
--
ALTER TABLE `usuarios_extranjeros`
  ADD PRIMARY KEY (`n_identificacion`);

--
-- Indices de la tabla `usuarios_nacionales`
--
ALTER TABLE `usuarios_nacionales`
  ADD PRIMARY KEY (`n_identificacion`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `accesos`
--
ALTER TABLE `accesos`
  ADD CONSTRAINT `fk_CiEmpleado_empleados` FOREIGN KEY (`ci_empleados`) REFERENCES `empleados` (`ci_empleados`),
  ADD CONSTRAINT `fk_Nidentificacion_usuariosExtranjeros` FOREIGN KEY (`n_identificacion`) REFERENCES `usuarios_extranjeros` (`n_identificacion`),
  ADD CONSTRAINT `fk_Nidentificacion_usuariosNacionales` FOREIGN KEY (`n_identificacion`) REFERENCES `usuarios_nacionales` (`n_identificacion`);

--
-- Filtros para la tabla `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `fk_Nidentificacion_usuariosExtranjeros_tickets` FOREIGN KEY (`n_identificacion`) REFERENCES `usuarios_extranjeros` (`n_identificacion`),
  ADD CONSTRAINT `fk_Nidentificacion_usuariosNacionales_tickets` FOREIGN KEY (`n_identificacion`) REFERENCES `usuarios_nacionales` (`n_identificacion`),
  ADD CONSTRAINT `fk_ci_empleados_tickets_nacionales` FOREIGN KEY (`ci_empleados`) REFERENCES `empleados` (`ci_empleados`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
