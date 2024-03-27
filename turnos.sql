-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 27-03-2024 a las 19:16:21
-- Versión del servidor: 8.2.0
-- Versión de PHP: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `turnos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudadano`
--

DROP TABLE IF EXISTS `ciudadano`;
CREATE TABLE IF NOT EXISTS `ciudadano` (
  `ID` bigint NOT NULL AUTO_INCREMENT,
  `DNI` varchar(255) DEFAULT NULL,
  `NOMBRE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `ciudadano`
--

INSERT INTO `ciudadano` (`ID`, `DNI`, `NOMBRE`) VALUES
(1, '70974277A', 'Hector'),
(2, '70974277B', 'Lucia'),
(3, '70974277C', 'Juan'),
(4, '70974277D', 'Luis'),
(5, '70974277E', 'Miguel'),
(6, '12345678A', 'Maria'),
(7, '77777777A', 'Hector'),
(8, '70654788X', 'yoli'),
(9, '70956421X', 'Carol Linares'),
(10, '70974277H', 'test'),
(11, '78965412X', 'Hector'),
(12, '74975488A', 'nacho'),
(13, '70974273A', 'test1'),
(14, '77974277M', 'test'),
(15, '70974477A', 'testt'),
(16, '70974274B', 'testttt'),
(17, '70274277B', 'test'),
(18, '74875988A', 'testing'),
(19, '70174277C', 'Lucia'),
(20, '77974277B', 'testtttttttttt'),
(21, '70444277B', 'test1'),
(24, '70971117B', 'Ultimo Test'),
(23, '71114277A', 'lastTest');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tramite`
--

DROP TABLE IF EXISTS `tramite`;
CREATE TABLE IF NOT EXISTS `tramite` (
  `ID` bigint NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `tramite`
--

INSERT INTO `tramite` (`ID`, `DESCRIPCION`) VALUES
(1, 'Renovacion de DNI'),
(2, 'Renovacion de pasaporte'),
(3, 'Cambiar empadronamiento'),
(4, 'Solicitud de ayudas sociales'),
(5, 'Solicitud de cambio de titularidad del coche');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turno`
--

DROP TABLE IF EXISTS `turno`;
CREATE TABLE IF NOT EXISTS `turno` (
  `ID` bigint NOT NULL AUTO_INCREMENT,
  `ESTADO` tinyint(1) DEFAULT '0',
  `FECHA` date DEFAULT NULL,
  `CIUDADANO_ID` bigint DEFAULT NULL,
  `TRAMITE_ID` bigint DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_TURNO_CIUDADANO_ID` (`CIUDADANO_ID`),
  KEY `FK_TURNO_TRAMITE_ID` (`TRAMITE_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `turno`
--

INSERT INTO `turno` (`ID`, `ESTADO`, `FECHA`, `CIUDADANO_ID`, `TRAMITE_ID`) VALUES
(1, 1, '2024-03-26', 1, 1),
(2, 1, '2024-03-26', 2, 2),
(3, 1, '2024-03-26', 3, 3),
(4, 0, '2024-03-25', 4, 4),
(5, 1, '2024-03-26', 5, 5),
(6, 0, '2024-03-24', 1, 2),
(7, 0, '2024-03-26', 1, 5),
(8, 1, '2024-03-24', 6, 5),
(9, 0, '2024-03-26', 7, 1),
(10, 1, '2024-03-26', 2, 5),
(11, 1, '2024-03-26', 8, 1),
(12, 0, '2024-03-26', 9, 4),
(13, 1, '2024-03-26', 10, 5),
(14, 0, '2024-03-26', 11, 1),
(15, 1, '2024-03-26', 12, 2),
(16, 1, '2024-03-26', 13, 2),
(17, 1, '2024-03-27', 14, 4),
(18, 1, '2024-03-27', 15, 5),
(19, 0, '2024-03-27', 16, 4),
(20, 1, '2024-03-27', 17, 1),
(21, 1, '2024-03-27', 18, 4),
(22, 0, '2024-03-27', 19, 4),
(23, 1, '2024-03-27', 1, 1),
(24, 1, '2024-03-27', 20, 1),
(25, 0, '2024-03-27', 21, 1),
(26, 1, '2024-03-27', 2, 1),
(29, 1, '2024-03-27', 24, 4),
(28, 0, '2024-03-27', 23, 4);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
