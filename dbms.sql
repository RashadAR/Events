-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cems`
--

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `event_id` int(11) NOT NULL,
  `event_title` varchar(50) NOT NULL,
  `event_price` int(11) DEFAULT NULL,
  `participents` int(11) DEFAULT 0,
  `img_link` text DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`event_id`, `event_title`, `event_price`, `participents`, `img_link`, `type_id`) VALUES
(1, 'Cryptohunt', 100, 0, 'images/crypto.png', 1),
(2, 'Search-it', 50, 2, 'images/cs03.jpg', 1),
(3, 'Technical-Quiz', 50, 2, 'images/quiz.png', 1),
(4, 'Competitive-Coding', 50, 1, 'images/coding.jpg', 1),
(5, 'Pubg', 50, 1, 'images/pubg.jpg', 2),
(6, 'Counter-Strike', 100, 1, 'images/counter.jpg', 2),
(7, 'Fashion-Show', 200, 1, 'images/onstage.jpg', 3);

-- --------------------------------------------------------

--
-- Table structure for table `event_info`
--

CREATE TABLE `event_info` (
  `event_id` int(10) NOT NULL,
  `Date` date DEFAULT NULL,
  `time` varchar(20) NOT NULL,
  `location` varchar(300) NOT NULL,
  PRIMARY KEY (`event_id`),
  CONSTRAINT `fk_event_info_event_id` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `event_info`
--

INSERT INTO `event_info` (`event_id`, `Date`, `time`, `location`) VALUES
(1, '2022-11-16', '3.00pm', '135 Room'),
(2, '2022-11-16', '1.00pm', '020 Lab'),
(3, '2022-11-16', '11.00am', '136 Room'),
(4, '2022-11-16', '9.30am', '020 Lab'),
(5, '2022-10-17', '10.00am', '121 Lab'),
(6, '2022-10-17', '11.00am', '122 Lab'),
(7, '2022-10-17', '9.30pm', 'ON Stage');

-- --------------------------------------------------------

--
-- Table structure for table `event_type`
--

CREATE TABLE `event_type` (
  `type_id` int(10) NOT NULL,
  `type_title` text NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `event_type`
--

INSERT INTO `event_type` (`type_id`, `type_title`) VALUES
(1, 'Technical Events'),
(2, 'Gaming Events'),
(3, 'On Stage Events'),
(4, 'Off Stage Events');

-- --------------------------------------------------------

--
-- Table structure for table `participent`
--

CREATE TABLE `participent` (
  `usn` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `branch` varchar(11) NOT NULL,
  `sem` int(11) NOT NULL,
  `email` varchar(300) NOT NULL,
  `phone` varchar(12) NOT NULL,
  `college` varchar(20) NOT NULL,
  PRIMARY KEY (`usn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `participent`
--

INSERT INTO `participent` (`usn`, `name`, `branch`, `sem`, `email`, `phone`, `college`) VALUES
('4PA21CS061', 'Hisham', 'CSE', 5, 'hisham@gmail.com', '8123300011', 'PA'),
('4PA21CS062', 'Raaz', 'cse', 5, 'raaz@GMAIL.COM', '9934736623', 'PA'),
('4PA21CS063', 'Nihal', 'cse', 5, 'nihal@gmail.com', '7888387323', 'PA'),
('4PA21CS064', 'Luqman', 'ISE', 5, 'luqman@gmail.com', '8998848488', 'PA');

-- --------------------------------------------------------

--
-- Table structure for table `registered`
--

CREATE TABLE `registered` (
  `rid` int(11) NOT NULL AUTO_INCREMENT,
  `usn` varchar(20) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`rid`),
  CONSTRAINT `fk_registered_event_id` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `registered`
--

INSERT INTO `registered` (`usn`, `event_id`) VALUES
('4PA21CS061', 2),
('4PA21CS062', 4),
('4PA21CS063', 2),
('4PA21CS061', 3),
('4PA21CS062', 3),
('4PA21CS062', 5),
('4PA21CS061', 6),
('4PA21CS063', 7);

-- --------------------------------------------------------

--
-- Table structure for table `staff_coordinator
--


CREATE TABLE `staff_coordinator` (
  `stid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`stid`),
  CONSTRAINT `fk_staff_coordinator_event_id` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `staff_coordinator`
--

INSERT INTO `staff_coordinator` (`name`, `phone`, `event_id`) VALUES
('John', '9956436610', 1),
('Bob', '9956436123', 2),
('Allen', '9956436456', 3),
('Smith', '9956436789', 4),
('Doe', '9956436101', 5);

-- --------------------------------------------------------

--
-- Table structure for table `student_coordinator`
--

CREATE TABLE `student_coordinator` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `st_name` varchar(100) NOT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`sid`),
  CONSTRAINT `fk_student_coordinator_event_id` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student_coordinator`
--

INSERT INTO `student_coordinator` (`st_name`, `phone`, `event_id`) VALUES
('Prajwal', '6956436610', 1),
('Rakesh', '7956436123', 2),
('Arjun', '8956436456', 3),
('Sanjana', '6956436789', 4),
('NIkhil', '7956436101', 5),
('Rishitha', NULL, 6);

-- --------------------------------------------------------

--
-- Triggers `registered`
--
CREATE TRIGGER `count` AFTER INSERT ON `registered` FOR EACH ROW
UPDATE events
SET events.participents = events.participents + 1
WHERE events.event_id = NEW.event_id;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
