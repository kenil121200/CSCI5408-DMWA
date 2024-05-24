CREATE DATABASE  IF NOT EXISTS `hoteldatabasegroup30` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hoteldatabasegroup30`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hoteldatabasegroup30
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `billing`
--

DROP TABLE IF EXISTS `billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing` (
  `BillingID` int NOT NULL,
  `BillingDate` date DEFAULT NULL,
  `TotalAmount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`BillingID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing`
--

LOCK TABLES `billing` WRITE;
/*!40000 ALTER TABLE `billing` DISABLE KEYS */;
/*!40000 ALTER TABLE `billing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `GuestID` int NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `PhoneNumber` varchar(20) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Nationality` varchar(50) DEFAULT NULL,
  `PassportIDNumber` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`GuestID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `EmployeeID` int NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `Position` varchar(50) DEFAULT NULL,
  `Department` varchar(50) DEFAULT NULL,
  `PhoneNumber` varchar(20) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `HireDate` date DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `HotelID` int DEFAULT NULL,
  `EmployeeTypeID` int DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`),
  KEY `HotelID` (`HotelID`),
  KEY `EmployeeTypeID` (`EmployeeTypeID`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`HotelID`) REFERENCES `hotel` (`HotelID`),
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`EmployeeTypeID`) REFERENCES `employeetype` (`EmployeeTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employeepayroll`
--

DROP TABLE IF EXISTS `employeepayroll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employeepayroll` (
  `PayrollID` int NOT NULL,
  `PayrollDate` date DEFAULT NULL,
  `SalaryAmount` decimal(10,2) DEFAULT NULL,
  `EmployeeID` int DEFAULT NULL,
  PRIMARY KEY (`PayrollID`),
  KEY `EmployeeID` (`EmployeeID`),
  CONSTRAINT `employeepayroll_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employee` (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employeepayroll`
--

LOCK TABLES `employeepayroll` WRITE;
/*!40000 ALTER TABLE `employeepayroll` DISABLE KEYS */;
/*!40000 ALTER TABLE `employeepayroll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employeeshift`
--

DROP TABLE IF EXISTS `employeeshift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employeeshift` (
  `ShiftID` int NOT NULL,
  `ShiftDate` date DEFAULT NULL,
  `ShiftStartTime` time DEFAULT NULL,
  `ShiftEndTime` time DEFAULT NULL,
  `EmployeeID` int DEFAULT NULL,
  PRIMARY KEY (`ShiftID`),
  KEY `EmployeeID` (`EmployeeID`),
  CONSTRAINT `employeeshift_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employee` (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employeeshift`
--

LOCK TABLES `employeeshift` WRITE;
/*!40000 ALTER TABLE `employeeshift` DISABLE KEYS */;
/*!40000 ALTER TABLE `employeeshift` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employeetype`
--

DROP TABLE IF EXISTS `employeetype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employeetype` (
  `EmployeeTypeID` int NOT NULL,
  `TypeName` varchar(50) DEFAULT NULL,
  `Description` text,
  PRIMARY KEY (`EmployeeTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employeetype`
--

LOCK TABLES `employeetype` WRITE;
/*!40000 ALTER TABLE `employeetype` DISABLE KEYS */;
/*!40000 ALTER TABLE `employeetype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `EventID` int NOT NULL,
  `EventName` varchar(255) DEFAULT NULL,
  `EventDate` date DEFAULT NULL,
  `Location` varchar(255) DEFAULT NULL,
  `Description` text,
  `HotelID` int DEFAULT NULL,
  `FacilityID` int DEFAULT NULL,
  PRIMARY KEY (`EventID`),
  KEY `HotelID` (`HotelID`),
  KEY `FacilityID` (`FacilityID`),
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`HotelID`) REFERENCES `hotel` (`HotelID`),
  CONSTRAINT `event_ibfk_2` FOREIGN KEY (`FacilityID`) REFERENCES `facility` (`FacilityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facility`
--

DROP TABLE IF EXISTS `facility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facility` (
  `FacilityID` int NOT NULL,
  `FacilityName` varchar(50) DEFAULT NULL,
  `Description` text,
  `AvailabilityStatus` varchar(20) DEFAULT NULL,
  `HotelID` int DEFAULT NULL,
  `CategoryID` int DEFAULT NULL,
  PRIMARY KEY (`FacilityID`),
  KEY `HotelID` (`HotelID`),
  KEY `CategoryID` (`CategoryID`),
  CONSTRAINT `facility_ibfk_1` FOREIGN KEY (`HotelID`) REFERENCES `hotel` (`HotelID`),
  CONSTRAINT `facility_ibfk_2` FOREIGN KEY (`CategoryID`) REFERENCES `facilitycategory` (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facility`
--

LOCK TABLES `facility` WRITE;
/*!40000 ALTER TABLE `facility` DISABLE KEYS */;
/*!40000 ALTER TABLE `facility` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facilitycategory`
--

DROP TABLE IF EXISTS `facilitycategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facilitycategory` (
  `CategoryID` int NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Description` text,
  PRIMARY KEY (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facilitycategory`
--

LOCK TABLES `facilitycategory` WRITE;
/*!40000 ALTER TABLE `facilitycategory` DISABLE KEYS */;
/*!40000 ALTER TABLE `facilitycategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel`
--

DROP TABLE IF EXISTS `hotel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel` (
  `HotelID` int NOT NULL,
  `HotelName` varchar(255) DEFAULT NULL,
  `Location` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `PhoneNumber` varchar(20) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Rating` float DEFAULT NULL,
  `Description` text,
  `NumberOfRooms` int DEFAULT NULL,
  PRIMARY KEY (`HotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel`
--

LOCK TABLES `hotel` WRITE;
/*!40000 ALTER TABLE `hotel` DISABLE KEYS */;
/*!40000 ALTER TABLE `hotel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `ItemID` int NOT NULL,
  `ItemName` varchar(255) DEFAULT NULL,
  `Description` text,
  `Quantity` int DEFAULT NULL,
  `Location` varchar(255) DEFAULT NULL,
  `HotelID` int DEFAULT NULL,
  `SupplierID` int DEFAULT NULL,
  PRIMARY KEY (`ItemID`),
  KEY `HotelID` (`HotelID`),
  KEY `SupplierID` (`SupplierID`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`HotelID`) REFERENCES `hotel` (`HotelID`),
  CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`SupplierID`) REFERENCES `supplier` (`SupplierID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `InvoiceID` int NOT NULL,
  `InvoiceDate` date DEFAULT NULL,
  `TaxInformation` text,
  `Discounts` decimal(10,2) DEFAULT NULL,
  `TotalAmount` decimal(10,2) DEFAULT NULL,
  `ReservationID` int DEFAULT NULL,
  PRIMARY KEY (`InvoiceID`),
  KEY `ReservationID` (`ReservationID`),
  CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`ReservationID`) REFERENCES `reservation` (`ReservationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lostandfound`
--

DROP TABLE IF EXISTS `lostandfound`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lostandfound` (
  `LostAndFoundID` int NOT NULL,
  `ItemName` varchar(255) DEFAULT NULL,
  `Description` text,
  `LocationFound` varchar(255) DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL,
  `HotelID` int DEFAULT NULL,
  PRIMARY KEY (`LostAndFoundID`),
  KEY `HotelID` (`HotelID`),
  CONSTRAINT `lostandfound_ibfk_1` FOREIGN KEY (`HotelID`) REFERENCES `hotel` (`HotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lostandfound`
--

LOCK TABLES `lostandfound` WRITE;
/*!40000 ALTER TABLE `lostandfound` DISABLE KEYS */;
/*!40000 ALTER TABLE `lostandfound` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menuitem`
--

DROP TABLE IF EXISTS `menuitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menuitem` (
  `ItemID` int NOT NULL,
  `ItemName` varchar(255) DEFAULT NULL,
  `Description` text,
  `Price` decimal(10,2) DEFAULT NULL,
  `RestaurantID` int DEFAULT NULL,
  `HotelID` int DEFAULT NULL,
  PRIMARY KEY (`ItemID`),
  KEY `RestaurantID` (`RestaurantID`),
  KEY `HotelID` (`HotelID`),
  CONSTRAINT `menuitem_ibfk_1` FOREIGN KEY (`RestaurantID`) REFERENCES `restaurant` (`RestaurantID`),
  CONSTRAINT `menuitem_ibfk_2` FOREIGN KEY (`HotelID`) REFERENCES `hotel` (`HotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menuitem`
--

LOCK TABLES `menuitem` WRITE;
/*!40000 ALTER TABLE `menuitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `menuitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paymentmethod`
--

DROP TABLE IF EXISTS `paymentmethod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paymentmethod` (
  `PaymentID` int NOT NULL,
  `PaymentDate` date DEFAULT NULL,
  `PaymentMethod` varchar(50) DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL,
  `BillingID` int DEFAULT NULL,
  PRIMARY KEY (`PaymentID`),
  KEY `BillingID` (`BillingID`),
  CONSTRAINT `paymentmethod_ibfk_1` FOREIGN KEY (`BillingID`) REFERENCES `billing` (`BillingID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paymentmethod`
--

LOCK TABLES `paymentmethod` WRITE;
/*!40000 ALTER TABLE `paymentmethod` DISABLE KEYS */;
/*!40000 ALTER TABLE `paymentmethod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotion`
--

DROP TABLE IF EXISTS `promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotion` (
  `PromotionID` int NOT NULL,
  `PromoCode` varchar(50) DEFAULT NULL,
  `ValidityDate` date DEFAULT NULL,
  `Description` text,
  `HotelID` int DEFAULT NULL,
  PRIMARY KEY (`PromotionID`),
  KEY `HotelID` (`HotelID`),
  CONSTRAINT `promotion_ibfk_1` FOREIGN KEY (`HotelID`) REFERENCES `hotel` (`HotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotion`
--

LOCK TABLES `promotion` WRITE;
/*!40000 ALTER TABLE `promotion` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rating` (
  `RatingID` int NOT NULL,
  `RatingValue` int DEFAULT NULL,
  `Review` text,
  `HotelID` int DEFAULT NULL,
  `GuestID` int DEFAULT NULL,
  PRIMARY KEY (`RatingID`),
  KEY `HotelID` (`HotelID`),
  KEY `GuestID` (`GuestID`),
  CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`HotelID`) REFERENCES `hotel` (`HotelID`),
  CONSTRAINT `rating_ibfk_2` FOREIGN KEY (`GuestID`) REFERENCES `customer` (`GuestID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating`
--

LOCK TABLES `rating` WRITE;
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;
/*!40000 ALTER TABLE `rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `ReservationID` int NOT NULL,
  `CheckInDate` date DEFAULT NULL,
  `CheckOutDate` date DEFAULT NULL,
  `NumberOfAdults` int DEFAULT NULL,
  `NumberOfChildren` int DEFAULT NULL,
  `SpecialRequests` text,
  `Status` varchar(20) DEFAULT NULL,
  `RoomNumber` int DEFAULT NULL,
  `GuestID` int DEFAULT NULL,
  `BillingID` int DEFAULT NULL,
  `PromotionID` int DEFAULT NULL,
  PRIMARY KEY (`ReservationID`),
  KEY `RoomNumber` (`RoomNumber`),
  KEY `GuestID` (`GuestID`),
  KEY `BillingID` (`BillingID`),
  KEY `PromotionID` (`PromotionID`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`RoomNumber`) REFERENCES `room` (`RoomNumber`),
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`GuestID`) REFERENCES `customer` (`GuestID`),
  CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`BillingID`) REFERENCES `billing` (`BillingID`),
  CONSTRAINT `reservation_ibfk_4` FOREIGN KEY (`PromotionID`) REFERENCES `promotion` (`PromotionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant` (
  `RestaurantID` int NOT NULL,
  `RestaurantName` varchar(255) DEFAULT NULL,
  `Location` varchar(255) DEFAULT NULL,
  `Description` text,
  `HotelID` int DEFAULT NULL,
  PRIMARY KEY (`RestaurantID`),
  KEY `HotelID` (`HotelID`),
  CONSTRAINT `restaurant_ibfk_1` FOREIGN KEY (`HotelID`) REFERENCES `hotel` (`HotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `RoomNumber` int NOT NULL,
  `RoomType` varchar(50) DEFAULT NULL,
  `BedType` varchar(50) DEFAULT NULL,
  `RatePerNight` decimal(10,2) DEFAULT NULL,
  `AvailabilityStatus` varchar(20) DEFAULT NULL,
  `Description` text,
  `HotelID` int DEFAULT NULL,
  PRIMARY KEY (`RoomNumber`),
  KEY `HotelID` (`HotelID`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`HotelID`) REFERENCES `hotel` (`HotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `securitycamera`
--

DROP TABLE IF EXISTS `securitycamera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `securitycamera` (
  `CameraID` int NOT NULL,
  `Location` varchar(255) DEFAULT NULL,
  `CameraType` varchar(50) DEFAULT NULL,
  `Description` text,
  `HotelID` int DEFAULT NULL,
  PRIMARY KEY (`CameraID`),
  KEY `HotelID` (`HotelID`),
  CONSTRAINT `securitycamera_ibfk_1` FOREIGN KEY (`HotelID`) REFERENCES `hotel` (`HotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `securitycamera`
--

LOCK TABLES `securitycamera` WRITE;
/*!40000 ALTER TABLE `securitycamera` DISABLE KEYS */;
/*!40000 ALTER TABLE `securitycamera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `SupplierID` int NOT NULL,
  `SupplierName` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `PhoneNumber` varchar(20) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SupplierID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transportationtype`
--

DROP TABLE IF EXISTS `transportationtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transportationtype` (
  `VehicleID` int NOT NULL,
  `TypeName` varchar(50) DEFAULT NULL,
  `Number` int DEFAULT NULL,
  `NumberOfSeating` int DEFAULT NULL,
  `HotelID` int DEFAULT NULL,
  PRIMARY KEY (`VehicleID`),
  KEY `HotelID` (`HotelID`),
  CONSTRAINT `transportationtype_ibfk_1` FOREIGN KEY (`HotelID`) REFERENCES `hotel` (`HotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transportationtype`
--

LOCK TABLES `transportationtype` WRITE;
/*!40000 ALTER TABLE `transportationtype` DISABLE KEYS */;
/*!40000 ALTER TABLE `transportationtype` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-02 23:10:14
