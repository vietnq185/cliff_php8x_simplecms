<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjHistoryModel extends pjAppModel
{
	protected $primaryKey = 'id';
	
	protected $table = 'histories';
	
	protected $schema = array(
		array('name' => 'id', 'type' => 'int', 'default' => ':NULL'),
		array('name' => 'user_id', 'type' => 'int', 'default' => ':NULL'),
		array('name' => 'section_id', 'type' => 'int', 'default' => ':NULL'),
		array('name' => 'modified', 'type' => 'datetime', 'default' => ':NOW()'),
		array('name' => 'ip', 'type' => 'varchar', 'default' => ':NULL')
	);
	
	public $i18n = array('section_name', 'section_content');
	
	public static function factory($attr=array())
	{
		return new pjHistoryModel($attr);
	}
}
?>