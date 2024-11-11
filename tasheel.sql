-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 11, 2024 at 08:10 AM
-- Server version: 8.3.0
-- PHP Version: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tasheel`
--

-- --------------------------------------------------------

--
-- Table structure for table `ai_insights_logs`
--

DROP TABLE IF EXISTS `ai_insights_logs`;
CREATE TABLE IF NOT EXISTS `ai_insights_logs` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `task_id` int DEFAULT NULL,
  `worker_id` int DEFAULT NULL,
  `client_id` int DEFAULT NULL,
  `anomaly_detected` tinyint(1) DEFAULT '0',
  `issue_type` varchar(255) DEFAULT NULL,
  `detected_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `resolution_status` enum('pending','resolved') DEFAULT 'pending',
  PRIMARY KEY (`log_id`),
  KEY `task_id` (`task_id`),
  KEY `worker_id` (`worker_id`),
  KEY `client_id` (`client_id`)
) ENGINE=MyISAM DEFAULT CHARSET=armscii8;

-- --------------------------------------------------------

--
-- Table structure for table `contracts`
--

DROP TABLE IF EXISTS `contracts`;
CREATE TABLE IF NOT EXISTS `contracts` (
  `contract_id` int NOT NULL AUTO_INCREMENT,
  `client_id` int DEFAULT NULL,
  `worker_id` int DEFAULT NULL,
  `service_id` int DEFAULT NULL,
  `contract_terms` text,
  `status` enum('active','completed','terminated') DEFAULT 'active',
  `signed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`contract_id`),
  KEY `client_id` (`client_id`),
  KEY `worker_id` (`worker_id`),
  KEY `service_id` (`service_id`)
) ENGINE=MyISAM DEFAULT CHARSET=armscii8;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `task_id` int DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `payment_method` enum('credit_card','paypal','bank_transfer') DEFAULT NULL,
  `payment_status` enum('pending','completed','failed') DEFAULT NULL,
  `fraud_detected` tinyint(1) DEFAULT '0',
  `transaction_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`),
  KEY `task_id` (`task_id`)
) ENGINE=MyISAM DEFAULT CHARSET=armscii8;

-- --------------------------------------------------------

--
-- Table structure for table `ratings_feedback`
--

DROP TABLE IF EXISTS `ratings_feedback`;
CREATE TABLE IF NOT EXISTS `ratings_feedback` (
  `rating_id` int NOT NULL AUTO_INCREMENT,
  `task_id` int DEFAULT NULL,
  `client_id` int DEFAULT NULL,
  `worker_id` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `sentiment_analysis_result` varchar(255) DEFAULT NULL,
  `feedback_text` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rating_id`),
  KEY `task_id` (`task_id`),
  KEY `client_id` (`client_id`),
  KEY `worker_id` (`worker_id`)
) ;

-- --------------------------------------------------------

--
-- Table structure for table `recommendations`
--

DROP TABLE IF EXISTS `recommendations`;
CREATE TABLE IF NOT EXISTS `recommendations` (
  `recommendation_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `recommended_service_id` int DEFAULT NULL,
  `recommendation_reason` text,
  `recommendation_score` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`recommendation_id`),
  KEY `user_id` (`user_id`),
  KEY `recommended_service_id` (`recommended_service_id`)
) ENGINE=MyISAM DEFAULT CHARSET=armscii8;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
CREATE TABLE IF NOT EXISTS `services` (
  `service_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `category_id` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `estimated_time` int DEFAULT NULL,
  `status` enum('active','inactive','pending') DEFAULT 'active',
  PRIMARY KEY (`service_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=armscii8;

-- --------------------------------------------------------

--
-- Table structure for table `service_categories`
--

DROP TABLE IF EXISTS `service_categories`;
CREATE TABLE IF NOT EXISTS `service_categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=armscii8;

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

DROP TABLE IF EXISTS `support_tickets`;
CREATE TABLE IF NOT EXISTS `support_tickets` (
  `ticket_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `issue_category` enum('technical','payment','service_quality','other') DEFAULT NULL,
  `issue_description` text,
  `status` enum('open','in_progress','resolved','closed') DEFAULT 'open',
  `priority` enum('low','medium','high') DEFAULT 'medium',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `resolved_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ticket_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=armscii8;

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE IF NOT EXISTS `tasks` (
  `task_id` int NOT NULL AUTO_INCREMENT,
  `service_id` int DEFAULT NULL,
  `client_id` int DEFAULT NULL,
  `worker_id` int DEFAULT NULL,
  `status` enum('pending','in_progress','completed','cancelled') DEFAULT 'pending',
  `scheduled_start_time` timestamp NULL DEFAULT NULL,
  `actual_start_time` timestamp NULL DEFAULT NULL,
  `estimated_duration` int DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `progress` text,
  `task_summary` text,
  `payment_status` enum('pending','paid','failed') DEFAULT 'pending',
  PRIMARY KEY (`task_id`),
  KEY `service_id` (`service_id`),
  KEY `client_id` (`client_id`),
  KEY `worker_id` (`worker_id`)
) ENGINE=MyISAM DEFAULT CHARSET=armscii8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `user_role` enum('client','worker','admin') NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `registration_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` timestamp NULL DEFAULT NULL,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=armscii8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
