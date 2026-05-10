<?php
if (isset($tpl['locale_arr']) && is_array($tpl['locale_arr']) && !empty($tpl['locale_arr']))
{
	if(count($tpl['locale_arr']) > 1)
	{
		?>
		<div class="scmsLocale">
			<ul class="scmsLocaleMenu"><?php
			$locale_id = $controller->pjActionGetLocale();
			foreach ($tpl['locale_arr'] as $locale)
			{
				$flag_url = PJ_INSTALL_URL . 'core/framework/libs/pj/img/flags/' . $locale['file'];
				if(!empty($locale['flag']) && file_exists(PJ_INSTALL_PATH . $locale['flag']))
				{
					$flag_url = PJ_INSTALL_URL . $locale['flag'];
				}
				?><li><a href="#" class="scmsSelectorLocale<?php echo $locale_id == $locale['id'] ? ' scmsLocaleFocus' : NULL; ?>" data-id="<?php echo $locale['id']; ?>" title="<?php echo pjSanitize::html($locale['title']); ?>"><img src="<?php echo $flag_url; ?>" alt="<?php echo htmlspecialchars($locale['title']); ?>" /></a></li><?php
			}
			?>
			</ul>
		</div>
		<?php
	}
}
?>