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
			<?php
			if($controller->isAdmin())
			{ 
				?>
				<li class="ui-state-default ui-corner-top"><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminSections&amp;action=pjActionHistory"><?php __('lblChanges'); ?></a></li>
				<?php
			} 
			?>
			<li class="ui-state-default ui-corner-top ui-tabs-active ui-state-active"><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminSections&amp;action=pjActionInstall&amp;id=<?php echo $tpl['arr']['id'];?>"><?php __('lblInstall'); ?></a></li>
		</ul>
	</div>
	
	<?php 
	pjUtil::printNotice(__('infoInstallSectionTitle', true, false), __('infoInstallSectionDesc', true, false)); 
	if($tpl['arr']['status'] == 'T')
	{
	?>
	
	<form id="frmInstallSection" class="form pj-form" autocomplete="off">
	
		<p><span class="inline_block"><label class="content"><?php __('lblInstallNote');?>: <b><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminSections&amp;action=pjActionUpdate&amp;id=<?php echo $tpl['arr']['id'];?>"><?php echo pjSanitize::html($tpl['arr']['section_name']);?></a></b></label></span></p>
		
		<fieldset class="fieldset white">
			<legend><?php __('lblInstallConfig'); ?></legend>
			<p>
				<label class="title"><?php __('lblInstallMethod'); ?></label>
				<span class="inline_block">
					<select name="install_method" id="install_method" class="pj-form-field w150">
						<?php
						foreach (__('install_methods', true, false) as $k => $v)
						{
							?><option value="<?php echo $k; ?>"><?php echo stripslashes($v); ?></option><?php
						}
						?>
					</select>
				</span>
			</p>
			<?php
			if(count($tpl['locale_arr']) > 1)
			{ 
				?>
				<p>
					<label class="title"><?php __('lblSelectLanguage'); ?></label>
					<select class="pj-form-field w200 pj-install-config" id="install_locale" name="install_locale">
						<option value="">-- <?php __('lblAll'); ?> --</option>
						<?php
						foreach ($tpl['locale_arr'] as $locale)
						{
							?><option value="<?php echo $locale['id']; ?>"><?php echo pjSanitize::html($locale['title']); ?></option><?php
						}
						?>
					</select>					
				</p>
				<p>
					<label class="title"><?php __('lblLanguageHide'); ?></label>
					<span class="left">
						<input type="checkbox" id="install_hide" name="install_hide" value="1" />
					</span>
				</p>
				<?php
			}else{
				?>
				<input type="hidden" id="install_locale" name="install_locale" value="" />
				<?php
			}  
			?>
		</fieldset>
		<div class="scmsJsBox">
			<p style="margin: 20px 0 7px; font-weight: bold"><?php __('lblInstallJsNote'); ?></p>
			<textarea id="js_install_code" class="pj-form-field textarea_install" style="overflow: auto; height:60px; width: 728px;"></textarea>
		</div>
		<div class="scmsPhpBox">
			<p style="margin: 20px 0 7px; font-weight: bold"><?php __('lblInstallPhpStep1'); ?></p>
			<textarea class="pj-form-field textarea_install" style="overflow: auto; height:40px; width: 728px;">&lt;?php ob_start(); ?&gt;</textarea>
			<p style="margin: 20px 0 7px; font-weight: bold"><?php __('lblInstallPhpStep2'); ?></p>
			<textarea class="pj-form-field textarea_install" style="overflow: auto; height:40px; width: 728px;">{SCMS_CONTENT_<?php echo $tpl['arr']['id'];?>}</textarea>
			<p style="margin: 20px 0 7px; font-weight: bold"><?php __('lblInstallPhpStep3'); ?></p>
			<textarea id="php_install_code" class="pj-form-field textarea_install" style="overflow: auto; height:60px; width: 728px;"></textarea>
		</div>
		<textarea id="js_hidden_code" class="pj-form-field textarea_install" style="overflow: auto; height:80px; width: 728px;display:none;">&lt;link href="<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjFront&action=pjActionLoadCss" type="text/css" rel="stylesheet" /&gt;
&lt;script type="text/javascript" src="<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjFront&action=pjActionLoad&id=<?php echo $tpl['arr']['id'];?>{LOCALE}{HIDE}"&gt;&lt;/script&gt;</textarea>
		<textarea id="php_hidden_code" class="pj-form-field textarea_install" style="overflow: auto; height:80px; width: 728px;display:none;">&lt;?php $pjSimpleCMS = <?php echo $tpl['arr']['id'];?>; {php_LOCALE}{php_HIDE}include '<?php echo dirname($_SERVER['SCRIPT_FILENAME']); ?>/app/views/pjLayouts/pjActionLoad.php'; ?&gt;</textarea>
	</form>
	<?php
	}else{
		$note = __('lblInactiveSectionNote', true);
		$section_link = '<b><a href="'.$_SERVER['PHP_SELF'].'?controller=pjAdminSections&amp;action=pjActionUpdate&amp;id='.$tpl['arr']['id'].'">'.pjSanitize::html($tpl['arr']['section_name']).'</a></b>';
		$note = str_replace("{SECTION}", $section_link, $note);
		?><p><span class="inline_block"><label class="content"><?php echo $note;?></label></span></p><?php
	}
}
?>