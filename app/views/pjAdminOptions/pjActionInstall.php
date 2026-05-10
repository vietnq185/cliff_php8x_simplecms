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
	?>
	<div id="tabs">
		<ul>
			<li><a href="#tabs-1"><?php __('menuInstall'); ?></a></li>
		</ul>
		<div id="tabs-1">
			<?php pjUtil::printNotice(__('lblInstallJs1_title', true), __('lblInstallJs1_body', true), false, false); ?>

			<form action="" method="get" class="pj-form form">
				<fieldset class="fieldset white">
					<legend><?php __('lblInstallConfig'); ?></legend>
					<p>
						<label class="title"><?php __('lblInstallConfigLocale'); ?></label>
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
						<label class="title">&nbsp;</label>
						<a id="pj_preview_install" target="_blank" href="javascript:void(0);" class="pj-button" rel="<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjAdminOptions&action=pjActionPreview{LOCALE}"/><?php __('btnPreview'); ?></a>
					</p>
				</fieldset>
			</form>
			
			<p style="margin: 20px 0 7px; font-weight: bold"><?php __('lblInstallJs1_1'); ?></p>
			<textarea class="pj-form-field textarea_install" id="install_code" style="overflow: auto; height:80px; width: 728px;"></textarea>

			<div style="display:none" id="pj_install_clone">&lt;link href="<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjFront&action=pjActionLoadCss" type="text/css" rel="stylesheet" /&gt;
&lt;script type="text/javascript" src="<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjFront&action=pjActionLoad{LOCALE}"&gt;&lt;/script&gt;</div>
		</div>
	</div>
	<?php
}
?>