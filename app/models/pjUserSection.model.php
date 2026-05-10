<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjUserSectionModel extends pjAppModel
{
	protected $table = 'users_sections';
	
	protected $schema = array(
		array('name' => 'user_id', 'type' => 'int', 'default' => ':NULL'),
		array('name' => 'section_id', 'type' => 'int', 'default' => ':NULL')
	);
	
	public static function factory($attr=array())
	{
		return new pjUserSectionModel($attr);
	}
}
?>