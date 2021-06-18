-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-06-2021 a las 05:44:09
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `app_presupuestos`
--
CREATE DATABASE IF NOT EXISTS `app_presupuestos` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `app_presupuestos`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gasto`
--

CREATE TABLE `gasto` (
  `id_gasto` bigint(20) NOT NULL,
  `id_presupuesto` bigint(20) NOT NULL DEFAULT 0,
  `sin_presupuesto` int(11) NOT NULL,
  `motivo` text NOT NULL,
  `ruc` varchar(40) NOT NULL,
  `nro_documento` varchar(30) NOT NULL,
  `razon_social` varchar(150) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `fecha` date NOT NULL,
  `ruta_documento` varchar(200) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `usu_crea` int(11) NOT NULL DEFAULT 0,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `gasto`
--

INSERT INTO `gasto` (`id_gasto`, `id_presupuesto`, `sin_presupuesto`, `motivo`, `ruc`, `nro_documento`, `razon_social`, `monto`, `fecha`, `ruta_documento`, `estado`, `usu_crea`, `fecha_registro`) VALUES
(1, 1, 0, '', '555555', '42589999', 'Prueba SAC', '100.00', '2021-05-26', '9BPON5ZVFI1620422317.7944.pdf', 1, 1, '2021-05-07 16:18:37'),
(2, 1, 0, '', '12322212', '12121212121', '2212121', '111.00', '2021-05-24', 'L7YBFG02D51622090800.4353.pdf', 1, 1, '2021-05-26 23:46:40'),
(3, 1, 0, '', '12322212', '12121212121', '2212121', '111.00', '2021-05-24', 'X9Y1O3MB5L1622090835.9047.pdf', 1, 1, '2021-05-26 23:47:15'),
(4, 1, 0, '', '2121212', '12121212', '21212121212', '11.00', '2021-06-01', 'PSCW1Q1ANC1623545415.6382.pdf', 1, 1, '2021-06-12 19:50:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `presupuesto`
--

CREATE TABLE `presupuesto` (
  `id_presupuesto` bigint(20) NOT NULL,
  `descripcion` text NOT NULL,
  `fecha` date NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `ruta_documento` varchar(250) NOT NULL,
  `id_presupuesto_tipo` int(11) NOT NULL,
  `id_presupuesto_estado` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `usu_crea` int(11) NOT NULL DEFAULT 0,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `presupuesto`
--

INSERT INTO `presupuesto` (`id_presupuesto`, `descripcion`, `fecha`, `monto`, `ruta_documento`, `id_presupuesto_tipo`, `id_presupuesto_estado`, `estado`, `usu_crea`, `fecha_registro`) VALUES
(1, 'prueba 1', '2021-04-15', '400.00', 'QBM7CGZ4J91619729832.7169.pdf', 1, 1, 1, 1, '2021-04-29 15:57:12'),
(2, 'prueba 2', '2021-04-07', '200.00', '5UTSFN3CGE1619734042.8683.pdf', 2, 2, 1, 1, '2021-04-29 17:07:22'),
(3, 'nuevo presy', '2021-12-12', '200.00', '63IRKLQQOB1619742346.8664.pdf', 2, 1, 1, 1, '2021-04-29 19:25:46'),
(4, 'another test', '2021-05-11', '100.00', 'OB9A93ZON51620419059.2849.pdf', 1, 1, 1, 1, '2021-05-07 15:24:19'),
(5, 'dadasd', '2021-05-04', '11111.00', '4SV5QG1S1S1622065891.5508.pdf', 1, 1, 1, 1, '2021-05-26 16:51:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `presupuesto_asignado`
--

CREATE TABLE `presupuesto_asignado` (
  `id_presupuesto_asignado` bigint(20) NOT NULL,
  `id_presupuesto` bigint(20) NOT NULL,
  `id_area` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_final` date NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `usu_crea` int(11) NOT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `presupuesto_asignado`
--

INSERT INTO `presupuesto_asignado` (`id_presupuesto_asignado`, `id_presupuesto`, `id_area`, `id_usuario`, `fecha_inicio`, `fecha_final`, `estado`, `usu_crea`, `fecha_registro`) VALUES
(1, 1, 1, 1, '2021-05-07', '2021-05-14', 1, 1, '2021-05-07 15:28:35'),
(2, 2, 20, 3, '2021-06-07', '2021-06-30', 1, 1, '2021-06-12 21:40:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `presupuesto_estado`
--

CREATE TABLE `presupuesto_estado` (
  `id_presupuesto_estado` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `presupuesto_estado`
--

INSERT INTO `presupuesto_estado` (`id_presupuesto_estado`, `nombre`, `estado`, `fecha_registro`) VALUES
(1, 'Abierto', 1, '2021-04-29 12:57:28'),
(2, 'Cerrado', 1, '2021-04-29 12:57:28');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `presupuesto_tipo`
--

CREATE TABLE `presupuesto_tipo` (
  `id_presupuesto_tipo` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `presupuesto_tipo`
--

INSERT INTO `presupuesto_tipo` (`id_presupuesto_tipo`, `nombre`, `estado`, `fecha_registro`) VALUES
(1, 'Fijo', 1, '2021-04-29 11:36:29'),
(2, 'Flexible', 1, '2021-04-29 11:36:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajador`
--

CREATE TABLE `trabajador` (
  `id_trabajador` bigint(20) NOT NULL,
  `nombres` varchar(200) NOT NULL,
  `apellidos` varchar(200) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `trabajador`
--

INSERT INTO `trabajador` (`id_trabajador`, `nombres`, `apellidos`, `estado`, `fecha_registro`) VALUES
(1, 'pepe', 'luna', 1, '2021-04-29 18:17:59'),
(2, 'marisol', 'cacio', 1, '2021-04-29 18:17:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` bigint(20) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  `id_area` int(11) NOT NULL,
  `id_trabajador` int(11) NOT NULL DEFAULT 0,
  `nombres` varchar(200) NOT NULL,
  `apellidos` varchar(200) NOT NULL,
  `usuario` varchar(200) NOT NULL,
  `clave` varchar(200) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `usu_crea` int(11) NOT NULL DEFAULT 0,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `id_tipo`, `id_area`, `id_trabajador`, `nombres`, `apellidos`, `usuario`, `clave`, `estado`, `usu_crea`, `fecha_registro`) VALUES
(1, 1, 5, 0, 'aaaaaaaaaaaaaa', 'nnnnnnnnnnnnnnnnnnnn', 'admin', '123', 1, 1, '2021-04-28 16:55:10'),
(2, 2, 1, 0, 'aprueba', 'BPRUEBA', 'pruebaa', '123', 1, 1, '2021-04-29 11:20:17'),
(3, 3, 8, 0, 'prueba1002', 'prueba2002', 'pruebab', '123456', 1, 1, '2021-04-29 19:24:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_area`
--

CREATE TABLE `usuario_area` (
  `id_area` int(11) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `centro_costos` varchar(250) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario_area`
--

INSERT INTO `usuario_area` (`id_area`, `nombre`, `centro_costos`, `estado`, `fecha_registro`) VALUES
(1, 'Marketing', 'Asssssss', 1, '2021-04-28 16:45:39'),
(2, 'Sistemas', 'B', 0, '2021-04-28 16:45:39'),
(3, 'Administración', 'C', 0, '2021-04-28 16:46:17'),
(4, 'Logística', 'D', 0, '2021-04-28 16:46:17'),
(5, 'RRHH', 'E', 1, '2021-04-28 16:46:49'),
(6, 'prueba', '1234444', 1, '2021-04-29 01:30:43'),
(7, 'prueba 100', 'prueba 200', 1, '2021-04-29 13:50:00'),
(8, 'area de prueba', 'centro de prueba', 1, '2021-04-29 19:22:40'),
(9, 'dasdasd', 'dasdas', 1, '2021-05-26 18:35:46'),
(10, 'dsadasd', 'dsada', 1, '2021-05-26 18:35:48'),
(11, 'dadad', '222222', 1, '2021-05-26 18:35:53'),
(12, '1111111111111111', '1111111111111111', 1, '2021-05-26 18:36:15'),
(13, '2222222222222', '222222222222222222', 1, '2021-05-26 18:36:18'),
(14, '33333333333333333333', '33333333333333333', 1, '2021-05-26 18:36:22'),
(15, '4444444444444444', '444444444444444', 1, '2021-05-26 18:36:25'),
(16, '232323', '23231231', 1, '2021-05-26 18:36:40'),
(17, '333333333333', '3344444444444444444', 1, '2021-05-26 18:36:43'),
(18, '55555555555555555555', '555555555555555', 1, '2021-05-26 18:36:47'),
(19, '66666666666666666666', '6666666666666666666', 1, '2021-05-26 18:36:51'),
(20, '77777777777777', '777777777777777', 1, '2021-05-26 18:36:54'),
(21, '333456777', '8888888888888888888', 1, '2021-05-26 18:37:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_tipo`
--

CREATE TABLE `usuario_tipo` (
  `id_tipo` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario_tipo`
--

INSERT INTO `usuario_tipo` (`id_tipo`, `nombre`, `estado`, `fecha_registro`) VALUES
(1, 'Administrador', 1, '2021-04-28 16:47:36'),
(2, 'Supervisor', 1, '2021-04-28 16:47:36'),
(3, 'Colaborador', 1, '2021-04-28 16:47:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `web_acceso`
--

CREATE TABLE `web_acceso` (
  `id_web_acceso` int(11) NOT NULL,
  `id_web_url` int(11) NOT NULL,
  `id_tipo_usuario` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `web_acceso`
--

INSERT INTO `web_acceso` (`id_web_acceso`, `id_web_url`, `id_tipo_usuario`, `estado`) VALUES
(1, 1, 1, 1),
(2, 2, 1, 1),
(3, 3, 1, 1),
(4, 4, 1, 1),
(5, 5, 1, 1),
(6, 6, 1, 1),
(7, 7, 1, 1),
(8, 8, 1, 1),
(9, 3, 2, 1),
(10, 5, 2, 1),
(11, 7, 2, 1),
(12, 8, 2, 1),
(13, 5, 3, 1),
(14, 7, 3, 1),
(15, 8, 3, 1),
(16, 4, 2, 1),
(17, 6, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `web_url`
--

CREATE TABLE `web_url` (
  `id_web_url` int(11) NOT NULL,
  `web_url` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `web_url`
--

INSERT INTO `web_url` (`id_web_url`, `web_url`, `estado`) VALUES
(1, '/views/adm_area.php', 1),
(2, '/views/adm_usuario.php', 1),
(3, '/views/adm_presupuesto.php', 1),
(4, '/views/adm_presupuesto_asig.php', 1),
(5, '/views/adm_gasto.php', 1),
(6, '/views/adm_gasto_bus.php', 1),
(7, '/views/home.php', 1),
(8, '/views/', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `gasto`
--
ALTER TABLE `gasto`
  ADD PRIMARY KEY (`id_gasto`);

--
-- Indices de la tabla `presupuesto`
--
ALTER TABLE `presupuesto`
  ADD PRIMARY KEY (`id_presupuesto`);

--
-- Indices de la tabla `presupuesto_asignado`
--
ALTER TABLE `presupuesto_asignado`
  ADD PRIMARY KEY (`id_presupuesto_asignado`);

--
-- Indices de la tabla `presupuesto_estado`
--
ALTER TABLE `presupuesto_estado`
  ADD PRIMARY KEY (`id_presupuesto_estado`);

--
-- Indices de la tabla `presupuesto_tipo`
--
ALTER TABLE `presupuesto_tipo`
  ADD PRIMARY KEY (`id_presupuesto_tipo`);

--
-- Indices de la tabla `trabajador`
--
ALTER TABLE `trabajador`
  ADD PRIMARY KEY (`id_trabajador`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `usuario` (`usuario`);

--
-- Indices de la tabla `usuario_area`
--
ALTER TABLE `usuario_area`
  ADD PRIMARY KEY (`id_area`);

--
-- Indices de la tabla `usuario_tipo`
--
ALTER TABLE `usuario_tipo`
  ADD PRIMARY KEY (`id_tipo`);

--
-- Indices de la tabla `web_acceso`
--
ALTER TABLE `web_acceso`
  ADD PRIMARY KEY (`id_web_acceso`);

--
-- Indices de la tabla `web_url`
--
ALTER TABLE `web_url`
  ADD PRIMARY KEY (`id_web_url`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `gasto`
--
ALTER TABLE `gasto`
  MODIFY `id_gasto` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `presupuesto`
--
ALTER TABLE `presupuesto`
  MODIFY `id_presupuesto` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `presupuesto_asignado`
--
ALTER TABLE `presupuesto_asignado`
  MODIFY `id_presupuesto_asignado` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `presupuesto_estado`
--
ALTER TABLE `presupuesto_estado`
  MODIFY `id_presupuesto_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `presupuesto_tipo`
--
ALTER TABLE `presupuesto_tipo`
  MODIFY `id_presupuesto_tipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `trabajador`
--
ALTER TABLE `trabajador`
  MODIFY `id_trabajador` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuario_area`
--
ALTER TABLE `usuario_area`
  MODIFY `id_area` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `usuario_tipo`
--
ALTER TABLE `usuario_tipo`
  MODIFY `id_tipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `web_acceso`
--
ALTER TABLE `web_acceso`
  MODIFY `id_web_acceso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `web_url`
--
ALTER TABLE `web_url`
  MODIFY `id_web_url` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
