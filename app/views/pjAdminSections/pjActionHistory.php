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
	?>
	<div class="ui-tabs ui-widget ui-widget-content ui-corner-all b10">
		<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
			<li class="ui-state-default ui-corner-top"><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminSections&amp;action=pjActionIndex"><?php __('menuSections'); ?></a></li>
			<li class="ui-state-default ui-corner-top ui-tabs-active ui-state-active"><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminSections&amp;action=pjActionHistory"><?php __('lblChanges'); ?></a></li>
		</ul>
	</div>
	
	<?php 
	pjUtil::printNotice(__('infoSectionHistoryTitle', true, false), __('infoSectionHistoryDesc', true, false));
	
	if(!empty($tpl['arr']))
	{ 
		?>
		<p class="b10">
			<span class="inline-block">
				<label class="content r10"><?php __('lblFilterBySection');?>:</label>
				<select id="section_id" name="section_id" class="pj-form-field w200">
					<option value="">-- <?php __('lblAll'); ?> --</option>
					<?php
					foreach($tpl['arr'] as $v)
					{
						?>
						<option value="<?php echo $v['id']?>"<?php echo isset($_GET['section_id']) ? ($_GET['section_id'] == $v['id'] ? ' selected="selected"' : null) : null ;?>><?php echo pjSanitize::html($v['section_name']);?></option>
						<?php
					} 
					?>
				</select>
			</span>
		</p>
		<?php
	} 
	?>
	
	<div id="history_grid"></div>
	
	<div id="dialogView" style="display: none" title="" data-title="<?php __('lblSectionContent');?>"></div>
	<div id="dialogRestore" style="display: none" title="<?php __('lblRestoreSection');?>"><?php __('lblRestoreConfirmation');?></div>
	
	<script type="text/javascript">
	var pjGrid = pjGrid || {};
	pjGrid.queryString = "";
	<?php
	if (isset($_GET['section_id']) && (int) $_GET['section_id'] > 0)
	{
		?>pjGrid.queryString += "&section_id=<?php echo (int) $_GET['section_id']; ?>";<?php
	}
	?>
	var myLabel = myLabel || {};
	myLabel.section = "<?php __('lblSection'); ?>";
	myLabel.datetime = "<?php __('lblDateTime'); ?>";
	myLabel.user = "<?php __('lblUser'); ?>";
	myLabel.ip = "<?php __('lblIpAddress'); ?>";
	myLabel.view = "<?php __('lblView'); ?>";
	myLabel.restore = "<?php __('lblRestore'); ?>";
	myLabel.edit = "<?php __('lblEdit'); ?>";
	myLabel.delete = "<?php __('lblDelete'); ?>";
	myLabel.preview = "<?php __('lblPreviewNewInWindow'); ?>";
	myLabel.delete_selected = "<?php __('delete_selected'); ?>";
	myLabel.delete_confirmation = "<?php __('delete_confirmation'); ?>";
	</script>
	<?php
}
?>