-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server Version:               10.4.17-MariaDB - mariadb.org binary distribution
-- Server Betriebssystem:        Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Exportiere Datenbank Struktur für webspace
CREATE DATABASE IF NOT EXISTS `webspace` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `webspace`;

-- Exportiere Struktur von Tabelle webspace.changelog
CREATE TABLE IF NOT EXISTS `changelog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `headline` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `old_version` varchar(10) NOT NULL,
  `new_version` varchar(10) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle webspace.changelog: ~3 rows (ungefähr)
/*!40000 ALTER TABLE `changelog` DISABLE KEYS */;
INSERT INTO `changelog` (`id`, `headline`, `description`, `old_version`, `new_version`, `timestamp`) VALUES
	(1, 'Erster Changelog Eintrag', 'Dies ist der erste Changelog Eintrag für diese Webseite. Es werden weitere folgen, wenn es Neuerungen gibt', 'v0.0.0', 'v0.1.0', '2021-03-21 20:41:47'),
	(5, 'awd', 'awd', 'awd', 'awd', '2021-06-15 17:11:23'),
	(6, 'awd11', 'awd1', 'awd1', 'awd1', '2021-06-15 17:12:01');
/*!40000 ALTER TABLE `changelog` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle webspace.github_repos_documentation
CREATE TABLE IF NOT EXISTS `github_repos_documentation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `github_id` int(11) NOT NULL,
  `creater_user_id` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Exportiere Daten aus Tabelle webspace.github_repos_documentation: ~2 rows (ungefähr)
/*!40000 ALTER TABLE `github_repos_documentation` DISABLE KEYS */;
INSERT INTO `github_repos_documentation` (`id`, `github_id`, `creater_user_id`, `message`, `timestamp`) VALUES
	(1, 190927017, '1', 'Test EIntrag #1', '2021-03-22 21:30:30'),
	(2, 190927017, '1', 'Test Eintrag #2', '2021-03-22 21:30:40');
/*!40000 ALTER TABLE `github_repos_documentation` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle webspace.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_name` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `Schlüssel 2` (`permission_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle webspace.permissions: ~0 rows (ungefähr)
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` (`id`, `permission_name`, `timestamp`) VALUES
	(1, 'admin', '2021-04-14 19:33:21');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle webspace.techs_sub
CREATE TABLE IF NOT EXISTS `techs_sub` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parrent_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle webspace.techs_sub: ~6 rows (ungefähr)
/*!40000 ALTER TABLE `techs_sub` DISABLE KEYS */;
INSERT INTO `techs_sub` (`id`, `parrent_id`, `name`, `timestamp`) VALUES
	(3, 5, 'Plain JavaScript', '2021-03-21 17:42:41'),
	(4, 5, 'ReactJs', '2021-03-21 17:42:51'),
	(5, 5, 'ExpressJs', '2021-03-21 17:42:51'),
	(6, 9, 'CSS', '2021-03-21 17:43:06'),
	(7, 9, 'Less', '2021-03-21 17:43:10'),
	(8, 4, 'MariaDB', '2021-03-21 17:43:45');
/*!40000 ALTER TABLE `techs_sub` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle webspace.techs_title
CREATE TABLE IF NOT EXISTS `techs_title` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle webspace.techs_title: ~6 rows (ungefähr)
/*!40000 ALTER TABLE `techs_title` DISABLE KEYS */;
INSERT INTO `techs_title` (`id`, `name`, `timestamp`) VALUES
	(1, 'PHP', '2021-03-20 18:38:19'),
	(2, 'Java', '2021-03-20 18:38:35'),
	(3, 'C++', '2021-03-20 18:38:40'),
	(4, 'SQL', '2021-03-20 18:38:45'),
	(5, 'JavaScript', '2021-03-20 18:53:04'),
	(9, 'CSS', '2021-03-20 19:01:33');
/*!40000 ALTER TABLE `techs_title` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle webspace.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` varchar(100) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `admin` int(11) NOT NULL DEFAULT 0,
  `create_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportiere Daten aus Tabelle webspace.user: ~0 rows (ungefähr)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `username`, `password`, `email`, `admin`, `create_time`) VALUES
	('b4ncd1Q0HBWLlah1pRjm0yGue', 'eike', '$2a$10$8pc.GNZDzQdlFACqsEdPG.i9wyLQ.gSEWcN6KvDVAiUlvCc6ReKBm', 'contact@eikewientjes.de', 1, '2021-02-09 21:09:05');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle webspace.user_permissions
CREATE TABLE IF NOT EXISTS `user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_id` int(11) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Schlüssel 2` (`permission_id`,`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle webspace.user_permissions: ~0 rows (ungefähr)
/*!40000 ALTER TABLE `user_permissions` DISABLE KEYS */;
INSERT INTO `user_permissions` (`id`, `permission_id`, `user_id`) VALUES
	(1, 1, 'b4ncd1Q0HBWLlah1pRjm0yGue');
/*!40000 ALTER TABLE `user_permissions` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle webspace.user_token
CREATE TABLE IF NOT EXISTS `user_token` (
  `user_id` varchar(50) NOT NULL,
  `token` varchar(100) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `Schlüssel 2` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle webspace.user_token: ~1 rows (ungefähr)
/*!40000 ALTER TABLE `user_token` DISABLE KEYS */;
INSERT INTO `user_token` (`user_id`, `token`, `timestamp`) VALUES
	('b4ncd1Q0HBWLlah1pRjm0yGue', 'qBwpDNUgpYoAdKUbOcizmQHQLFVCrLDSwemDSMXYCONJljScVsrGyelqreSjjfAW', '2021-04-13 14:32:00');
/*!40000 ALTER TABLE `user_token` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
