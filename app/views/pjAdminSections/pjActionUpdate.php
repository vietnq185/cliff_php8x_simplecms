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
	<div class="ui-tabs ui-widget ui-widget-content ui-corner-all b10">
		<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
			<li class="ui-state-default ui-corner-top"><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminSections&amp;action=pjActionIndex"><?php __('menuSections'); ?></a></li>
			<?php
			if ($controller->isAdmin() || ($controller->isEditor() && $controller->isSectionAllowed()))
			{ 
				?>
				<li class="ui-state-default ui-corner-top"><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminSections&amp;action=pjActionCreate"><?php __('lblAddSection'); ?></a></li>
				<?php
			} 
			?>
			<li class="ui-state-default ui-corner-top ui-tabs-active ui-state-active"><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminSections&amp;action=pjActionUpdate&amp;id=<?php echo $tpl['arr']['id'];?>"><?php __('lblUpdateSection'); ?></a></li>
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
	
	<?php 
	pjUtil::printNotice(__('infoUpdateSectionTitle', true, false), __('infoUpdateSectionDesc', true, false)); 
	if ((int) $tpl['option_arr']['o_multi_lang'] === 1 && count($tpl['lp_arr']) > 1)
	{
		?><div class="multilang"></div><?php
	} 
	?>
	
	<form action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminSections&amp;action=pjActionUpdate" method="post" id="frmUpdateSection" class="form pj-form" autocomplete="off">
		<input type="hidden" name="section_update" value="1" />
		<input type="hidden" name="id" value="<?php echo $tpl['arr']['id'];?>" />
		<p>
			<label class="title"><?php __('lblLastChanged'); ?></label>
			<span class="inline_block">
				<label class="content">
				<?php
				if($tpl['arr']['changes'] > 0)
				{ 
					$all_changes = str_replace("{cnt}", $tpl['arr']['changes'], __('lblViewAllChanges', true, false));
					$_arr = array();
					$_arr[] = pjUtil::formatDate(date('Y-m-d', strtotime($tpl['arr']['modified'])), 'Y-m-d', $tpl['option_arr']['o_date_format']) . ', ' . pjUtil::formatTime(date('H:i:s', strtotime($tpl['arr']['modified'])), 'H:i:s', $tpl['option_arr']['o_time_format']);
					$_arr[] = __('lblBy', true, false);
					$_arr[] = $tpl['history_arr']['name'];
					if($controller->isAdmin())
					{
						$_arr[] = ' (<a href="'. $_SERVER['PHP_SELF'] .'?controller=pjAdminSections&amp;action=pjActionHistory&amp;section_id='.$tpl['arr']['id'].'">' . ($tpl['arr']['changes'] != 1 ? $all_changes : __('lblOneChange', true, false)) .'</a>)';
					} 
					echo join(' ', $_arr);
				}else{
					__('lblNA');
				}
				?>
			</label>
			</span>
		</p>
		<?php
		foreach ($tpl['lp_arr'] as $v)
		{
			$flag_url = PJ_INSTALL_URL . PJ_FRAMEWORK_LIBS_PATH . 'pj/img/flags/' . $v['file'];
			if(!empty($v['flag']) && file_exists(PJ_INSTALL_PATH . $v['flag']))
			{
				$flag_url = PJ_INSTALL_URL . $v['flag'];
			}
			?>
			<p class="pj-multilang-wrap" data-index="<?php echo $v['id']; ?>" style="display: <?php echo (int) $v['is_default'] === 0 ? 'none' : NULL; ?>">
				<label class="title"><?php __('lblSection'); ?></label>
				<span class="inline_block">
					<input type="text" id="i18n_section_name_<?php echo $v['id'];?>" name="i18n[<?php echo $v['id']; ?>][section_name]" class="pj-form-field w300<?php echo (int) $v['is_default'] === 0 ? NULL : ' required'; ?>" value="<?php echo pjSanitize::html(@$tpl['arr']['i18n'][$v['id']]['section_name']); ?>" lang="<?php echo $v['id']; ?>" />
					<?php if ((int) $tpl['option_arr']['o_multi_lang'] === 1 && count($tpl['lp_arr']) > 1) : ?>
					<span class="pj-multilang-input"><img src="<?php echo $flag_url; ?>" alt="" /></span>
					<?php endif; ?>
				</span>
			</p>
			<?php
		}
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
								?><option value="<?php echo $v['id']; ?>"<?php echo in_array($v['id'], $tpl['arr']['user_ids']) ? ' selected="selected"' : null;?>><?php echo pjSanitize::html($v['name']); ?></option><?php
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
		foreach ($tpl['lp_arr'] as $v)
		{
			$flag_url = PJ_INSTALL_URL . PJ_FRAMEWORK_LIBS_PATH . 'pj/img/flags/' . $v['file'];
			if(!empty($v['flag']) && file_exists(PJ_INSTALL_PATH . $v['flag']))
			{
				$flag_url = PJ_INSTALL_URL . $v['flag'];
			}
			?>
			<p class="pj-multilang-wrap" data-index="<?php echo $v['id']; ?>" style="display: <?php echo (int) $v['is_default'] === 0 ? 'none' : NULL; ?>">
				<label class="title"><?php __('lblContent'); ?></label>
				<span class="inline_block">
					<span class="block float_left r5">
						<textarea name="i18n[<?php echo $v['id']; ?>][section_content]" class="mceEditor" lang="<?php echo $v['id']; ?>" ><?php echo isset($tpl['arr']['i18n'][$v['id']]['section_content']) && !empty($tpl['arr']['i18n'][$v['id']]['section_content']) ? htmlspecialchars(stripslashes(@$tpl['arr']['i18n'][$v['id']]['section_content'])) : ''; ?></textarea>
					</span>
					<?php if ((int) $tpl['option_arr']['o_multi_lang'] === 1 && count($tpl['lp_arr']) > 1) : ?>
					<span class="pj-multilang-input"><img src="<?php echo $flag_url; ?>" alt="" /></span>
					<?php endif; ?>
				</span>
			</p>
			<?php
		}
		?>
		<p>
			<label class="title">&nbsp;</label>
			<span class="block overflow">
				<label class="content">
				<?php
				$url_text = __('lblURLText', true, false); 
				$url_text = str_replace("{STAG}", '<a href="'.$_SERVER['PHP_SELF'].'?controller=pjAdminSections&amp;action=pjActionInstall&amp;id='.$tpl['arr']['id'].'">', $url_text);
				$url_text = str_replace("{ETAG}", '</a>', $url_text);
				echo $url_text;
				?>
				</label>
			</span>	
		</p>
		<p>
			<label class="title"><?php __('lblURL'); ?></label>
			<span class="inline_block">
				<span class="pj-form-field-custom pj-form-field-custom-before float_left r10">
					<span class="pj-form-field-before"><abbr class="pj-form-field-icon-url"></abbr></span>
					<input type="text" name="url" id="url" class="pj-form-field w400 r10" value="<?php echo pjSanitize::clean($tpl['arr']['url']);?>" />
				</span>
				<?php
				if(!empty($tpl['arr']['url']))
				{ 
					?>
					<span class="content float_left"><a href="<?php echo pjSanitize::clean($tpl['arr']['url']);?>" target="_blank"><?php __('lblOpenPage');;?></a></span>
					<?php
				} 
				?>
			</span>
		</p>
		<p>
			<label class="title"><?php __('lblStatus'); ?></label>
			<span class="inline_block">
				<select name="status" id="status" class="pj-form-field required">
					<option value="">-- <?php __('lblChoose'); ?>--</option>
					<?php
					foreach (__('u_statarr', true) as $k => $v)
					{
						?><option value="<?php echo $k; ?>"<?php echo $tpl['arr']['status'] == $k ? ' selected="selected"' : null;?>><?php echo $v; ?></option><?php
					}
					?>
				</select>
			</span>
		</p>
		<p>
			<label class="title">&nbsp;</label>
			<input type="submit" value="<?php __('btnSave'); ?>" class="pj-button" />
		</p>
	
	</form>
	
	<script type="text/javascript">
	var myLabel = myLabel || {};
	myLabel.filemanager_version = '<?php echo $tpl['filemanager_version']; ?>';
	myLabel.filemanager_path = '<?php echo $tpl['filemanager_path']; ?>';
	myLabel.select_users = "<?php __('lblSelectUsers');?>";
	myLabel.field_required = "<?php __('lblFieldRequired'); ?>";
	myLabel.invalid_url = "<?php __('lblInvalidUrl');?>";
	var locale_array = new Array(); 
	<?php
	foreach ($tpl['lp_arr'] as $v)
	{
		?>locale_array.push(<?php echo $v['id'];?>);<?php
	} 
	?>
	myLabel.locale_array = locale_array;
	<?php 
	if ((int) $tpl['option_arr']['o_multi_lang'] === 1 && count($tpl['lp_arr']) > 1)
	{ 
		?>
		var pjLocale = pjLocale || {};
		pjLocale.langs = <?php echo $tpl['locale_str']; ?>;
		pjLocale.flagPath = "<?php echo PJ_FRAMEWORK_LIBS_PATH; ?>pj/img/flags/";
		(function ($) {
			$(function() {
				$(".multilang").multilang({
					langs: pjLocale.langs,
					flagPath: pjLocale.flagPath,
					select: function (event, ui) {
						
					}
				}).multilangFix();
			});
		})(jQuery_1_8_2);
		<?php
	} 
	?>
	</script>
	<?php
}
?>