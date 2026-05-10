<?php
if (!defined("ROOT_PATH"))
{
	define("ROOT_PATH", dirname(__FILE__) . '../');
}
include 'options.inc.php';
$config['java_upload'] = false;
$config['upload_dir'] = PJ_INSTALL_FOLDER . PJ_UPLOAD_PATH . 'tinymce-source/';
$config['current_path'] = '../../../../' . PJ_UPLOAD_PATH . 'tinymce-source/';
$config['thumbs_base_path'] = '../../../../' . PJ_UPLOAD_PATH . 'tinymce-thumbs/';
?>