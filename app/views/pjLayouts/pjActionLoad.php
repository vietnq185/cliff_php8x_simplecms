<?php
if (!isset($_GET['iframe']))
{
	$content = ob_get_contents();
	ob_end_clean();
	ob_start();
}
if (!isset($_GET['controller']) || empty($_GET['controller']))
{
	$_GET["controller"] = "pjFront";
}
if (!isset($_GET['action']) || empty($_GET['action']))
{
	$_GET["action"] = "pjActionViewPhp";
}
$_GET["id"] = $pjSimpleCMS;
if(isset($pjHide))
{
	$_GET["hide"] = 1;
}
if(isset($pjLocale))
{
	$_GET["locale"] = $pjLocale;
}
$dirname = str_replace("\\", "/", dirname(__FILE__));
include str_replace("app/views/pjLayouts", "", $dirname) . '/ind'.'ex.php';


if (!isset($_GET['iframe']))
{
	$app = ob_get_contents();
	ob_end_clean();
	ob_start();
	$app = str_replace('$','&#36;',$app);
	echo preg_replace('/\{SCMS_CONTENT_'.$pjSimpleCMS.'\}/', $app, $content);
}
?>