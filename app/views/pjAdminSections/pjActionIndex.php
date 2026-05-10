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
	$titles = __('error_titles', true);
	$bodies = __('error_bodies', true);
	if (isset($_GET['err']))
	{
		pjUtil::printNotice(@$titles[$_GET['err']], @$bodies[$_GET['err']]);
	}
	$filter = __('filter', true, false);
	?>
	<div class="ui-tabs ui-widget ui-widget-content ui-corner-all b10">
		<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
			<li class="ui-state-default ui-corner-top ui-tabs-active ui-state-active"><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminSections&amp;action=pjActionIndex"><?php __('menuSections'); ?></a></li>
			<?php
			if($controller->isAdmin())
			{ 
				?>
				<li class="ui-state-default ui-corner-top"><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminSections&amp;action=pjActionHistory"><?php __('lblChanges'); ?></a></li>
				<?php
			} 
			?>
		</ul>
	</div>
	
	<?php pjUtil::printNotice(__('infoSectionsTitle', true, false), __('infoSectionsDesc', true, false)); ?>
	<div class="b10">
		<?php
		if ($controller->isAdmin() || ($controller->isEditor() && $controller->isSectionAllowed()))
		{ 
			?>
			<form action="<?php echo $_SERVER['PHP_SELF']; ?>" method="get" class="float_left pj-form r10">
				<input type="hidden" name="controller" value="pjAdminSections" />
				<input type="hidden" name="action" value="pjActionCreate" />
				<input type="submit" class="pj-button" value="<?php __('btnAddSection'); ?>" />
			</form>
			<?php
		} 
		?>
		<form action="" method="get" class="float_left pj-form frm-filter">
			<input type="text" name="q" class="pj-form-field pj-form-field-search w150" placeholder="<?php __('btnSearch'); ?>" />
		</form>
		<br class="clear_both" />
	</div>
	<div id="grid"></div>
	
	<script type="text/javascript">
	var pjGrid = pjGrid || {};
	pjGrid.isEditor = <?php echo $controller->isEditor() ? 'true' : 'false'; ?>;
	pjGrid.isSectionAllowed = <?php echo $controller->isSectionAllowed() ? 'true' : 'false'; ?>;
	var myLabel = myLabel || {};
	myLabel.section = "<?php __('lblSection'); ?>";
	myLabel.last_changed = "<?php __('lblLastChanged'); ?>";
	myLabel.more = "<?php __('lblMore'); ?>";
	myLabel.install = "<?php __('lblInstallCode'); ?>";
	myLabel.duplicate = "<?php __('lblDuplicateSection'); ?>";
	myLabel.preview = "<?php __('lblPreviewWebPage'); ?>";
	myLabel.view = "<?php __('lblViewChanges'); ?>";
	myLabel.edit = "<?php __('lblEdit'); ?>";
	myLabel.delete = "<?php __('lblDelete'); ?>";
	myLabel.status = "<?php __('lblStatus'); ?>";
	myLabel.active = "<?php echo $filter['active']; ?>";
	myLabel.inactive = "<?php echo $filter['inactive']; ?>";
	myLabel.delete_selected = "<?php __('delete_selected'); ?>";
	myLabel.delete_confirmation = "<?php __('delete_confirmation'); ?>";
	</script>
	<?php
}
?>