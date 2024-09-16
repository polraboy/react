-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 16, 2024 at 07:33 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `testskill_acg`
--

-- --------------------------------------------------------

--
-- Table structure for table `car`
--

CREATE TABLE `car` (
  `SerialNo` char(12) NOT NULL,
  `Brand` varchar(255) DEFAULT NULL,
  `Model` varchar(255) DEFAULT NULL,
  `Manufacturer` varchar(255) DEFAULT NULL,
  `Price` float(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `car`
--

INSERT INTO `car` (`SerialNo`, `Brand`, `Model`, `Manufacturer`, `Price`) VALUES
('1121236143', 'Ford', 'Raptor', 'Ford', 1500000.00),
('1121524423', 'Lamborgini', 'Matador v4', 'Lamborgini', 1500000.00),
('1121526143', 'BMW', 'I8', 'BMW', 90000.00),
('1123152143', 'Benz', 'Cv1', 'Benz', 100000.00),
('1124326143', 'Honda', 'City', 'Honda', 750000.00),
('15220494', 'Honda', 'Civic', 'Honda', 9999999.00),
('2123152143', 'BMW', 'M4', 'BMW', 5290000.00),
('2124156143', 'Mazda', 'N4', 'Mazda', 2590000.00),
('2323152143', 'Toyata', 'Yaris', 'Toyata', 190000.00),
('2424156143', 'Toyota', 'Camry', 'Toyota', 1190000.00);

-- --------------------------------------------------------

--
-- Stand-in structure for view `economiccar`
-- (See below for the actual view)
--
CREATE TABLE `economiccar` (
`SerialNo` char(12)
,`Brand` varchar(255)
,`Model` varchar(255)
,`Manufacturer` varchar(255)
,`Price` float(10,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `expensivecar`
-- (See below for the actual view)
--
CREATE TABLE `expensivecar` (
`SerialNo` char(12)
,`Brand` varchar(255)
,`Model` varchar(255)
,`Manufacturer` varchar(255)
,`Price` float(10,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `luxuriouscar`
-- (See below for the actual view)
--
CREATE TABLE `luxuriouscar` (
`SerialNo` char(12)
,`Brand` varchar(255)
,`Model` varchar(255)
,`Manufacturer` varchar(255)
,`Price` float(10,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `options`
--

CREATE TABLE `options` (
  `SerialNo` char(12) NOT NULL,
  `OptionName` varchar(255) NOT NULL,
  `Price` float(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `options`
--

INSERT INTO `options` (`SerialNo`, `OptionName`, `Price`) VALUES
('1121526143', 'Air Bag', 9000.00),
('1123152143', 'Smart Door', 20000.00),
('15220494', 'CD Player', 6000.00),
('2124156143', 'Marshall Stero', 40000.00),
('2124156143', 'Neon Eagle', 10000.00),
('2323152143', 'Automatic sunroof', 15000.00);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `SerialNo` char(12) NOT NULL,
  `SalePersonID` varchar(255) NOT NULL,
  `Price` float(10,2) DEFAULT NULL,
  `Day` int(11) DEFAULT NULL,
  `Month` varchar(20) DEFAULT NULL,
  `Year` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`SerialNo`, `SalePersonID`, `Price`, `Day`, `Month`, `Year`) VALUES
('1121236143', '003', 1500000.00, 1, 'December', 2546),
('1121526143', '001', 90000.00, 11, 'January', 2544),
('1121526143', '002', 90000.00, 11, 'August', 2544),
('15220494', '002', 9999999.00, 15, 'August', 2544),
('2124156143', '006', 2590000.00, 2, 'Febuary', 2545);

-- --------------------------------------------------------

--
-- Table structure for table `salesperson`
--

CREATE TABLE `salesperson` (
  `SalePersonID` varchar(255) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Phone` char(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `salesperson`
--

INSERT INTO `salesperson` (`SalePersonID`, `Name`, `Phone`) VALUES
('001', 'Chawanakorn Changya', '0828143656'),
('002', 'Phutanet Thongsri', '0816707482'),
('003', 'Kaykai Salaider', '0872275554'),
('004', 'Spider zaza', '0992890429'),
('005', 'Poon pan ', '0952203838'),
('006', 'jib jib ', '0432258989');

-- --------------------------------------------------------

--
-- Structure for view `economiccar`
--
DROP TABLE IF EXISTS `economiccar`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `economiccar`  AS SELECT `car`.`SerialNo` AS `SerialNo`, `car`.`Brand` AS `Brand`, `car`.`Model` AS `Model`, `car`.`Manufacturer` AS `Manufacturer`, `car`.`Price` AS `Price` FROM `car` WHERE `car`.`Price` <= 1000000WITH CASCADEDCHECK OPTION  ;

-- --------------------------------------------------------

--
-- Structure for view `expensivecar`
--
DROP TABLE IF EXISTS `expensivecar`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `expensivecar`  AS SELECT `car`.`SerialNo` AS `SerialNo`, `car`.`Brand` AS `Brand`, `car`.`Model` AS `Model`, `car`.`Manufacturer` AS `Manufacturer`, `car`.`Price` AS `Price` FROM `car` WHERE `car`.`Price` > 1000000WITH CASCADEDCHECK OPTION  ;

-- --------------------------------------------------------

--
-- Structure for view `luxuriouscar`
--
DROP TABLE IF EXISTS `luxuriouscar`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `luxuriouscar`  AS SELECT `expensivecar`.`SerialNo` AS `SerialNo`, `expensivecar`.`Brand` AS `Brand`, `expensivecar`.`Model` AS `Model`, `expensivecar`.`Manufacturer` AS `Manufacturer`, `expensivecar`.`Price` AS `Price` FROM `expensivecar` WHERE `expensivecar`.`Price` > 5000000WITH CASCADEDCHECK OPTION  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `car`
--
ALTER TABLE `car`
  ADD PRIMARY KEY (`SerialNo`);

--
-- Indexes for table `options`
--
ALTER TABLE `options`
  ADD PRIMARY KEY (`SerialNo`,`OptionName`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`SerialNo`,`SalePersonID`),
  ADD KEY `SalePersonID` (`SalePersonID`);

--
-- Indexes for table `salesperson`
--
ALTER TABLE `salesperson`
  ADD PRIMARY KEY (`SalePersonID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `options`
--
ALTER TABLE `options`
  ADD CONSTRAINT `options_ibfk_1` FOREIGN KEY (`SerialNo`) REFERENCES `car` (`SerialNo`);

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`SerialNo`) REFERENCES `car` (`SerialNo`),
  ADD CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`SalePersonID`) REFERENCES `salesperson` (`SalePersonID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
