-- --------------------------------------------------------
-- —ервер:                       127.0.0.1
-- ¬ерс≥€ сервера:               5.5.33-log - MySQL Community Server (GPL)
-- ќ— сервера:                   Win32
-- HeidiSQL ¬ерс≥€:              8.3.0.4694
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for time_quest
CREATE DATABASE IF NOT EXISTS `time_quest` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
USE `time_quest`;


-- Dumping structure for таблиц€ time_quest.locale
DROP TABLE IF EXISTS `locale`;
CREATE TABLE IF NOT EXISTS `locale` (
  `key` varchar(200) COLLATE utf8_bin NOT NULL,
  `value` varchar(1000) COLLATE utf8_bin NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table time_quest.locale: 9 rows
DELETE FROM `locale`;
/*!40000 ALTER TABLE `locale` DISABLE KEYS */;
INSERT INTO `locale` (`key`, `value`) VALUES
	('app.base.title', 'TimeQuest у м≥ст≥ ¬≥нниц€'),
	('app.navigation.team', '¬аша команда'),
	('app.base.loading', '«ачекайте будь-ласка...'),
	('app.create_team_btn', '—творити нову команду'),
	('app.users.invites.title', '«апрошенн€ в команду'),
	('app.users.invites.empty_text', '¬ас ще не запрошували н≥ в одну команду...'),
	('app.invites.columns.team', ' оманда'),
	('app.invites.columns.author', 'јвтор запрошенн€'),
	('app.invites.columns.time', 'ƒата запрошенн€');
/*!40000 ALTER TABLE `locale` ENABLE KEYS */;


-- Dumping structure for таблиц€ time_quest.quests
DROP TABLE IF EXISTS `quests`;
CREATE TABLE IF NOT EXISTS `quests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET latin1 NOT NULL,
  `description` text CHARACTER SET latin1 NOT NULL,
  `picture` varchar(200) CHARACTER SET latin1 NOT NULL,
  `time_start` bigint(20) NOT NULL,
  `time_continue` bigint(20) NOT NULL,
  `statistic_open` tinyint(4) NOT NULL DEFAULT '0',
  `finish_text` text CHARACTER SET latin1 NOT NULL,
  `status` enum('OPEN','IN_PROGRESS','FINISHED','CLOSED','HIDDEN') CHARACTER SET latin1 NOT NULL DEFAULT 'OPEN',
  `price` int(11) NOT NULL,
  `task_sequence` enum('LINEAR','TIMER') CHARACTER SET latin1 NOT NULL DEFAULT 'LINEAR',
  `show_scenario` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table time_quest.quests: 0 rows
DELETE FROM `quests`;
/*!40000 ALTER TABLE `quests` DISABLE KEYS */;
/*!40000 ALTER TABLE `quests` ENABLE KEYS */;


-- Dumping structure for таблиц€ time_quest.quests_aud
DROP TABLE IF EXISTS `quests_aud`;
CREATE TABLE IF NOT EXISTS `quests_aud` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_author` int(11) NOT NULL,
  `id_quest` int(11) NOT NULL,
  `execution_time` bigint(20) NOT NULL,
  `action` varchar(100) CHARACTER SET latin1 NOT NULL,
  `oldValue` varchar(200) CHARACTER SET latin1 NOT NULL,
  `newValue` varchar(200) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table time_quest.quests_aud: 0 rows
DELETE FROM `quests_aud`;
/*!40000 ALTER TABLE `quests_aud` DISABLE KEYS */;
/*!40000 ALTER TABLE `quests_aud` ENABLE KEYS */;


-- Dumping structure for таблиц€ time_quest.quests_authors
DROP TABLE IF EXISTS `quests_authors`;
CREATE TABLE IF NOT EXISTS `quests_authors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_quest` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table time_quest.quests_authors: 0 rows
DELETE FROM `quests_authors`;
/*!40000 ALTER TABLE `quests_authors` DISABLE KEYS */;
/*!40000 ALTER TABLE `quests_authors` ENABLE KEYS */;


-- Dumping structure for таблиц€ time_quest.tasks
DROP TABLE IF EXISTS `tasks`;
CREATE TABLE IF NOT EXISTS `tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_quest` int(11) NOT NULL,
  `task_name` varchar(100) CHARACTER SET latin1 NOT NULL,
  `index` int(11) NOT NULL,
  `auto_cancel_time` int(11) NOT NULL,
  `answer_visible` tinyint(4) NOT NULL DEFAULT '0',
  `wrong_answer_time` int(11) NOT NULL,
  `count_objects` int(11) NOT NULL,
  `count_answers` int(11) NOT NULL,
  `needed_count_answers` int(11) NOT NULL,
  `type_signal` varchar(100) CHARACTER SET latin1 NOT NULL,
  `type_marker` varchar(100) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table time_quest.tasks: 0 rows
DELETE FROM `tasks`;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;


-- Dumping structure for таблиц€ time_quest.tasks_answers
DROP TABLE IF EXISTS `tasks_answers`;
CREATE TABLE IF NOT EXISTS `tasks_answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_task` int(11) NOT NULL,
  `value` varchar(100) CHARACTER SET latin1 NOT NULL,
  `index` int(11) NOT NULL,
  `bonus_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table time_quest.tasks_answers: 0 rows
DELETE FROM `tasks_answers`;
/*!40000 ALTER TABLE `tasks_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks_answers` ENABLE KEYS */;


-- Dumping structure for таблиц€ time_quest.tasks_bonuses
DROP TABLE IF EXISTS `tasks_bonuses`;
CREATE TABLE IF NOT EXISTS `tasks_bonuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_team_vs_task` int(11) NOT NULL,
  `bonus_time` int(11) NOT NULL,
  `description` text CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table time_quest.tasks_bonuses: 0 rows
DELETE FROM `tasks_bonuses`;
/*!40000 ALTER TABLE `tasks_bonuses` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks_bonuses` ENABLE KEYS */;


-- Dumping structure for таблиц€ time_quest.tasks_help
DROP TABLE IF EXISTS `tasks_help`;
CREATE TABLE IF NOT EXISTS `tasks_help` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_task` int(11) NOT NULL,
  `index` int(11) NOT NULL,
  `help_time` int(11) NOT NULL,
  `text` text CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table time_quest.tasks_help: 0 rows
DELETE FROM `tasks_help`;
/*!40000 ALTER TABLE `tasks_help` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks_help` ENABLE KEYS */;


-- Dumping structure for таблиц€ time_quest.teams
DROP TABLE IF EXISTS `teams`;
CREATE TABLE IF NOT EXISTS `teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `status` enum('ACTIVE','REMOVED') CHARACTER SET utf8 NOT NULL DEFAULT 'ACTIVE',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table time_quest.teams: 1 rows
DELETE FROM `teams`;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
INSERT INTO `teams` (`id`, `name`, `status`) VALUES
	(1, ' иѕиЎ', 'ACTIVE');
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;


-- Dumping structure for таблиц€ time_quest.teams_aud
DROP TABLE IF EXISTS `teams_aud`;
CREATE TABLE IF NOT EXISTS `teams_aud` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_team` int(11) NOT NULL,
  `id_author` int(11) NOT NULL,
  `execution_time` bigint(20) NOT NULL,
  `action` varchar(100) CHARACTER SET latin1 NOT NULL,
  `oldValue` varchar(100) CHARACTER SET latin1 NOT NULL,
  `newValue` varchar(100) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table time_quest.teams_aud: 0 rows
DELETE FROM `teams_aud`;
/*!40000 ALTER TABLE `teams_aud` DISABLE KEYS */;
/*!40000 ALTER TABLE `teams_aud` ENABLE KEYS */;


-- Dumping structure for таблиц€ time_quest.teams_in_quest
DROP TABLE IF EXISTS `teams_in_quest`;
CREATE TABLE IF NOT EXISTS `teams_in_quest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_team` int(11) NOT NULL,
  `id_quest` int(11) NOT NULL,
  `status` enum('IN_PROGRESS','ACCEPTED','DECLINED') CHARACTER SET latin1 NOT NULL DEFAULT 'IN_PROGRESS',
  `status_in_quest` enum('IN_PROGRESS','BEFORE','AFTER') CHARACTER SET latin1 NOT NULL DEFAULT 'BEFORE',
  `current_help_index` int(11) NOT NULL,
  `current_task_index` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table time_quest.teams_in_quest: 0 rows
DELETE FROM `teams_in_quest`;
/*!40000 ALTER TABLE `teams_in_quest` DISABLE KEYS */;
/*!40000 ALTER TABLE `teams_in_quest` ENABLE KEYS */;


-- Dumping structure for таблиц€ time_quest.team_vs_tasks
DROP TABLE IF EXISTS `team_vs_tasks`;
CREATE TABLE IF NOT EXISTS `team_vs_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_team` int(11) NOT NULL,
  `id_task` int(11) NOT NULL,
  `real_start_time` bigint(20) NOT NULL,
  `real_end_time` bigint(20) NOT NULL,
  `block_cancel_time` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table time_quest.team_vs_tasks: 0 rows
DELETE FROM `team_vs_tasks`;
/*!40000 ALTER TABLE `team_vs_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `team_vs_tasks` ENABLE KEYS */;


-- Dumping structure for таблиц€ time_quest.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `uid` varchar(50) CHARACTER SET latin1 NOT NULL,
  `photo` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `identity` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `first_name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `last_name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `profile` varchar(100) CHARACTER SET latin1 NOT NULL,
  `network` varchar(100) CHARACTER SET latin1 NOT NULL,
  `type` enum('SUPERADMIN','ADMIN','MODERATOR','USER') CHARACTER SET latin1 NOT NULL DEFAULT 'USER',
  `createdTime` bigint(20) NOT NULL,
  `lastLoggedBy` bigint(20) DEFAULT NULL,
  `phone` bigint(20) DEFAULT NULL,
  `email` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  UNIQUE KEY `≤ндекс 1` (`uid`,`network`)
) ENGINE=MyISAM DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;

-- Dumping data for table time_quest.users: 3 rows
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`uid`, `photo`, `identity`, `first_name`, `last_name`, `profile`, `network`, `type`, `createdTime`, `lastLoggedBy`, `phone`, `email`) VALUES
	('19738019', 'http://cs629425.vk.me/v629425019/27ce2/3a1w5ChumCA.jpg', 'http://vk.com/id19738019', 'ярослав', '“оченюк', 'http://vk.com/id19738019', 'vkontakte', 'USER', 1458743898, 1459255292, NULL, 'yarvasa@gmail.com'),
	('1140573765994208', 'http://graph.facebook.com/1140573765994208/picture?type=square', 'https://www.facebook.com/app_scoped_user_id/1140573765994208/', 'ярослав', '“оченюк', 'https://www.facebook.com/app_scoped_user_id/1140573765994208/', 'facebook', 'USER', 1458745327, 1458745327, NULL, 'yarvasa@gmail.com'),
	('111010174198225314829', 'https://lh3.googleusercontent.com/-Ke3B8wcxFzw/AAAAAAAAAAI/AAAAAAAABlA/GeKBdQ8aI4Q/photo.jpg?sz=100', 'https://plus.google.com/u/0/111010174198225314829/', 'ярослав', '“оченюк', 'https://plus.google.com/111010174198225314829', 'google', 'USER', 1458760542, 1458760542, NULL, 'yarvasa@gmail.com');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


-- Dumping structure for таблиц€ time_quest.users_answers
DROP TABLE IF EXISTS `users_answers`;
CREATE TABLE IF NOT EXISTS `users_answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_team_vs_task` int(11) NOT NULL,
  `input_time` bigint(20) NOT NULL,
  `value` varchar(100) NOT NULL DEFAULT '',
  `isValid` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table time_quest.users_answers: 0 rows
DELETE FROM `users_answers`;
/*!40000 ALTER TABLE `users_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_answers` ENABLE KEYS */;


-- Dumping structure for таблиц€ time_quest.users_aud
DROP TABLE IF EXISTS `users_aud`;
CREATE TABLE IF NOT EXISTS `users_aud` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_author` int(11) NOT NULL,
  `execution_time` bigint(20) NOT NULL,
  `action` varchar(100) NOT NULL,
  `oldValue` varchar(100) NOT NULL,
  `newValue` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table time_quest.users_aud: 0 rows
DELETE FROM `users_aud`;
/*!40000 ALTER TABLE `users_aud` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_aud` ENABLE KEYS */;


-- Dumping structure for таблиц€ time_quest.users_history
DROP TABLE IF EXISTS `users_history`;
CREATE TABLE IF NOT EXISTS `users_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) DEFAULT NULL,
  `loginTime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table time_quest.users_history: 25 rows
DELETE FROM `users_history`;
/*!40000 ALTER TABLE `users_history` DISABLE KEYS */;
INSERT INTO `users_history` (`id`, `id_user`, `loginTime`) VALUES
	(1, 19738019, 1458744265),
	(2, 19738019, 1458744345),
	(3, 19738019, 1458744347),
	(4, 19738019, 1458744409),
	(5, 19738019, 1458744481),
	(6, 19738019, 1458744484),
	(7, 19738019, 1458744497),
	(8, 19738019, 1458744871),
	(9, 19738019, 1458745127),
	(10, 19738019, 1458745288),
	(11, 19738019, 1458745311),
	(12, 19738019, 1458745373),
	(13, 19738019, 1458745384),
	(14, 19738019, 1458748233),
	(15, 19738019, 1458748261),
	(16, 19738019, 1458749079),
	(17, 19738019, 1458749087),
	(18, 19738019, 1458750882),
	(19, 19738019, 1458755726),
	(20, 19738019, 1458756502),
	(21, 19738019, 1458756640),
	(22, 19738019, 1458806525),
	(23, 19738019, 1458824809),
	(24, 19738019, 1459252611),
	(25, 19738019, 1459255292);
/*!40000 ALTER TABLE `users_history` ENABLE KEYS */;


-- Dumping structure for таблиц€ time_quest.users_invites
DROP TABLE IF EXISTS `users_invites`;
CREATE TABLE IF NOT EXISTS `users_invites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_team` int(11) NOT NULL,
  `id_author` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `status` enum('ACCEPTED','DECLINED','CANCELED','IN_PROGRESS') CHARACTER SET latin1 NOT NULL DEFAULT 'IN_PROGRESS',
  `request_time` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table time_quest.users_invites: 0 rows
DELETE FROM `users_invites`;
/*!40000 ALTER TABLE `users_invites` DISABLE KEYS */;
INSERT INTO `users_invites` (`id`, `id_team`, `id_author`, `id_user`, `status`, `request_time`) VALUES
	(1, 1, 19738019, 19738019, 'IN_PROGRESS', 1459262445054);
/*!40000 ALTER TABLE `users_invites` ENABLE KEYS */;


-- Dumping structure for таблиц€ time_quest.users_in_team
DROP TABLE IF EXISTS `users_in_team`;
CREATE TABLE IF NOT EXISTS `users_in_team` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_team` int(11) NOT NULL,
  `status` enum('CAPTAIN','KERNEL','HUMAN') NOT NULL DEFAULT 'HUMAN',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table time_quest.users_in_team: 0 rows
DELETE FROM `users_in_team`;
/*!40000 ALTER TABLE `users_in_team` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_in_team` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
