-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-05-2025 a las 23:17:09
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `botanero_ventas`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tipo` enum('PLATILLO','BEBIDA') NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `tipo`, `nombre`, `descripcion`) VALUES
(1, 'BEBIDA', 'Refresco', 'Refresco'),
(2, 'PLATILLO', 'Hamburguesas', 'Multiples Hamburguesas'),
(3, 'PLATILLO', 'Pastas ', 'Todo tipo de pastas '),
(4, 'BEBIDA', 'Cafe', 'Distintos tipos de café'),
(5, 'BEBIDA', 'Cerveza ', 'Diferentes tipos de cerveza '),
(6, 'PLATILLO', 'Baguette', 'Distintos tipos de baguette'),
(7, 'BEBIDA', 'Frappes', 'Diferentes sabores');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `informacion_negocio`
--

CREATE TABLE `informacion_negocio` (
  `nombre` varchar(100) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `numeroMesas` tinyint(4) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `informacion_negocio`
--

INSERT INTO `informacion_negocio` (`nombre`, `telefono`, `numeroMesas`, `logo`) VALUES
('Vue´s Restaurante', '123456', 5, './fotos/6822280bc6152.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `insumos`
--

CREATE TABLE `insumos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `codigo` varchar(100) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `precio` decimal(6,2) NOT NULL,
  `tipo` enum('PLATILLO','BEBIDA') NOT NULL,
  `categoria` bigint(20) UNSIGNED NOT NULL,
  `imagen` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `insumos`
--

INSERT INTO `insumos` (`id`, `codigo`, `nombre`, `descripcion`, `precio`, `tipo`, `categoria`, `imagen`) VALUES
(1, 'COCA600', 'Coca Cola 600ML', 'Refresco Coca Cola de 600ML', 25.00, 'BEBIDA', 1, ''),
(2, 'CIEL600', 'Agua Ciel 600ML', 'Agua Ciel de  600ML ', 15.00, 'BEBIDA', 1, ''),
(3, 'HBAME', 'Hamburguesa Americana ', 'Queso, Cebolla, Tocino', 80.00, 'PLATILLO', 2, ''),
(4, 'PASMA', 'Pasta Mar y Tierra ', 'Pasta con camarones y pollo a la plancha', 95.00, 'PLATILLO', 3, ''),
(5, 'CCOR', 'Cerveza Corona 410ml', 'Cerveza Corona, ampolleta ', 25.00, 'BEBIDA', 5, ''),
(6, 'CAFAM', 'Café Americano Taza Pequeña', 'Taza Pequeña', 25.00, 'BEBIDA', 4, ''),
(7, 'CETEC', 'Cerveza Tecate Roja 410ml', 'Cerveza tecate lata ', 25.00, 'BEBIDA', 5, ''),
(8, 'BAGAR', 'Baguette Arrachera', 'Incluye guacamole, chorizo, tocino', 85.00, 'PLATILLO', 6, ''),
(9, 'CERMOD', 'Cerveza Modelo Vidrio', 'Cerveza Modelo Ambar', 45.00, 'BEBIDA', 5, 'imagenes_insumos/6827af46d7c6d_6a94fa4e216d2bea950450a18b78066a.jpg'),
(10, 'PASCAR', 'Pasta Carbonara ', 'Pasta Carbonara ', 150.00, 'PLATILLO', 3, 'imagenes_insumos/6828c0f12fb28_carbonara-horizontal-threeByTwoMediumAt2X-v2.jpg'),
(11, 'CERHEIN', 'Cerveza Heineken', 'Envase de vidrio', 30.00, 'BEBIDA', 5, 'imagenes_insumos/6828d11f30f87_7501049999278_2_03032023_e3a10527-4031-40d8-8ea4-2cff85fb38f5.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `insumos_venta`
--

CREATE TABLE `insumos_venta` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `idInsumo` bigint(20) UNSIGNED NOT NULL,
  `precio` decimal(6,2) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `idVenta` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `insumos_venta`
--

INSERT INTO `insumos_venta` (`id`, `idInsumo`, `precio`, `cantidad`, `idVenta`) VALUES
(1, 1, 25.00, 3, 1),
(2, 1, 25.00, 5, 2),
(3, 2, 15.00, 5, 2),
(4, 1, 25.00, 2, 3),
(5, 2, 15.00, 1, 3),
(6, 2, 15.00, 1, 3),
(7, 1, 25.00, 1, 3),
(8, 2, 15.00, 1, 4),
(9, 1, 25.00, 1, 5),
(10, 2, 15.00, 1, 5),
(11, 3, 80.00, 2, 5),
(12, 3, 80.00, 2, 6),
(13, 2, 15.00, 3, 7),
(14, 3, 80.00, 1, 8),
(15, 1, 25.00, 1, 9),
(16, 2, 15.00, 1, 10),
(17, 3, 80.00, 2, 11),
(18, 1, 25.00, 1, 11),
(19, 1, 25.00, 1, 12),
(20, 3, 80.00, 1, 12),
(21, 3, 80.00, 2, 12),
(22, 5, 25.00, 5, 13),
(23, 4, 95.00, 1, 13),
(24, 1, 25.00, 1, 13),
(25, 5, 25.00, 2, 14),
(26, 3, 80.00, 1, 14),
(27, 3, 80.00, 1, 15),
(28, 1, 25.00, 1, 15),
(29, 4, 95.00, 1, 16),
(30, 5, 25.00, 1, 17),
(31, 3, 80.00, 1, 18),
(32, 4, 95.00, 1, 18),
(33, 1, 25.00, 1, 18),
(34, 8, 85.00, 1, 19),
(35, 3, 80.00, 1, 19),
(36, 7, 25.00, 1, 19),
(37, 5, 25.00, 1, 19),
(38, 1, 25.00, 2, 20),
(39, 5, 25.00, 1, 21),
(40, 3, 80.00, 1, 21),
(41, 4, 95.00, 1, 21),
(42, 10, 150.00, 1, 21),
(43, 1, 25.00, 1, 22),
(44, 10, 150.00, 1, 22),
(45, 10, 150.00, 1, 23),
(46, 11, 30.00, 5, 24),
(47, 5, 25.00, 1, 25),
(48, 10, 150.00, 1, 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `correo` varchar(100) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `correo`, `nombre`, `telefono`, `password`) VALUES
(4, 'nava.saidalfredo@gmail.com', 'Administrador', '123456', '$2y$10$t3CquRsomyWTGFnC83ZKdeVG6//JtZDxsaNcp9ErFtSFc7BnV5MKW'),
(5, 'prueba@correo.com', 'Prueba', '123456789', '$2y$10$tFX5P4GidI4IJAH4aurAieqsKjuIktp98NYP2Z0hAKMvyOUI88xba');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `idMesa` tinyint(4) NOT NULL,
  `cliente` varchar(100) DEFAULT NULL,
  `fecha` datetime NOT NULL,
  `total` decimal(6,2) NOT NULL,
  `pagado` decimal(6,2) NOT NULL,
  `idUsuario` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `idMesa`, `cliente`, `fecha`, `total`, `pagado`, `idUsuario`) VALUES
(1, 1, 'MOSTRADOR', '2025-05-08 22:11:36', 75.00, 500.00, 1),
(2, 1, 'MOSTRADOR', '2025-05-09 00:44:43', 200.00, 500.00, 1),
(3, 2, 'MOSTRADOR', '2025-05-09 19:45:32', 105.00, 200.00, 1),
(4, 3, 'Francisco Dominguez ', '2025-05-09 19:47:48', 15.00, 30.00, 1),
(5, 6, 'MOSTRADOR', '2025-05-09 20:40:29', 200.00, 500.00, 1),
(6, 1, 'MOSTRADOR', '2025-05-09 20:43:59', 160.00, 200.00, 1),
(7, 1, 'MOSTRADOR', '2025-05-09 20:45:22', 45.00, 50.00, 1),
(8, 3, 'MOSTRADOR', '2025-05-09 20:50:25', 80.00, 100.00, 1),
(9, 1, 'MOSTRADOR', '2025-05-09 23:29:19', 25.00, 25.00, 1),
(10, 2, 'MOSTRADOR', '2025-05-09 23:35:30', 15.00, 20.00, 1),
(11, 1, 'MOSTRADOR', '2025-05-09 23:38:27', 185.00, 200.00, 3),
(12, 1, 'MOSTRADOR', '2025-05-12 11:59:43', 265.00, 300.00, 1),
(13, 1, 'Saul ', '2025-05-12 15:40:01', 245.00, 500.00, 1),
(14, 2, 'MOSTRADOR', '2025-05-13 11:43:16', 130.00, 130.00, 1),
(15, 1, 'MOSTRADOR', '2025-05-13 11:46:48', 105.00, 205.00, 3),
(16, 1, 'MOSTRADOR', '2025-05-13 14:30:57', 95.00, 95.00, 4),
(17, 2, 'MOSTRADOR', '2025-05-13 14:35:15', 25.00, 25.00, 4),
(18, 1, 'MOSTRADOR', '2025-05-14 09:56:45', 200.00, 500.00, 4),
(19, 2, 'MOSTRADOR', '2025-05-14 12:00:43', 215.00, 250.00, 4),
(20, 1, 'MOSTRADOR', '2025-05-16 13:38:58', 50.00, 50.00, 1),
(21, 1, 'MOSTRADOR', '2025-05-17 11:02:38', 350.00, 400.00, 4),
(22, 1, 'MOSTRADOR', '2025-05-17 12:20:36', 175.00, 200.00, 4),
(23, 2, 'MOSTRADOR', '2025-05-17 12:20:51', 150.00, 500.00, 4),
(24, 3, 'MOSTRADOR', '2025-05-17 12:21:03', 150.00, 150.00, 4),
(25, 1, 'MOSTRADOR', '2025-05-27 13:23:49', 175.00, 200.00, 4);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `insumos`
--
ALTER TABLE `insumos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `insumos_venta`
--
ALTER TABLE `insumos_venta`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `insumos`
--
ALTER TABLE `insumos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `insumos_venta`
--
ALTER TABLE `insumos_venta`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
