<?php
session_name('simpleCMS');
session_start();
if(!isset($_SESSION['admin_user']))
{
	header('HTTP/1.1 403 Forbidden');
	exit;
}
?>