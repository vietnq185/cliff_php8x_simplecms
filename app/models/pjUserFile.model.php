<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjUserFileModel extends pjAppModel
{
	protected $table = 'users_files';
	
	protected $schema = array(
		array('name' => 'user_id', 'type' => 'int', 'default' => ':NULL'),
		array('name' => 'file_id', 'type' => 'int', 'default' => ':NULL')
	);
	
	public static function factory($attr=array())
	{
		return new pjUserFileModel($attr);
	}
}
?>