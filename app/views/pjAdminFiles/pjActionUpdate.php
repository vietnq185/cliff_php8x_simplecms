<?php
if (isset($tpl['status']))
{
	$status = __('status', true);
	switch ($tpl['status'])
	{
		case 2:
			pjUtil::printNotice(NULL, $status[2]);
			break;
	}
} else {
	if (isset($_GET['err']))
	{
		$titles = __('error_titles', true);
		$bodies = __('error_bodies', true);
		$bodies_text = str_replace("{SIZE}", ini_get('post_max_size'), @$bodies[$_GET['err']]);
		pjUtil::printNotice(@$titles[$_GET['err']], $bodies_text);
	}
	
	pjUtil::printNotice(__('infoUpdateFileTitle', true), __('infoUpdateFileDesc', true)); 
	?>
	<form action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminFiles&amp;action=pjActionUpdate" method="post" id="frmUpdateFile" class="form pj-form" autocomplete="off" enctype="multipart/form-data">
		<input type="hidden" name="file_update" value="1" />
		<input type="hidden" name="id" value="<?php echo $tpl['arr']['id'];?>" />
		<p>
			<label class="title"><?php __('lblCurrentFile'); ?></label>
			<span class="inline_block">
				<label class="content"><a href="<?php echo PJ_INSTALL_URL . 'file.php?id='.$tpl['arr']['id'].'&amp;hash=' .$tpl['arr']['hash']; ?>" target="_blank"><?php echo $tpl['arr']['file_name'];?></a></label>
			</span>
		</p>
		<p>
			<label class="title"><?php __('lblURL'); ?></label>
			<span class="inline_block">
				<textarea id="file_path" name="path" class="pj-form-field h60 w550" readonly="readonly"><?php echo PJ_INSTALL_URL . 'file.php?id='.$tpl['arr']['id'].'&amp;hash=' .$tpl['arr']['hash']; ?></textarea>
			</span>
		</p>
		<p>
			<label class="title"><?php __('lblFile'); ?></label>
			<span class="inline_block">
				<input name="file" type="file" class="pj-form-field w350"/>
			</span>
		</p>
		<?php
		if($controller->isAdmin())
		{
			?>
			<p>
				<label class="title"><?php __('lblUsers'); ?></label>
				<span class="inline_block">
					<select name="user_id[]" id="user_id" class="pj-form-field" multiple="multiple" size="5">
						<?php
						foreach ($tpl['user_arr'] as $v)
						{
							?><option value="<?php echo $v['id']; ?>"<?php echo in_array($v['id'], $tpl['arr']['user_ids']) ? ' selected="selected"' : null;?>><?php echo pjSanitize::html($v['name']); ?></option><?php
						}
						?>
					</select>
				</span>
			</p>
			<?php
		} 
		?>
		<p>
			<label class="title">&nbsp;</label>
			<input type="submit" value="<?php __('btnSave'); ?>" class="pj-button" />
			<input type="button" value="<?php __('btnCancel'); ?>" class="pj-button" onclick="window.location.href='<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjAdminFiles&action=pjActionIndex';" />
		</p>
	</form>
	<script type="text/javascript">
		var myLabel = myLabel || {};
		myLabel.select_users = "<?php __('lblSelectUsers');?>";
		myLabel.field_required = "<?php __('lblFieldRequired'); ?>";
		myLabel.extension_message = "<?php __('lblExtensionMessage');?>";
		myLabel.allowed_extension = "<?php echo $tpl['option_arr']['o_extension_allow']; ?>";
	</script>
	<?php
}
?>