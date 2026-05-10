DROP TABLE IF EXISTS `simple_cms_files`;
CREATE TABLE IF NOT EXISTS `simple_cms_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `file_path` varchar(250) DEFAULT NULL,
  `file_name` varchar(250) DEFAULT NULL,
  `mime_type` varchar(250) DEFAULT NULL,
  `hash` varchar(250) DEFAULT NULL,
  `size` varchar(50) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `status` enum('T','F') DEFAULT 'T',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `simple_cms_sections`;
CREATE TABLE IF NOT EXISTS `simple_cms_sections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(250) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `status` enum('T','F') DEFAULT 'T',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `simple_cms_users_files`;
CREATE TABLE IF NOT EXISTS `simple_cms_users_files` (
  `user_id` int(10) unsigned NOT NULL,
  `file_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`file_id`),
  KEY `user_id` (`user_id`),
  KEY `file_id` (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `simple_cms_users_sections`;
CREATE TABLE IF NOT EXISTS `simple_cms_users_sections` (
  `user_id` int(10) unsigned NOT NULL,
  `section_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`section_id`),
  KEY `user_id` (`user_id`),
  KEY `section_id` (`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `simple_cms_histories`;
CREATE TABLE IF NOT EXISTS `simple_cms_histories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,	
  `user_id` int(10) unsigned NOT NULL,
  `section_id` int(10) unsigned NOT NULL,
  `modified` datetime DEFAULT NULL,
  `ip` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `section_id` (`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `simple_cms_fields`;
CREATE TABLE IF NOT EXISTS `simple_cms_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(100) DEFAULT NULL,
  `type` enum('backend','frontend','arrays') DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `source` enum('script','plugin') DEFAULT 'script',
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `simple_cms_multi_lang`;
CREATE TABLE IF NOT EXISTS `simple_cms_multi_lang` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `foreign_id` int(10) unsigned DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `locale` tinyint(3) unsigned DEFAULT NULL,
  `field` varchar(50) DEFAULT NULL,
  `content` text,
  `source` enum('script','plugin','data') DEFAULT 'script',
  PRIMARY KEY (`id`),
  UNIQUE KEY `foreign_id` (`foreign_id`,`model`,`locale`,`field`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `simple_cms_options`;
CREATE TABLE IF NOT EXISTS `simple_cms_options` (
  `foreign_id` int(10) unsigned NOT NULL DEFAULT '0',
  `key` varchar(255) NOT NULL DEFAULT '',
  `tab_id` tinyint(3) unsigned DEFAULT NULL,
  `value` text,
  `label` text,
  `type` enum('string','text','int','float','enum','bool') NOT NULL DEFAULT 'string',
  `order` int(10) unsigned DEFAULT NULL,
  `is_visible` tinyint(1) unsigned DEFAULT '1',
  `style` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`foreign_id`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `simple_cms_roles`;
CREATE TABLE IF NOT EXISTS `simple_cms_roles` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `role` varchar(255) DEFAULT NULL,
  `status` enum('T','F') NOT NULL DEFAULT 'T',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `simple_cms_users`;
CREATE TABLE IF NOT EXISTS `simple_cms_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` blob,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `file_allow` enum('0','1') DEFAULT '1',
  `section_allow` enum('0','1') DEFAULT '1',
  `created` datetime NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `status` enum('T','F') NOT NULL DEFAULT 'T',
  `is_active` enum('T','F') NOT NULL DEFAULT 'F',
  `ip` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `role_id` (`role_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

INSERT INTO `simple_cms_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(1, 'addLocale', 'backend', 'Add language', 'script', NULL),
(2, 'adminForgot', 'backend', 'Forgot password', 'script', NULL),
(3, 'adminLogin', 'backend', 'Admin Login', 'script', NULL),
(4, 'backend', 'backend', 'Backend titles', 'script', NULL),
(5, 'btnAdd', 'backend', 'Button Add', 'script', NULL),
(6, 'btnBack', 'backend', 'Button Back', 'script', NULL),
(7, 'btnBackup', 'backend', 'Button Backup', 'script', NULL),
(8, 'btnCancel', 'backend', 'Button Cancel', 'script', NULL),
(9, 'btnContinue', 'backend', 'Button Continue', 'script', NULL),
(10, 'btnDelete', 'backend', 'Button Delete', 'script', NULL),
(11, 'btnLogin', 'backend', 'Login', 'script', NULL),
(12, 'btnReset', 'backend', 'Reset', 'script', NULL),
(13, 'btnSave', 'backend', 'Save', 'script', NULL),
(14, 'btnSearch', 'backend', 'Search', 'script', NULL),
(15, 'btnSend', 'backend', 'Button Send', 'script', NULL),
(16, 'btnUpdate', 'backend', 'Update', 'script', NULL),
(17, 'created', 'backend', 'Created', 'script', NULL),
(18, 'email', 'backend', 'E-Mail', 'script', NULL),
(19, 'emailForgotBody', 'backend', 'Email / Forgot Body', 'script', NULL),
(20, 'emailForgotSubject', 'backend', 'Email / Forgot Subject', 'script', NULL),
(21, 'frontend', 'backend', 'Front-end titles', 'script', NULL),
(22, 'gridActionTitle', 'backend', 'Grid / Action Title', 'script', NULL),
(23, 'gridBtnCancel', 'backend', 'Grid / Button Cancel', 'script', NULL),
(24, 'gridBtnDelete', 'backend', 'Grid / Button Delete', 'script', NULL),
(25, 'gridBtnOk', 'backend', 'Grid / Button OK', 'script', NULL),
(26, 'gridChooseAction', 'backend', 'Grid / Choose Action', 'script', NULL),
(27, 'gridConfirmationTitle', 'backend', 'Grid / Confirmation Title', 'script', NULL),
(28, 'gridDeleteConfirmation', 'backend', 'Grid / Delete confirmation', 'script', NULL),
(29, 'gridEmptyResult', 'backend', 'Grid / Empty resultset', 'script', NULL),
(30, 'gridGotoPage', 'backend', 'Grid / Go to page', 'script', NULL),
(31, 'gridItemsPerPage', 'backend', 'Grid / Items per page', 'script', NULL),
(32, 'gridNext', 'backend', 'Grid / Next', 'script', NULL),
(33, 'gridNextPage', 'backend', 'Grid / Next page', 'script', NULL),
(34, 'gridPrev', 'backend', 'Grid / Prev', 'script', NULL),
(35, 'gridPrevPage', 'backend', 'Grid / Prev page', 'script', NULL),
(36, 'gridTotalItems', 'backend', 'Grid / Total items', 'script', NULL),
(55, 'lblAddUser', 'backend', 'Add user', 'script', NULL),
(56, 'lblBackupDatabase', 'backend', 'Backup / Database', 'script', NULL),
(57, 'lblBackupFiles', 'backend', 'Backup / Files', 'script', NULL),
(58, 'lblChoose', 'backend', 'Choose', 'script', NULL),
(59, 'lblDays', 'backend', 'Days', 'script', NULL),
(60, 'lblDelete', 'backend', 'Delete', 'script', NULL),
(61, 'lblError', 'backend', 'Error', 'script', NULL),
(62, 'lblExport', 'backend', 'Export', 'script', NULL),
(63, 'lblForgot', 'backend', 'Forgot password', 'script', NULL),
(64, 'lblIp', 'backend', 'IP address', 'script', NULL),
(65, 'lblIsActive', 'backend', 'Is Active', 'script', NULL),
(66, 'lblName', 'backend', 'Name', 'script', NULL),
(67, 'lblNo', 'backend', 'No', 'script', NULL),
(68, 'lblOption', 'backend', 'Option', 'script', NULL),
(69, 'lblOptionList', 'backend', 'Option list', 'script', NULL),
(70, 'lblRole', 'backend', 'Role', 'script', NULL),
(71, 'lblStatus', 'backend', 'Status', 'script', NULL),
(72, 'lblType', 'backend', 'Type', 'script', NULL),
(73, 'lblUpdateUser', 'backend', 'Update user', 'script', NULL),
(74, 'lblUserCreated', 'backend', 'User / Registration Date & Time', 'script', NULL),
(75, 'lblValue', 'backend', 'Value', 'script', NULL),
(76, 'lblYes', 'backend', 'Yes', 'script', NULL),
(77, 'lnkBack', 'backend', 'Link Back', 'script', NULL),
(78, 'localeArrays', 'backend', 'Locale / Arrays titles', 'script', NULL),
(79, 'locales', 'backend', 'Languages', 'script', NULL),
(80, 'locale_flag', 'backend', 'Locale / Flag', 'script', NULL),
(81, 'locale_is_default', 'backend', 'Locale / Is default', 'script', NULL),
(82, 'locale_order', 'backend', 'Locale / Order', 'script', NULL),
(83, 'locale_title', 'backend', 'Locale / Title', 'script', NULL),
(84, 'menuBackup', 'backend', 'Menu Backup', 'script', NULL),
(85, 'menuDashboard', 'backend', 'Menu Dashboard', 'script', NULL),
(86, 'menuLang', 'backend', 'Menu Multi lang', 'script', NULL),
(87, 'menuLocales', 'backend', 'Menu Languages', 'script', NULL),
(88, 'menuLogout', 'backend', 'Menu Logout', 'script', NULL),
(89, 'menuOptions', 'backend', 'Menu Options', 'script', NULL),
(90, 'menuPlugins', 'backend', 'Menu Plugins', 'script', NULL),
(91, 'menuProfile', 'backend', 'Menu Profile', 'script', NULL),
(92, 'menuUsers', 'backend', 'Menu Users', 'script', NULL),
(93, 'multilangTooltip', 'backend', 'MultiLang / Tooltip', 'script', NULL),
(94, 'opt_o_currency', 'backend', 'Options / Currency', 'script', NULL),
(95, 'opt_o_date_format', 'backend', 'Options / Date format', 'script', NULL),
(96, 'opt_o_send_email', 'backend', 'opt_o_send_email', 'script', NULL),
(97, 'opt_o_smtp_host', 'backend', 'opt_o_smtp_host', 'script', NULL),
(98, 'opt_o_smtp_pass', 'backend', 'opt_o_smtp_pass', 'script', NULL),
(99, 'opt_o_smtp_port', 'backend', 'opt_o_smtp_port', 'script', NULL),
(100, 'opt_o_smtp_user', 'backend', 'opt_o_smtp_user', 'script', NULL),
(101, 'opt_o_timezone', 'backend', 'Options / Timezone', 'script', NULL),
(102, 'opt_o_week_start', 'backend', 'Options / First day of the week', 'script', NULL),
(103, 'pass', 'backend', 'Password', 'script', NULL),
(125, 'revert_status', 'backend', 'Revert status', 'script', NULL),
(126, 'url', 'backend', 'URL', 'script', NULL),
(127, 'user', 'backend', 'Username', 'script', NULL),
(128, 'pj_email_taken', 'backend', 'Users / Email already taken', 'script', NULL),
(129, 'days_ARRAY_0', 'arrays', 'days_ARRAY_0', 'script', NULL),
(130, 'days_ARRAY_1', 'arrays', 'days_ARRAY_1', 'script', NULL),
(131, 'days_ARRAY_2', 'arrays', 'days_ARRAY_2', 'script', NULL),
(132, 'days_ARRAY_3', 'arrays', 'days_ARRAY_3', 'script', NULL),
(133, 'days_ARRAY_4', 'arrays', 'days_ARRAY_4', 'script', NULL),
(134, 'days_ARRAY_5', 'arrays', 'days_ARRAY_5', 'script', NULL),
(135, 'days_ARRAY_6', 'arrays', 'days_ARRAY_6', 'script', NULL),
(136, 'day_names_ARRAY_0', 'arrays', 'day_names_ARRAY_0', 'script', NULL),
(137, 'day_names_ARRAY_1', 'arrays', 'day_names_ARRAY_1', 'script', NULL),
(138, 'day_names_ARRAY_2', 'arrays', 'day_names_ARRAY_2', 'script', NULL),
(139, 'day_names_ARRAY_3', 'arrays', 'day_names_ARRAY_3', 'script', NULL),
(140, 'day_names_ARRAY_4', 'arrays', 'day_names_ARRAY_4', 'script', NULL),
(141, 'day_names_ARRAY_5', 'arrays', 'day_names_ARRAY_5', 'script', NULL),
(142, 'day_names_ARRAY_6', 'arrays', 'day_names_ARRAY_6', 'script', NULL),
(143, 'error_bodies_ARRAY_AA10', 'arrays', 'error_bodies_ARRAY_AA10', 'script', NULL),
(144, 'error_bodies_ARRAY_AA11', 'arrays', 'error_bodies_ARRAY_AA11', 'script', NULL),
(145, 'error_bodies_ARRAY_AA12', 'arrays', 'error_bodies_ARRAY_AA12', 'script', NULL),
(146, 'error_bodies_ARRAY_AA13', 'arrays', 'error_bodies_ARRAY_AA13', 'script', NULL),
(147, 'error_bodies_ARRAY_AB01', 'arrays', 'error_bodies_ARRAY_AB01', 'script', NULL),
(148, 'error_bodies_ARRAY_AB02', 'arrays', 'error_bodies_ARRAY_AB02', 'script', NULL),
(149, 'error_bodies_ARRAY_AB03', 'arrays', 'error_bodies_ARRAY_AB03', 'script', NULL),
(150, 'error_bodies_ARRAY_AB04', 'arrays', 'error_bodies_ARRAY_AB04', 'script', NULL),
(151, 'error_bodies_ARRAY_ALC01', 'arrays', 'error_bodies_ARRAY_ALC01', 'script', NULL),
(152, 'error_bodies_ARRAY_AO01', 'arrays', 'error_bodies_ARRAY_AO01', 'script', NULL),
(153, 'error_bodies_ARRAY_AU01', 'arrays', 'error_bodies_ARRAY_AU01', 'script', NULL),
(154, 'error_bodies_ARRAY_AU03', 'arrays', 'error_bodies_ARRAY_AU03', 'script', NULL),
(155, 'error_bodies_ARRAY_AU04', 'arrays', 'error_bodies_ARRAY_AU04', 'script', NULL),
(156, 'error_bodies_ARRAY_AU08', 'arrays', 'error_bodies_ARRAY_AU08', 'script', NULL),
(159, 'error_titles_ARRAY_AA10', 'arrays', 'error_titles_ARRAY_AA10', 'script', NULL),
(160, 'error_titles_ARRAY_AA11', 'arrays', 'error_titles_ARRAY_AA11', 'script', NULL),
(161, 'error_titles_ARRAY_AA12', 'arrays', 'error_titles_ARRAY_AA12', 'script', NULL),
(162, 'error_titles_ARRAY_AA13', 'arrays', 'error_titles_ARRAY_AA13', 'script', NULL),
(163, 'error_titles_ARRAY_AB01', 'arrays', 'error_titles_ARRAY_AB01', 'script', NULL),
(164, 'error_titles_ARRAY_AB02', 'arrays', 'error_titles_ARRAY_AB02', 'script', NULL),
(165, 'error_titles_ARRAY_AB03', 'arrays', 'error_titles_ARRAY_AB03', 'script', NULL),
(166, 'error_titles_ARRAY_AB04', 'arrays', 'error_titles_ARRAY_AB04', 'script', NULL),
(167, 'error_titles_ARRAY_AO01', 'arrays', 'error_titles_ARRAY_AO01', 'script', NULL),
(168, 'error_titles_ARRAY_AU01', 'arrays', 'error_titles_ARRAY_AU01', 'script', NULL),
(169, 'error_titles_ARRAY_AU03', 'arrays', 'error_titles_ARRAY_AU03', 'script', NULL),
(170, 'error_titles_ARRAY_AU04', 'arrays', 'error_titles_ARRAY_AU04', 'script', NULL),
(171, 'error_titles_ARRAY_AU08', 'arrays', 'error_titles_ARRAY_AU08', 'script', NULL),
(174, 'filter_ARRAY_active', 'arrays', 'filter_ARRAY_active', 'script', NULL),
(175, 'filter_ARRAY_inactive', 'arrays', 'filter_ARRAY_inactive', 'script', NULL),
(176, 'login_err_ARRAY_1', 'arrays', 'login_err_ARRAY_1', 'script', NULL),
(177, 'login_err_ARRAY_2', 'arrays', 'login_err_ARRAY_2', 'script', NULL),
(178, 'login_err_ARRAY_3', 'arrays', 'login_err_ARRAY_3', 'script', NULL),
(179, 'months_ARRAY_1', 'arrays', 'months_ARRAY_1', 'script', NULL),
(180, 'months_ARRAY_10', 'arrays', 'months_ARRAY_10', 'script', NULL),
(181, 'months_ARRAY_11', 'arrays', 'months_ARRAY_11', 'script', NULL),
(182, 'months_ARRAY_12', 'arrays', 'months_ARRAY_12', 'script', NULL),
(183, 'months_ARRAY_2', 'arrays', 'months_ARRAY_2', 'script', NULL),
(184, 'months_ARRAY_3', 'arrays', 'months_ARRAY_3', 'script', NULL),
(185, 'months_ARRAY_4', 'arrays', 'months_ARRAY_4', 'script', NULL),
(186, 'months_ARRAY_5', 'arrays', 'months_ARRAY_5', 'script', NULL),
(187, 'months_ARRAY_6', 'arrays', 'months_ARRAY_6', 'script', NULL),
(188, 'months_ARRAY_7', 'arrays', 'months_ARRAY_7', 'script', NULL),
(189, 'months_ARRAY_8', 'arrays', 'months_ARRAY_8', 'script', NULL),
(190, 'months_ARRAY_9', 'arrays', 'months_ARRAY_9', 'script', NULL),
(191, 'personal_titles_ARRAY_dr', 'arrays', 'personal_titles_ARRAY_dr', 'script', NULL),
(192, 'personal_titles_ARRAY_miss', 'arrays', 'personal_titles_ARRAY_miss', 'script', NULL),
(193, 'personal_titles_ARRAY_mr', 'arrays', 'personal_titles_ARRAY_mr', 'script', NULL),
(194, 'personal_titles_ARRAY_mrs', 'arrays', 'personal_titles_ARRAY_mrs', 'script', NULL),
(195, 'personal_titles_ARRAY_ms', 'arrays', 'personal_titles_ARRAY_ms', 'script', NULL),
(196, 'personal_titles_ARRAY_other', 'arrays', 'personal_titles_ARRAY_other', 'script', NULL),
(197, 'personal_titles_ARRAY_prof', 'arrays', 'personal_titles_ARRAY_prof', 'script', NULL),
(198, 'personal_titles_ARRAY_rev', 'arrays', 'personal_titles_ARRAY_rev', 'script', NULL),
(199, 'short_months_ARRAY_1', 'arrays', 'short_months_ARRAY_1', 'script', NULL),
(200, 'short_months_ARRAY_10', 'arrays', 'short_months_ARRAY_10', 'script', NULL),
(201, 'short_months_ARRAY_11', 'arrays', 'short_months_ARRAY_11', 'script', NULL),
(202, 'short_months_ARRAY_12', 'arrays', 'short_months_ARRAY_12', 'script', NULL),
(203, 'short_months_ARRAY_2', 'arrays', 'short_months_ARRAY_2', 'script', NULL),
(204, 'short_months_ARRAY_3', 'arrays', 'short_months_ARRAY_3', 'script', NULL),
(205, 'short_months_ARRAY_4', 'arrays', 'short_months_ARRAY_4', 'script', NULL),
(206, 'short_months_ARRAY_5', 'arrays', 'short_months_ARRAY_5', 'script', NULL),
(207, 'short_months_ARRAY_6', 'arrays', 'short_months_ARRAY_6', 'script', NULL),
(208, 'short_months_ARRAY_7', 'arrays', 'short_months_ARRAY_7', 'script', NULL),
(209, 'short_months_ARRAY_8', 'arrays', 'short_months_ARRAY_8', 'script', NULL),
(210, 'short_months_ARRAY_9', 'arrays', 'short_months_ARRAY_9', 'script', NULL),
(211, 'status_ARRAY_1', 'arrays', 'status_ARRAY_1', 'script', NULL),
(212, 'status_ARRAY_123', 'arrays', 'status_ARRAY_123', 'script', NULL),
(213, 'status_ARRAY_2', 'arrays', 'status_ARRAY_2', 'script', NULL),
(214, 'status_ARRAY_3', 'arrays', 'status_ARRAY_3', 'script', NULL),
(215, 'status_ARRAY_7', 'arrays', 'status_ARRAY_7', 'script', NULL),
(216, 'status_ARRAY_996', 'arrays', 'status_ARRAY_996', 'script', NULL),
(217, 'status_ARRAY_997', 'arrays', 'status_ARRAY_997', 'script', NULL),
(218, 'status_ARRAY_998', 'arrays', 'status_ARRAY_998', 'script', NULL),
(219, 'status_ARRAY_999', 'arrays', 'status_ARRAY_999', 'script', NULL),
(220, 'status_ARRAY_9997', 'arrays', 'status_ARRAY_9997', 'script', NULL),
(221, 'status_ARRAY_9998', 'arrays', 'status_ARRAY_9998', 'script', NULL),
(222, 'status_ARRAY_9999', 'arrays', 'status_ARRAY_9999', 'script', NULL),
(223, 'timezones_ARRAY_-10800', 'arrays', 'timezones_ARRAY_-10800', 'script', NULL),
(224, 'timezones_ARRAY_-14400', 'arrays', 'timezones_ARRAY_-14400', 'script', NULL),
(225, 'timezones_ARRAY_-18000', 'arrays', 'timezones_ARRAY_-18000', 'script', NULL),
(226, 'timezones_ARRAY_-21600', 'arrays', 'timezones_ARRAY_-21600', 'script', NULL),
(227, 'timezones_ARRAY_-25200', 'arrays', 'timezones_ARRAY_-25200', 'script', NULL),
(228, 'timezones_ARRAY_-28800', 'arrays', 'timezones_ARRAY_-28800', 'script', NULL),
(229, 'timezones_ARRAY_-32400', 'arrays', 'timezones_ARRAY_-32400', 'script', NULL),
(230, 'timezones_ARRAY_-3600', 'arrays', 'timezones_ARRAY_-3600', 'script', NULL),
(231, 'timezones_ARRAY_-36000', 'arrays', 'timezones_ARRAY_-36000', 'script', NULL),
(232, 'timezones_ARRAY_-39600', 'arrays', 'timezones_ARRAY_-39600', 'script', NULL),
(233, 'timezones_ARRAY_-43200', 'arrays', 'timezones_ARRAY_-43200', 'script', NULL),
(234, 'timezones_ARRAY_-7200', 'arrays', 'timezones_ARRAY_-7200', 'script', NULL),
(235, 'timezones_ARRAY_0', 'arrays', 'timezones_ARRAY_0', 'script', NULL),
(236, 'timezones_ARRAY_10800', 'arrays', 'timezones_ARRAY_10800', 'script', NULL),
(237, 'timezones_ARRAY_14400', 'arrays', 'timezones_ARRAY_14400', 'script', NULL),
(238, 'timezones_ARRAY_18000', 'arrays', 'timezones_ARRAY_18000', 'script', NULL),
(239, 'timezones_ARRAY_21600', 'arrays', 'timezones_ARRAY_21600', 'script', NULL),
(240, 'timezones_ARRAY_25200', 'arrays', 'timezones_ARRAY_25200', 'script', NULL),
(241, 'timezones_ARRAY_28800', 'arrays', 'timezones_ARRAY_28800', 'script', NULL),
(242, 'timezones_ARRAY_32400', 'arrays', 'timezones_ARRAY_32400', 'script', NULL),
(243, 'timezones_ARRAY_3600', 'arrays', 'timezones_ARRAY_3600', 'script', NULL),
(244, 'timezones_ARRAY_36000', 'arrays', 'timezones_ARRAY_36000', 'script', NULL),
(245, 'timezones_ARRAY_39600', 'arrays', 'timezones_ARRAY_39600', 'script', NULL),
(246, 'timezones_ARRAY_43200', 'arrays', 'timezones_ARRAY_43200', 'script', NULL),
(247, 'timezones_ARRAY_46800', 'arrays', 'timezones_ARRAY_46800', 'script', NULL),
(248, 'timezones_ARRAY_7200', 'arrays', 'timezones_ARRAY_7200', 'script', NULL),
(249, 'u_statarr_ARRAY_F', 'arrays', 'u_statarr_ARRAY_F', 'script', NULL),
(250, 'u_statarr_ARRAY_T', 'arrays', 'u_statarr_ARRAY_T', 'script', NULL),
(251, '_yesno_ARRAY_F', 'arrays', '_yesno_ARRAY_F', 'script', NULL),
(252, '_yesno_ARRAY_T', 'arrays', '_yesno_ARRAY_T', 'script', NULL),
(253, 'delete_selected', 'backend', 'Label / Delete selected', 'script', NULL),
(254, 'delete_confirmation', 'backend', 'Label / delete confirmation', 'script', NULL),
(255, 'lblAll', 'backend', 'Label / All', 'script', NULL),
(256, 'email_taken', 'backend', 'Label / email taken', 'script', NULL),
(308, 'lblDashLastLogin', 'backend', 'Label / Last login', 'script', NULL),
(360, 'menuInstall', 'backend', 'Menu / Install', 'script', NULL),
(361, 'menuPreview', 'backend', 'Menu / Preview', 'script', NULL),
(441, 'opt_o_time_format', 'backend', 'Options / Time format', 'script', NULL),
(525, 'menuSections', 'backend', 'Menu / Sections', 'script', NULL),
(526, 'menuFiles', 'backend', 'Menu / Files', 'script', NULL),
(527, 'opt_o_datetime_format', 'backend', 'Options / Date time format', 'script', NULL),
(528, 'lblAddSection', 'backend', 'Label / Add section', 'script', NULL),
(529, 'infoSectionsTitle', 'backend', 'Infobox / List of sections', 'script', NULL),
(530, 'infoSectionsDesc', 'backend', 'Infobox / List of sections', 'script', NULL),
(531, 'lblSection', 'backend', 'Label / Section', 'script', NULL),
(532, 'infoAddSectionTitle', 'backend', 'Infobox / Add new section', 'script', NULL),
(533, 'infoAddSectionDesc', 'backend', 'Infobox / Add new section', 'script', NULL),
(534, 'lblContent', 'backend', 'Label / Content', 'script', NULL),
(535, 'lblUsers', 'backend', 'Label / Users', 'script', NULL),
(536, 'lblSelectUsers', 'backend', 'Label / Select users', 'script', NULL),
(537, 'lblFieldRequired', 'backend', 'Label / This field is required.', 'script', NULL),
(538, 'lblNoAvailableUsers', 'backend', 'Label / No available users', 'script', NULL),
(539, 'lblHere', 'backend', 'Label / here', 'script', NULL),
(540, 'lblFiles', 'backend', 'Label / Files', 'script', NULL),
(541, 'lblUploadFile', 'backend', 'Label / Upload file', 'script', NULL),
(542, 'infoFileListTitle', 'backend', 'Infobox / List of files', 'script', NULL),
(543, 'infoFileListDesc', 'backend', 'Infobox / List of files', 'script', NULL),
(544, 'lblFileName', 'backend', 'Label / File name', 'script', NULL),
(545, 'lblFile', 'backend', 'Label / File', 'script', NULL),
(546, 'infoUploadFileTitle', 'backend', 'Infobox / Upload file', 'script', NULL),
(547, 'infoUploadFileDesc', 'backend', 'Infobox / Upload file', 'script', NULL),
(548, 'opt_o_extension_allow', 'backend', 'Options / File extension allow', 'script', NULL),
(549, 'lblExtensionMessage', 'backend', 'Label / Extension message', 'script', NULL),
(550, 'infoUpdateFileTitle', 'backend', 'Infobox / Update file', 'script', NULL),
(551, 'infoUpdateFileDesc', 'backend', 'Infobox / Update file', 'script', NULL),
(552, 'lblUpdateFile', 'backend', 'Label / Update file', 'script', NULL),
(553, 'lblCurrentFile', 'backend', 'Label / Current file', 'script', NULL),
(554, 'lblURL', 'backend', 'Label / URL', 'script', NULL),
(555, 'error_titles_ARRAY_AF01', 'arrays', 'error_titles_ARRAY_AF01', 'script', NULL),
(556, 'error_bodies_ARRAY_AF01', 'arrays', 'error_bodies_ARRAY_AF01', 'script', NULL),
(557, 'error_titles_ARRAY_AF03', 'arrays', 'error_titles_ARRAY_AF03', 'script', NULL),
(558, 'error_bodies_ARRAY_AF03', 'arrays', 'error_bodies_ARRAY_AF03', 'script', NULL),
(559, 'error_titles_ARRAY_AF04', 'arrays', 'error_titles_ARRAY_AF04', 'script', NULL),
(560, 'error_bodies_ARRAY_AF04', 'arrays', 'error_bodies_ARRAY_AF04', 'script', NULL),
(561, 'error_titles_ARRAY_AF08', 'arrays', 'error_titles_ARRAY_AF08', 'script', NULL),
(562, 'error_bodies_ARRAY_AF08', 'arrays', 'error_bodies_ARRAY_AF08', 'script', NULL),
(563, 'error_titles_ARRAY_AF09', 'arrays', 'error_titles_ARRAY_AF09', 'script', NULL),
(564, 'error_bodies_ARRAY_AF09', 'arrays', 'error_bodies_ARRAY_AF09', 'script', NULL),
(565, 'error_titles_ARRAY_AF10', 'arrays', 'error_titles_ARRAY_AF10', 'script', NULL),
(566, 'error_bodies_ARRAY_AF10', 'arrays', 'error_bodies_ARRAY_AF10', 'script', NULL),
(567, 'error_titles_ARRAY_AF05', 'arrays', 'error_titles_ARRAY_AF05', 'script', NULL),
(568, 'error_bodies_ARRAY_AF05', 'arrays', 'error_bodies_ARRAY_AF05', 'script', NULL),
(569, 'lblUpdateSection', 'backend', 'Label / Update section', 'script', NULL),
(570, 'infoUpdateSectionTitle', 'backend', 'Infobox / Update section', 'script', NULL),
(571, 'infoUpdateSectionDesc', 'backend', 'Infobox / Update section', 'script', NULL),
(572, 'error_titles_ARRAY_AS01', 'arrays', 'error_titles_ARRAY_AS01', 'script', NULL),
(573, 'error_bodies_ARRAY_AS01', 'arrays', 'error_bodies_ARRAY_AS01', 'script', NULL),
(574, 'error_titles_ARRAY_AS03', 'arrays', 'error_titles_ARRAY_AS03', 'script', NULL),
(575, 'error_bodies_ARRAY_AS03', 'arrays', 'error_bodies_ARRAY_AS03', 'script', NULL),
(576, 'error_titles_ARRAY_AS04', 'arrays', 'error_titles_ARRAY_AS04', 'script', NULL),
(577, 'error_bodies_ARRAY_AS04', 'arrays', 'error_bodies_ARRAY_AS04', 'script', NULL),
(578, 'error_titles_ARRAY_AS08', 'arrays', 'error_titles_ARRAY_AS08', 'script', NULL),
(579, 'error_bodies_ARRAY_AS08', 'arrays', 'error_bodies_ARRAY_AS08', 'script', NULL),
(580, 'lblEdit', 'backend', 'Label / Edit', 'script', NULL),
(582, 'lblDuplicateSection', 'backend', 'Label / Duplicate section', 'script', NULL),
(583, 'lblInstall', 'backend', 'Label / Install', 'script', NULL),
(584, 'infoInstallSectionTitle', 'backend', 'Infobox / Install', 'script', NULL),
(585, 'infoInstallSectionDesc', 'backend', 'Infobox / Install', 'script', NULL),
(586, 'install_methods_ARRAY_php', 'arrays', 'install_methods_ARRAY_php', 'script', NULL),
(587, 'install_methods_ARRAY_javascript', 'arrays', 'install_methods_ARRAY_javascript', 'script', NULL),
(588, 'lblInstallNote', 'backend', 'Label / Install note', 'script', NULL),
(589, 'lblInstallMethod', 'backend', 'Label / Install method', 'script', NULL),
(590, 'lblInstallCode', 'backend', 'Label / Install code', 'script', NULL),
(591, 'lblInstallJsNote', 'backend', 'Label / Install JS note', 'script', NULL),
(592, 'lblInstallPhpStep2', 'backend', 'Label / Install PHP Step 2', 'script', NULL),
(593, 'lblMore', 'backend', 'Label / More', 'script', NULL),
(594, 'lblPreviewWebPage', 'backend', 'Label / Preview web page', 'script', NULL),
(595, 'lblViewChanges', 'backend', 'Label / View changes', 'script', NULL),
(596, 'lblInstallConfig', 'backend', 'Label / Installation configuration', 'script', NULL),
(597, 'lblSelectLanguage', 'backend', 'Label / Select language', 'script', NULL),
(598, 'lblLanguageHide', 'backend', 'Label / Hide language selector', 'script', NULL),
(599, 'lblInstallPhpStep1', 'backend', 'Label / Install PHP Step 1', 'script', NULL),
(600, 'lblInstallPhpStep3', 'backend', 'Label / Install PHP Step 3', 'script', NULL),
(601, 'infoSectionHistoryTitle', 'backend', 'Infobox / History of Section', 'script', NULL),
(602, 'infoSectionHistoryDesc', 'backend', 'Infobox / History of Section', 'script', NULL),
(603, 'gridEmptyTitle', 'backend', 'Grid / No records selected', 'script', NULL),
(604, 'gridEmptyBody', 'backend', 'Grid / No records selected', 'script', NULL),
(605, 'lblDateTime', 'backend', 'Grid / Date & time', 'script', NULL),
(606, 'lblUser', 'backend', 'Grid / User', 'script', NULL),
(607, 'lblIpAddress', 'backend', 'Grid / IP address', 'script', NULL),
(608, 'lblView', 'backend', 'Label / View', 'script', NULL),
(609, 'lblRestore', 'backend', 'Label / Restore', 'script', NULL),
(610, 'lblSectionContent', 'backend', 'Label / Section content', 'script', NULL),
(611, 'buttons_ARRAY_ok', 'arrays', 'buttons_ARRAY_ok', 'script', NULL),
(612, 'buttons_ARRAY_yes', 'arrays', 'buttons_ARRAY_yes', 'script', NULL),
(613, 'buttons_ARRAY_no', 'arrays', 'buttons_ARRAY_no', 'script', NULL),
(614, 'lblRestoreSection', 'backend', 'Label / Restore section', 'script', NULL),
(615, 'lblRestoreConfirmation', 'backend', 'Label / Restore confirmation', 'script', NULL),
(616, 'lblSelectSections', 'backend', 'Label / Select sections', 'script', NULL),
(617, 'lblSelectFiles', 'backend', 'Label / Select files', 'script', NULL),
(618, 'lblAllowAddingSections', 'backend', 'Label / Allow adding sections', 'script', NULL),
(619, 'lblAllowUploadingFiles', 'backend', 'Label / Allow uploading files', 'script', NULL),
(620, 'lblOpenPage', 'backend', 'Label / Open page', 'script', NULL),
(623, 'lblUploadedOn', 'backend', 'Label / Uploaded on', 'script', NULL),
(624, 'lblUploadedBy', 'backend', 'Label / Uploaded by', 'script', NULL),
(625, 'lblSize', 'backend', 'Label / Size', 'script', NULL),
(626, 'buttons_ARRAY_close', 'arrays', 'buttons_ARRAY_close', 'script', NULL),
(627, 'buttons_ARRAY_restore', 'arrays', 'buttons_ARRAY_restore', 'script', NULL),
(628, 'lblLastChanged', 'backend', 'Label / Last changed', 'script', NULL),
(629, 'lblBy', 'backend', 'Label / by', 'script', NULL),
(630, 'lblNA', 'backend', 'Label / n/a', 'script', NULL),
(631, 'lblViewAllChanges', 'backend', 'Label / view all changes', 'script', NULL),
(632, 'lblViewOneChange', 'backend', 'Label / view one change', 'script', NULL),
(633, 'lblChanges', 'backend', 'Label / Changes', 'script', NULL),
(634, 'lblURLText', 'backend', 'Label / URL text', 'script', NULL),
(635, 'lblPreviewNewInWindow', 'backend', 'Label / Preview in new window', 'script', NULL),
(636, 'lblInvalidUrl', 'backend', 'Label / URL is invalid.', 'script', NULL),
(720, 'lblOneChange', 'backend', 'Label / view 1 change', 'script', NULL),
(804, 'lblFilterBySection', 'backend', 'Label / Filter by section', 'script', NULL),
(805, 'lblInactiveSectionNote', 'backend', 'Label / Inactive section notes', 'script', NULL),
(806, 'front_file_not_found', 'frontend', 'Label / File cannot be found.', 'script', NULL);

INSERT INTO `simple_cms_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, 1, 'pjField', 1, 'title', 'Add language', 'script'),
(NULL, 2, 'pjField', 1, 'title', 'Password reminder', 'script'),
(NULL, 3, 'pjField', 1, 'title', 'Admin Login', 'script'),
(NULL, 4, 'pjField', 1, 'title', 'Back-end titles', 'script'),
(NULL, 5, 'pjField', 1, 'title', 'Add +', 'script'),
(NULL, 6, 'pjField', 1, 'title', '« Back', 'script'),
(NULL, 7, 'pjField', 1, 'title', 'Backup', 'script'),
(NULL, 8, 'pjField', 1, 'title', 'Cancel', 'script'),
(NULL, 9, 'pjField', 1, 'title', 'Continue', 'script'),
(NULL, 10, 'pjField', 1, 'title', 'Delete', 'script'),
(NULL, 11, 'pjField', 1, 'title', 'Login', 'script'),
(NULL, 12, 'pjField', 1, 'title', 'Reset', 'script'),
(NULL, 13, 'pjField', 1, 'title', 'Save', 'script'),
(NULL, 14, 'pjField', 1, 'title', 'Search', 'script'),
(NULL, 15, 'pjField', 1, 'title', 'Send', 'script'),
(NULL, 16, 'pjField', 1, 'title', 'Update', 'script'),
(NULL, 17, 'pjField', 1, 'title', 'DateTime', 'script'),
(NULL, 18, 'pjField', 1, 'title', 'Email', 'script'),
(NULL, 19, 'pjField', 1, 'title', 'Dear {Name},Your password: {Password}', 'script'),
(NULL, 20, 'pjField', 1, 'title', 'Password reminder', 'script'),
(NULL, 21, 'pjField', 1, 'title', 'Front-end titles', 'script'),
(NULL, 22, 'pjField', 1, 'title', 'Action confirmation', 'script'),
(NULL, 23, 'pjField', 1, 'title', 'Cancel', 'script'),
(NULL, 24, 'pjField', 1, 'title', 'Delete', 'script'),
(NULL, 25, 'pjField', 1, 'title', 'OK', 'script'),
(NULL, 26, 'pjField', 1, 'title', 'Choose Action', 'script'),
(NULL, 27, 'pjField', 1, 'title', 'Are you sure you want to delete selected record?', 'script'),
(NULL, 28, 'pjField', 1, 'title', 'Delete confirmation', 'script'),
(NULL, 29, 'pjField', 1, 'title', 'No records found', 'script'),
(NULL, 30, 'pjField', 1, 'title', 'Go to page:', 'script'),
(NULL, 31, 'pjField', 1, 'title', 'Items per page', 'script'),
(NULL, 32, 'pjField', 1, 'title', 'Next »', 'script'),
(NULL, 33, 'pjField', 1, 'title', 'Next page', 'script'),
(NULL, 34, 'pjField', 1, 'title', '« Prev', 'script'),
(NULL, 35, 'pjField', 1, 'title', 'Prev page', 'script'),
(NULL, 36, 'pjField', 1, 'title', 'Total items:', 'script'),
(NULL, 55, 'pjField', 1, 'title', 'Add user', 'script'),
(NULL, 56, 'pjField', 1, 'title', 'Backup database', 'script'),
(NULL, 57, 'pjField', 1, 'title', 'Backup files', 'script'),
(NULL, 58, 'pjField', 1, 'title', 'Choose', 'script'),
(NULL, 59, 'pjField', 1, 'title', 'days', 'script'),
(NULL, 60, 'pjField', 1, 'title', 'Delete', 'script'),
(NULL, 61, 'pjField', 1, 'title', 'Error', 'script'),
(NULL, 62, 'pjField', 1, 'title', 'Export', 'script'),
(NULL, 63, 'pjField', 1, 'title', 'Forgot password', 'script'),
(NULL, 64, 'pjField', 1, 'title', 'IP address', 'script'),
(NULL, 65, 'pjField', 1, 'title', 'Is confirmed', 'script'),
(NULL, 66, 'pjField', 1, 'title', 'Name', 'script'),
(NULL, 67, 'pjField', 1, 'title', 'No', 'script'),
(NULL, 68, 'pjField', 1, 'title', 'Option', 'script'),
(NULL, 69, 'pjField', 1, 'title', 'Option list', 'script'),
(NULL, 70, 'pjField', 1, 'title', 'Role', 'script'),
(NULL, 71, 'pjField', 1, 'title', 'Status', 'script'),
(NULL, 72, 'pjField', 1, 'title', 'Type', 'script'),
(NULL, 73, 'pjField', 1, 'title', 'Update user', 'script'),
(NULL, 74, 'pjField', 1, 'title', 'Registration date/time', 'script'),
(NULL, 75, 'pjField', 1, 'title', 'Value', 'script'),
(NULL, 76, 'pjField', 1, 'title', 'Yes', 'script'),
(NULL, 77, 'pjField', 1, 'title', 'Back', 'script'),
(NULL, 78, 'pjField', 1, 'title', 'Arrays titles', 'script'),
(NULL, 79, 'pjField', 1, 'title', 'Languages', 'script'),
(NULL, 80, 'pjField', 1, 'title', 'Flag', 'script'),
(NULL, 81, 'pjField', 1, 'title', 'Is default', 'script'),
(NULL, 82, 'pjField', 1, 'title', 'Order', 'script'),
(NULL, 83, 'pjField', 1, 'title', 'Title', 'script'),
(NULL, 84, 'pjField', 1, 'title', 'Backup', 'script'),
(NULL, 85, 'pjField', 1, 'title', 'Dashboard', 'script'),
(NULL, 86, 'pjField', 1, 'title', 'Multi Lang', 'script'),
(NULL, 87, 'pjField', 1, 'title', 'Languages', 'script'),
(NULL, 88, 'pjField', 1, 'title', 'Logout', 'script'),
(NULL, 89, 'pjField', 1, 'title', 'Options', 'script'),
(NULL, 90, 'pjField', 1, 'title', 'Plugins', 'script'),
(NULL, 91, 'pjField', 1, 'title', 'Profile', 'script'),
(NULL, 92, 'pjField', 1, 'title', 'Users', 'script'),
(NULL, 93, 'pjField', 1, 'title', 'Click on the flag icon to choose which language version of the content you wish to edit.', 'script'),
(NULL, 94, 'pjField', 1, 'title', 'Currency', 'script'),
(NULL, 95, 'pjField', 1, 'title', 'Date format', 'script'),
(NULL, 96, 'pjField', 1, 'title', 'Send email', 'script'),
(NULL, 97, 'pjField', 1, 'title', 'SMTP Host', 'script'),
(NULL, 98, 'pjField', 1, 'title', 'SMTP Password', 'script'),
(NULL, 99, 'pjField', 1, 'title', 'SMTP Port', 'script'),
(NULL, 100, 'pjField', 1, 'title', 'SMTP Username', 'script'),
(NULL, 101, 'pjField', 1, 'title', 'Timezone', 'script'),
(NULL, 102, 'pjField', 1, 'title', 'First day of the week', 'script'),
(NULL, 103, 'pjField', 1, 'title', 'Password', 'script'),
(NULL, 125, 'pjField', 1, 'title', 'Revert status', 'script'),
(NULL, 126, 'pjField', 1, 'title', 'URL', 'script'),
(NULL, 127, 'pjField', 1, 'title', 'Username', 'script'),
(NULL, 128, 'pjField', 1, 'title', 'There is another user with such email address.', 'script'),
(NULL, 129, 'pjField', 1, 'title', 'Sunday', 'script'),
(NULL, 130, 'pjField', 1, 'title', 'Monday', 'script'),
(NULL, 131, 'pjField', 1, 'title', 'Tuesday', 'script'),
(NULL, 132, 'pjField', 1, 'title', 'Wednesday', 'script'),
(NULL, 133, 'pjField', 1, 'title', 'Thursday', 'script'),
(NULL, 134, 'pjField', 1, 'title', 'Friday', 'script'),
(NULL, 135, 'pjField', 1, 'title', 'Saturday', 'script'),
(NULL, 136, 'pjField', 1, 'title', 'S', 'script'),
(NULL, 137, 'pjField', 1, 'title', 'M', 'script'),
(NULL, 138, 'pjField', 1, 'title', 'T', 'script'),
(NULL, 139, 'pjField', 1, 'title', 'W', 'script'),
(NULL, 140, 'pjField', 1, 'title', 'T', 'script'),
(NULL, 141, 'pjField', 1, 'title', 'F', 'script'),
(NULL, 142, 'pjField', 1, 'title', 'S', 'script'),
(NULL, 143, 'pjField', 1, 'title', 'Given email address is not associated with any account.', 'script'),
(NULL, 144, 'pjField', 1, 'title', 'For further instructions please check your mailbox.', 'script'),
(NULL, 145, 'pjField', 1, 'title', 'We are sorry, please try again later.', 'script'),
(NULL, 146, 'pjField', 1, 'title', 'All the changes made to your profile have been saved.', 'script'),
(NULL, 147, 'pjField', 1, 'title', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc at ligula non arcu dignissim pretium. Praesent in magna nulla, in porta leo.', 'script'),
(NULL, 148, 'pjField', 1, 'title', 'All backup files have been saved.', 'script'),
(NULL, 149, 'pjField', 1, 'title', 'No option was selected.', 'script'),
(NULL, 150, 'pjField', 1, 'title', 'Backup not performed.', 'script'),
(NULL, 151, 'pjField', 1, 'title', 'All the changes made to titles have been saved.', 'script'),
(NULL, 152, 'pjField', 1, 'title', 'All the changes made to options have been saved.', 'script'),
(NULL, 153, 'pjField', 1, 'title', 'All the changes made to this user have been saved.', 'script'),
(NULL, 154, 'pjField', 1, 'title', 'All the changes made to this user have been saved.', 'script'),
(NULL, 155, 'pjField', 1, 'title', 'We are sorry, but the user has not been added.', 'script'),
(NULL, 156, 'pjField', 1, 'title', 'User your looking for is missing.', 'script'),
(NULL, 159, 'pjField', 1, 'title', 'Account not found!', 'script'),
(NULL, 160, 'pjField', 1, 'title', 'Password send!', 'script'),
(NULL, 161, 'pjField', 1, 'title', 'Password not send!', 'script'),
(NULL, 162, 'pjField', 1, 'title', 'Profile updated!', 'script'),
(NULL, 163, 'pjField', 1, 'title', 'Backup', 'script'),
(NULL, 164, 'pjField', 1, 'title', 'Backup complete!', 'script'),
(NULL, 165, 'pjField', 1, 'title', 'Backup failed!', 'script'),
(NULL, 166, 'pjField', 1, 'title', 'Backup failed!', 'script'),
(NULL, 167, 'pjField', 1, 'title', 'Options updated!', 'script'),
(NULL, 168, 'pjField', 1, 'title', 'User updated!', 'script'),
(NULL, 169, 'pjField', 1, 'title', 'User added!', 'script'),
(NULL, 170, 'pjField', 1, 'title', 'User failed to add.', 'script'),
(NULL, 171, 'pjField', 1, 'title', 'User not found.', 'script'),
(NULL, 174, 'pjField', 1, 'title', 'Active', 'script'),
(NULL, 175, 'pjField', 1, 'title', 'Inactive', 'script'),
(NULL, 176, 'pjField', 1, 'title', 'Wrong username or password', 'script'),
(NULL, 177, 'pjField', 1, 'title', 'Access denied', 'script'),
(NULL, 178, 'pjField', 1, 'title', 'Account is disabled', 'script'),
(NULL, 179, 'pjField', 1, 'title', 'January', 'script'),
(NULL, 180, 'pjField', 1, 'title', 'October', 'script'),
(NULL, 181, 'pjField', 1, 'title', 'November', 'script'),
(NULL, 182, 'pjField', 1, 'title', 'December', 'script'),
(NULL, 183, 'pjField', 1, 'title', 'February', 'script'),
(NULL, 184, 'pjField', 1, 'title', 'March', 'script'),
(NULL, 185, 'pjField', 1, 'title', 'April', 'script'),
(NULL, 186, 'pjField', 1, 'title', 'May', 'script'),
(NULL, 187, 'pjField', 1, 'title', 'June', 'script'),
(NULL, 188, 'pjField', 1, 'title', 'July', 'script'),
(NULL, 189, 'pjField', 1, 'title', 'August', 'script'),
(NULL, 190, 'pjField', 1, 'title', 'September', 'script'),
(NULL, 191, 'pjField', 1, 'title', 'Dr.', 'script'),
(NULL, 192, 'pjField', 1, 'title', 'Miss', 'script'),
(NULL, 193, 'pjField', 1, 'title', 'Mr.', 'script'),
(NULL, 194, 'pjField', 1, 'title', 'Mrs.', 'script'),
(NULL, 195, 'pjField', 1, 'title', 'Ms.', 'script'),
(NULL, 196, 'pjField', 1, 'title', 'Other', 'script'),
(NULL, 197, 'pjField', 1, 'title', 'Prof.', 'script'),
(NULL, 198, 'pjField', 1, 'title', 'Rev.', 'script'),
(NULL, 199, 'pjField', 1, 'title', 'Jan', 'script'),
(NULL, 200, 'pjField', 1, 'title', 'Oct', 'script'),
(NULL, 201, 'pjField', 1, 'title', 'Nov', 'script'),
(NULL, 202, 'pjField', 1, 'title', 'Dec', 'script'),
(NULL, 203, 'pjField', 1, 'title', 'Feb', 'script'),
(NULL, 204, 'pjField', 1, 'title', 'Mar', 'script'),
(NULL, 205, 'pjField', 1, 'title', 'Apr', 'script'),
(NULL, 206, 'pjField', 1, 'title', 'May', 'script'),
(NULL, 207, 'pjField', 1, 'title', 'Jun', 'script'),
(NULL, 208, 'pjField', 1, 'title', 'Jul', 'script'),
(NULL, 209, 'pjField', 1, 'title', 'Aug', 'script'),
(NULL, 210, 'pjField', 1, 'title', 'Sep', 'script'),
(NULL, 211, 'pjField', 1, 'title', 'You are not loged in.', 'script'),
(NULL, 212, 'pjField', 1, 'title', 'Your hosting account does not allow uploading such a large image.', 'script'),
(NULL, 213, 'pjField', 1, 'title', 'Access denied. You have not requisite rights to.', 'script'),
(NULL, 214, 'pjField', 1, 'title', 'Empty resultset.', 'script'),
(NULL, 215, 'pjField', 1, 'title', 'The operation is not allowed in demo mode.', 'script'),
(NULL, 216, 'pjField', 1, 'title', 'No property for the reservation found', 'script'),
(NULL, 217, 'pjField', 1, 'title', 'No reservation found', 'script'),
(NULL, 218, 'pjField', 1, 'title', 'No permisions to edit the reservation', 'script'),
(NULL, 219, 'pjField', 1, 'title', 'No permisions to edit the property', 'script'),
(NULL, 220, 'pjField', 1, 'title', 'E-Mail address already exist', 'script'),
(NULL, 221, 'pjField', 1, 'title', 'Your registration was successfull. Your account needs to be approved.', 'script'),
(NULL, 222, 'pjField', 1, 'title', 'Your registration was successfull.', 'script'),
(NULL, 223, 'pjField', 1, 'title', 'GMT-03:00', 'script'),
(NULL, 224, 'pjField', 1, 'title', 'GMT-04:00', 'script'),
(NULL, 225, 'pjField', 1, 'title', 'GMT-05:00', 'script'),
(NULL, 226, 'pjField', 1, 'title', 'GMT-06:00', 'script'),
(NULL, 227, 'pjField', 1, 'title', 'GMT-07:00', 'script'),
(NULL, 228, 'pjField', 1, 'title', 'GMT-08:00', 'script'),
(NULL, 229, 'pjField', 1, 'title', 'GMT-09:00', 'script'),
(NULL, 230, 'pjField', 1, 'title', 'GMT-01:00', 'script'),
(NULL, 231, 'pjField', 1, 'title', 'GMT-10:00', 'script'),
(NULL, 232, 'pjField', 1, 'title', 'GMT-11:00', 'script'),
(NULL, 233, 'pjField', 1, 'title', 'GMT-12:00', 'script'),
(NULL, 234, 'pjField', 1, 'title', 'GMT-02:00', 'script'),
(NULL, 235, 'pjField', 1, 'title', 'GMT', 'script'),
(NULL, 236, 'pjField', 1, 'title', 'GMT+03:00', 'script'),
(NULL, 237, 'pjField', 1, 'title', 'GMT+04:00', 'script'),
(NULL, 238, 'pjField', 1, 'title', 'GMT+05:00', 'script'),
(NULL, 239, 'pjField', 1, 'title', 'GMT+06:00', 'script'),
(NULL, 240, 'pjField', 1, 'title', 'GMT+07:00', 'script'),
(NULL, 241, 'pjField', 1, 'title', 'GMT+08:00', 'script'),
(NULL, 242, 'pjField', 1, 'title', 'GMT+09:00', 'script'),
(NULL, 243, 'pjField', 1, 'title', 'GMT+01:00', 'script'),
(NULL, 244, 'pjField', 1, 'title', 'GMT+10:00', 'script'),
(NULL, 245, 'pjField', 1, 'title', 'GMT+11:00', 'script'),
(NULL, 246, 'pjField', 1, 'title', 'GMT+12:00', 'script'),
(NULL, 247, 'pjField', 1, 'title', 'GMT+13:00', 'script'),
(NULL, 248, 'pjField', 1, 'title', 'GMT+02:00', 'script'),
(NULL, 249, 'pjField', 1, 'title', 'Inactive', 'script'),
(NULL, 250, 'pjField', 1, 'title', 'Active', 'script'),
(NULL, 251, 'pjField', 1, 'title', 'No', 'script'),
(NULL, 252, 'pjField', 1, 'title', 'Yes', 'script'),
(NULL, 253, 'pjField', 1, 'title', 'Delete selected', 'script'),
(NULL, 254, 'pjField', 1, 'title', 'Are you sure that you want to delete selected record(s)?', 'script'),
(NULL, 255, 'pjField', 1, 'title', 'All', 'script'),
(NULL, 256, 'pjField', 1, 'title', 'Email address was already in use.', 'script'),
(NULL, 308, 'pjField', 1, 'title', 'Last login', 'script'),
(NULL, 360, 'pjField', 1, 'title', 'Install', 'script'),
(NULL, 361, 'pjField', 1, 'title', 'Preview', 'script'),
(NULL, 441, 'pjField', 1, 'title', 'Time format', 'script'),
(NULL, 525, 'pjField', 1, 'title', 'Sections', 'script'),
(NULL, 526, 'pjField', 1, 'title', 'Files', 'script'),
(NULL, 527, 'pjField', 1, 'title', 'Date time format', 'script'),
(NULL, 528, 'pjField', 1, 'title', 'Add section', 'script'),
(NULL, 529, 'pjField', 1, 'title', 'List of sections', 'script'),
(NULL, 530, 'pjField', 1, 'title', 'Below is a list with all editable sections. You can add new section, delete or edit existing sections. To install a section on your web page click on More button - Install code link.', 'script'),
(NULL, 531, 'pjField', 1, 'title', 'Section', 'script'),
(NULL, 532, 'pjField', 1, 'title', 'Add new section', 'script'),
(NULL, 533, 'pjField', 1, 'title', 'Fill in the form below to add a new section. You can set its name, select the editors who can edit it, its content and also URL for the web page where the section will be placed.', 'script'),
(NULL, 534, 'pjField', 1, 'title', 'Content', 'script'),
(NULL, 535, 'pjField', 1, 'title', 'Editors', 'script'),
(NULL, 536, 'pjField', 1, 'title', 'Select editors', 'script'),
(NULL, 537, 'pjField', 1, 'title', 'This field is required.', 'script'),
(NULL, 538, 'pjField', 1, 'title', 'There is no available users now. To add new user click', 'script'),
(NULL, 539, 'pjField', 1, 'title', 'here', 'script'),
(NULL, 540, 'pjField', 1, 'title', 'Files', 'script'),
(NULL, 541, 'pjField', 1, 'title', 'Upload file', 'script'),
(NULL, 542, 'pjField', 1, 'title', 'Files', 'script'),
(NULL, 543, 'pjField', 1, 'title', 'Below is a list with all uploaded files. You can add new file, edit or delete existing files.', 'script'),
(NULL, 544, 'pjField', 1, 'title', 'File name', 'script'),
(NULL, 545, 'pjField', 1, 'title', 'File', 'script'),
(NULL, 546, 'pjField', 1, 'title', 'Upload file', 'script'),
(NULL, 547, 'pjField', 1, 'title', 'Use the form below to upload a new file. You can select the editors who have access to it. ', 'script'),
(NULL, 548, 'pjField', 1, 'title', 'File extensions allowed to upload', 'script'),
(NULL, 549, 'pjField', 1, 'title', 'File with extension is not allowed to upload.', 'script'),
(NULL, 550, 'pjField', 1, 'title', 'File details', 'script'),
(NULL, 551, 'pjField', 1, 'title', 'You can upload a new file and select the editors who have access to it. Use the URL to include the file in your sections.', 'script'),
(NULL, 552, 'pjField', 1, 'title', 'File details', 'script'),
(NULL, 553, 'pjField', 1, 'title', 'Current file', 'script'),
(NULL, 554, 'pjField', 1, 'title', 'URL', 'script'),
(NULL, 555, 'pjField', 1, 'title', 'File updated', 'script'),
(NULL, 556, 'pjField', 1, 'title', 'All change made to the file have been saved successfully.', 'script'),
(NULL, 557, 'pjField', 1, 'title', 'File uploaded', 'script'),
(NULL, 558, 'pjField', 1, 'title', 'New file has been uploaded successfully.', 'script'),
(NULL, 559, 'pjField', 1, 'title', 'Upload error', 'script'),
(NULL, 560, 'pjField', 1, 'title', 'New file could not be uploaded successfully.', 'script'),
(NULL, 561, 'pjField', 1, 'title', 'File not found', 'script'),
(NULL, 562, 'pjField', 1, 'title', 'We are sorry that file you are looking for is missing.', 'script'),
(NULL, 563, 'pjField', 1, 'title', 'File not uploaded', 'script'),
(NULL, 564, 'pjField', 1, 'title', 'New file could not be uploaded successfully.', 'script'),
(NULL, 565, 'pjField', 1, 'title', 'File not uploaded', 'script'),
(NULL, 566, 'pjField', 1, 'title', 'Some error occurred and the file could not be uploaded.', 'script'),
(NULL, 567, 'pjField', 1, 'title', 'File too big', 'script'),
(NULL, 568, 'pjField', 1, 'title', 'File could not be upload because the file size is too big. Maximum allowed size is {SIZE}. Please, upload another file.', 'script'),
(NULL, 569, 'pjField', 1, 'title', 'Update section', 'script'),
(NULL, 570, 'pjField', 1, 'title', 'Update section', 'script'),
(NULL, 571, 'pjField', 1, 'title', 'Update section content and all the changes will be automatically applied to the page where section is placed.', 'script'),
(NULL, 572, 'pjField', 1, 'title', 'Section updated', 'script'),
(NULL, 573, 'pjField', 1, 'title', 'All changes made to section have been saved successfully.', 'script'),
(NULL, 574, 'pjField', 1, 'title', 'Section added', 'script'),
(NULL, 575, 'pjField', 1, 'title', 'New section has been added into the list.', 'script'),
(NULL, 576, 'pjField', 1, 'title', 'Section failed to add', 'script'),
(NULL, 577, 'pjField', 1, 'title', 'We are sorry that new section could not be added.', 'script'),
(NULL, 578, 'pjField', 1, 'title', 'Section not found', 'script'),
(NULL, 579, 'pjField', 1, 'title', 'We are sorry that section you are looking for is missing.', 'script'),
(NULL, 580, 'pjField', 1, 'title', 'Edit', 'script'),
(NULL, 582, 'pjField', 1, 'title', 'Duplicate section', 'script'),
(NULL, 583, 'pjField', 1, 'title', 'Install', 'script'),
(NULL, 584, 'pjField', 1, 'title', 'Install', 'script'),
(NULL, 585, 'pjField', 1, 'title', 'Select the integration code type - JavaScript or PHP - and then grab the code and place it on your web page. Once this is done you can edit your editable sections and changes will apply directly on the web page.', 'script'),
(NULL, 586, 'pjField', 1, 'title', 'PHP', 'script'),
(NULL, 587, 'pjField', 1, 'title', 'Javascript', 'script'),
(NULL, 588, 'pjField', 1, 'title', 'Here is the installation code for the section', 'script'),
(NULL, 589, 'pjField', 1, 'title', 'Install method', 'script'),
(NULL, 590, 'pjField', 1, 'title', 'Install code', 'script'),
(NULL, 591, 'pjField', 1, 'title', 'Copy the code below and paste it into where you want the section appear.', 'script'),
(NULL, 592, 'pjField', 1, 'title', 'Step 2. Copy and paste the code below into your html code, where the section will be displayed.', 'script'),
(NULL, 593, 'pjField', 1, 'title', 'More', 'script'),
(NULL, 594, 'pjField', 1, 'title', 'Preview web page', 'script'),
(NULL, 595, 'pjField', 1, 'title', 'View changes', 'script'),
(NULL, 596, 'pjField', 1, 'title', 'Installation configuration', 'script'),
(NULL, 597, 'pjField', 1, 'title', 'Select language', 'script'),
(NULL, 598, 'pjField', 1, 'title', 'Hide language selector', 'script'),
(NULL, 599, 'pjField', 1, 'title', 'Step 1. Copy and paste the code below at the very top of your .php page. It should be line 1 of your .php web page.', 'script'),
(NULL, 600, 'pjField', 1, 'title', 'Step 3. Copy and paste the code below at the very bottom of your .php web page after all the other code.', 'script'),
(NULL, 601, 'pjField', 1, 'title', 'Updates history', 'script'),
(NULL, 602, 'pjField', 1, 'title', 'Below is a list with all changes made to the sections. You can view previous versions of your sections and restore them.', 'script'),
(NULL, 603, 'pjField', 1, 'title', 'No records selected', 'script'),
(NULL, 604, 'pjField', 1, 'title', 'You need to select at least a single record.', 'script'),
(NULL, 605, 'pjField', 1, 'title', 'Date & time', 'script'),
(NULL, 606, 'pjField', 1, 'title', 'User', 'script'),
(NULL, 607, 'pjField', 1, 'title', 'IP address', 'script'),
(NULL, 608, 'pjField', 1, 'title', 'View', 'script'),
(NULL, 609, 'pjField', 1, 'title', 'Restore', 'script'),
(NULL, 610, 'pjField', 1, 'title', 'Section content before being changed on {DATETIME} by {USER}', 'script'),
(NULL, 611, 'pjField', 1, 'title', 'OK', 'script'),
(NULL, 612, 'pjField', 1, 'title', 'Yes', 'script'),
(NULL, 613, 'pjField', 1, 'title', 'No', 'script'),
(NULL, 614, 'pjField', 1, 'title', 'Restore section', 'script'),
(NULL, 615, 'pjField', 1, 'title', 'Do you want to restore this content for the current section?', 'script'),
(NULL, 616, 'pjField', 1, 'title', 'Select sections', 'script'),
(NULL, 617, 'pjField', 1, 'title', 'Select files', 'script'),
(NULL, 618, 'pjField', 1, 'title', 'Allow adding sections', 'script'),
(NULL, 619, 'pjField', 1, 'title', 'Allow uploading files', 'script'),
(NULL, 620, 'pjField', 1, 'title', 'Open page', 'script'),
(NULL, 623, 'pjField', 1, 'title', 'Uploaded on', 'script'),
(NULL, 624, 'pjField', 1, 'title', 'Uploaded by', 'script'),
(NULL, 625, 'pjField', 1, 'title', 'Size', 'script'),
(NULL, 626, 'pjField', 1, 'title', 'Close', 'script'),
(NULL, 627, 'pjField', 1, 'title', 'Restore', 'script'),
(NULL, 628, 'pjField', 1, 'title', 'Last changed', 'script'),
(NULL, 629, 'pjField', 1, 'title', 'by', 'script'),
(NULL, 630, 'pjField', 1, 'title', 'n/a', 'script'),
(NULL, 631, 'pjField', 1, 'title', 'view all {cnt} changes', 'script'),
(NULL, 632, 'pjField', 1, 'title', 'view 1 change', 'script'),
(NULL, 633, 'pjField', 1, 'title', 'Changes', 'script'),
(NULL, 634, 'pjField', 1, 'title', 'Enter URL for the web page where you will use this section. To install the section go to {STAG}Install Code{ETAG} page and follow the instructions.', 'script'),
(NULL, 635, 'pjField', 1, 'title', 'Preview in new window', 'script'),
(NULL, 636, 'pjField', 1, 'title', 'URL is invalid.', 'script'),
(NULL, 720, 'pjField', 1, 'title', 'view 1 change', 'script'),
(NULL, 804, 'pjField', 1, 'title', 'Filter by section', 'script'),
(NULL, 805, 'pjField', 1, 'title', 'There is no installation code for inactive section {SECTION}. Please change its status.', 'script'),
(NULL, 806, 'pjField', 1, 'title', 'File cannot be found.', 'script');

INSERT INTO `simple_cms_options` (`foreign_id`, `key`, `tab_id`, `value`, `label`, `type`, `order`, `is_visible`, `style`) VALUES
(1, 'o_date_format', 1, 'd.m.Y|m.d.Y|Y.m.d|j.n.Y|n.j.Y|Y.n.j|d/m/Y|m/d/Y|Y/m/d|j/n/Y|n/j/Y|Y/n/j|d-m-Y|m-d-Y|Y-m-d|j-n-Y|n-j-Y|Y-n-j::d-m-Y', 'd.m.Y (25.09.2012)|m.d.Y (09.25.2012)|Y.m.d (2012.09.25)|j.n.Y (25.9.2012)|n.j.Y (9.25.2012)|Y.n.j (2012.9.25)|d/m/Y (25/09/2012)|m/d/Y (09/25/2012)|Y/m/d (2012/09/25)|j/n/Y (25/9/2012)|n/j/Y (9/25/2012)|Y/n/j (2012/9/25)|d-m-Y (25-09-2012)|m-d-Y (09-25-2012)|Y-m-d (2012-09-25)|j-n-Y (25-9-2012)|n-j-Y (9-25-2012)|Y-n-j (2012-9-25)', 'enum', 1, 1, NULL),
(1, 'o_time_format', 1, 'H:i|G:i|h:i|h:i a|h:i A|g:i|g:i a|g:i A::H:i', 'H:i (09:45)|G:i (9:45)|h:i (09:45)|h:i a (09:45 am)|h:i A (09:45 AM)|g:i (9:45)|g:i a (9:45 am)|g:i A (9:45 AM)', 'enum', 2, 1, NULL),
(1, 'o_datetime_format', 1, 'd.m.Y, H:i|d.m.Y, H:i:s|m.d.Y, H:i|m.d.Y, H:i:s|Y.m.d, H:i|Y.m.d, H:i:s|j.n.Y, H:i|j.n.Y, H:i:s|n.j.Y, H:i|n.j.Y, H:i:s|Y.n.j, H:i|Y.n.j, H:i:s|d/m/Y, H:i|d/m/Y, H:i:s|m/d/Y, H:i|m/d/Y, H:i:s|Y/m/d, H:i|Y/m/d, H:i:s|j/n/Y, H:i|j/n/Y, H:i:s|n/j/Y, H:i|n/j/Y, H:i:s|Y/n/j, H:i|Y/n/j, H:i:s|d-m-Y, H:i|d-m-Y, H:i:s|m-d-Y, H:i|m-d-Y, H:i:s|Y-m-d, H:i|Y-m-d, H:i:s|j-n-Y, H:i|j-n-Y, H:i:s|n-j-Y, H:i|n-j-Y, H:i:s|Y-n-j, H:i|Y-n-j, H:i:s::d-m-Y, H:i', 'd.m.Y, H:i (25.09.2010, 09:51)|d.m.Y, H:i:s (25.09.2010, 09:51:47)|m.d.Y, H:i (09.25.2010, 09:51)|m.d.Y, H:i:s (09.25.2010, 09:51:47)|Y.m.d, H:i (2010.09.25, 09:51)|Y.m.d, H:i:s (2010.09.25, 09:51:47)|j.n.Y, H:i (25.9.2010, 09:51)|j.n.Y, H:i:s (25.9.2010, 09:51:47)|n.j.Y, H:i (9.25.2010, 09:51)|n.j.Y, H:i:s (9.25.2010, 09:51:47)|Y.n.j, H:i (2010.9.25, 09:51)|Y.n.j, H:i:s (2010.9.25, 09:51:47)|d/m/Y, H:i (25/09/2010, 09:51)|d/m/Y, H:i:s (25/09/2010, 09:51:47)|m/d/Y, H:i (09/25/2010, 09:51)|m/d/Y, H:i:s (09/25/2010, 09:51:47)|Y/m/d, H:i (2010/09/25, 09:51)|Y/m/d, H:i:s (2010/09/25, 09:51:47)|j/n/Y, H:i (25/9/2010, 09:51)|j/n/Y, H:i:s (25/9/2010, 09:51:47)|n/j/Y, H:i (9/25/2010, 09:51)|n/j/Y, H:i:s (9/25/2010, 09:51:47)|Y/n/j, H:i (2010/9/25, 09:51)|Y/n/j, H:i:s (2010/9/25, 09:51:47)|d-m-Y, H:i (25-09-2010, 09:51)|d-m-Y, H:i:s (25-09-2010, 09:51:47)|m-d-Y, H:i (09-25-2010, 09:51)|m-d-Y, H:i:s (09-25-2010, 09:51:47)|Y-m-d, H:i (2010-09-25, 09:51)|Y-m-d, H:i:s (2010-09-25, 09:51:47)|j-n-Y, H:i (25-9-2010, 09:51)|j-n-Y, H:i:s (25-9-2010, 09:51:47)|n-j-Y, H:i (9-25-2010, 09:51)|n-j-Y, H:i:s (9-25-2010, 09:51:47)|Y-n-j, H:i (2010-9-25, 09:51)|Y-n-j, H:i:s (2010-9-25, 09:51:47)', 'enum', 3, 0, NULL),
(1, 'o_timezone', 1, '-43200|-39600|-36000|-32400|-28800|-25200|-21600|-18000|-14400|-10800|-7200|-3600|0|3600|7200|10800|14400|18000|21600|25200|28800|32400|36000|39600|43200|46800::0', 'GMT-12:00|GMT-11:00|GMT-10:00|GMT-09:00|GMT-08:00|GMT-07:00|GMT-06:00|GMT-05:00|GMT-04:00|GMT-03:00|GMT-02:00|GMT-01:00|GMT|GMT+01:00|GMT+02:00|GMT+03:00|GMT+04:00|GMT+05:00|GMT+06:00|GMT+07:00|GMT+08:00|GMT+09:00|GMT+10:00|GMT+11:00|GMT+12:00|GMT+13:00', 'enum', 4, 0, NULL),
(1, 'o_week_start', 1, '0|1|2|3|4|5|6::1', 'Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday', 'enum', 5, 0, NULL),
(1, 'o_extension_allow', 1, 'doc|docx|xls|xlsx|ppt|pdf|csv|zip|rar|png|jpg|jpeg|gif', NULL, 'text', 6, 1, NULL),
(1, 'o_send_email', 1, 'mail|smtp::mail', 'PHP mail()|SMTP', 'enum', 8, 0, NULL),
(1, 'o_smtp_host', 1, NULL, NULL, 'string', 9, 1, NULL),
(1, 'o_smtp_pass', 1, NULL, NULL, 'string', 10, 1, NULL),
(1, 'o_smtp_port', 1, '25', NULL, 'int', 11, 1, NULL),
(1, 'o_smtp_user', 1, NULL, NULL, 'string', 12, 1, NULL),
(1, 'o_multi_lang', 99, '1|0::1', NULL, 'enum', NULL, 0, NULL);

INSERT INTO `simple_cms_roles` (`id`, `role`, `status`) VALUES
(1, 'admin', 'T'),
(2, 'editor', 'T');