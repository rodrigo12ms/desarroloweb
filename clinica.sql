-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-09-2022 a las 18:19:48
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `clinica`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas`
--

CREATE TABLE `citas` (
  `ID` int(11) NOT NULL,
  `PACIENTE_DNI` char(8) NOT NULL,
  `MEDICO_ID` int(11) DEFAULT NULL,
  `URGENCIA` bit(1) DEFAULT b'0',
  `FECHA_PROGRAMADA` datetime DEFAULT NULL,
  `FECHA_REGISTRO` datetime NOT NULL,
  `NUMERO_ORDEN` int(11) DEFAULT NULL CHECK (`NUMERO_ORDEN` >= 1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dias`
--

CREATE TABLE `dias` (
  `DIA` char(1) NOT NULL,
  `MEDICO_ID` int(11) NOT NULL,
  `HORARIO_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidades`
--

CREATE TABLE `especialidades` (
  `ID` int(11) NOT NULL,
  `NOMBRE` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios`
--

CREATE TABLE `horarios` (
  `ID` int(11) NOT NULL,
  `HORA_INICIO` time NOT NULL,
  `HORA_FIN` time NOT NULL,
  `CUPOS` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicos`
--

CREATE TABLE `medicos` (
  `ID` int(11) NOT NULL,
  `DNI` char(8) DEFAULT NULL,
  `NOMBRE` varchar(30) DEFAULT NULL,
  `APELLIDOS` varchar(35) DEFAULT NULL,
  `ESPECIALIDAD_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `DNI` char(8) NOT NULL,
  `NOMBRE` varchar(30) DEFAULT NULL,
  `APELLIDOS` varchar(35) DEFAULT NULL,
  `DIRECCION` varchar(35) DEFAULT NULL,
  `TELEFONO` varchar(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `pacientes`
--

INSERT INTO `pacientes` (`DNI`, `NOMBRE`, `APELLIDOS`, `DIRECCION`, `TELEFONO`) VALUES
('71462018', 'rodrigo jian', 'espinoza sayago', 'av jian', 'telefono');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(6) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `to_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `to_date`) VALUES
(1, 'rodrigo', '$2y$10$QKaWStbOx8TSD.845VswXecOLtD8sXILr72n8lsxI3jYEnD.QEUM6', 'espinozasayagorodrigo@gma', '2022-09-07 19:14:30'),
(3, 'jian', '$2y$10$h.JtwVoyETmRnmlYFLrB5uwpC/Bos0SYF89/Xovww1/oV9eznRrnK', 'espinozasayagorodrigo@gmail.com', '2022-09-08 09:20:29'),
(4, 'ruth', '$2y$10$yQgQ2phBLAz8yhLuyl4f8OP4NUF8b7WoWCp0mXe6JtbuCAH8BRSVW', '192220@unamba.edu.pe', '2022-09-08 14:20:11');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `citas`
--
ALTER TABLE `citas`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `PACIENTE_DNI` (`PACIENTE_DNI`),
  ADD KEY `MEDICO_ID` (`MEDICO_ID`);

--
-- Indices de la tabla `dias`
--
ALTER TABLE `dias`
  ADD PRIMARY KEY (`DIA`,`MEDICO_ID`),
  ADD KEY `MEDICO_ID` (`MEDICO_ID`),
  ADD KEY `HORARIO_ID` (`HORARIO_ID`);

--
-- Indices de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ESPECIALIDAD_ID` (`ESPECIALIDAD_ID`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`DNI`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `citas`
--
ALTER TABLE `citas`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `medicos`
--
ALTER TABLE `medicos`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `citas`
--
ALTER TABLE `citas`
  ADD CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`PACIENTE_DNI`) REFERENCES `pacientes` (`DNI`),
  ADD CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`MEDICO_ID`) REFERENCES `medicos` (`ID`);

--
-- Filtros para la tabla `dias`
--
ALTER TABLE `dias`
  ADD CONSTRAINT `dias_ibfk_1` FOREIGN KEY (`MEDICO_ID`) REFERENCES `medicos` (`ID`),
  ADD CONSTRAINT `dias_ibfk_2` FOREIGN KEY (`HORARIO_ID`) REFERENCES `horarios` (`ID`);

--
-- Filtros para la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD CONSTRAINT `medicos_ibfk_1` FOREIGN KEY (`ESPECIALIDAD_ID`) REFERENCES `especialidades` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
