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
	
	pjUtil::printNotice(__('infoUploadFileTitle', true), __('infoUploadFileDesc', true)); 
	?>
	<form action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminFiles&amp;action=pjActionCreate" method="post" id="frmCreateFile" class="form pj-form" autocomplete="off" enctype="multipart/form-data">
		<input type="hidden" name="file_create" value="1" />
		<p>
			<label class="title"><?php __('lblFile'); ?></label>
			<span class="inline_block">
				<input name="file" type="file" class="pj-form-field required w350"/>
			</span>
		</p>
		<?php
		if($controller->isAdmin())
		{
			if(!empty($tpl['user_arr']))
			{
				?>
				<p>
					<label class="title"><?php __('lblUsers'); ?></label>
					<span class="inline_block">
						<select name="user_id[]" id="user_id" class="pj-form-field" multiple="multiple" size="5">
							<?php
							foreach ($tpl['user_arr'] as $v)
							{
								?><option value="<?php echo $v['id']; ?>"><?php echo stripslashes($v['name']); ?></option><?php
							}
							?>
						</select>
					</span>
				</p>
				<?php
			}else{
				?>
				<p>
					<label class="title"><?php __('lblUsers'); ?></label>
					<span class="inline_block">
						<label class="content"><?php __('lblNoAvailableUsers'); ?> <a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminUsers&amp;action=pjActionCreate"><?php __('lblHere'); ?></a>.</label>
					</span>
				</p>
				<?php
			}
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