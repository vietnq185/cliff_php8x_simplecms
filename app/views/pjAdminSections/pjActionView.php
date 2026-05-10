<?php
foreach ($tpl['lp_arr'] as $v)
{
	?>
	<div class="section-box">
		<?php
		if(count($tpl['lp_arr']) > 1)
		{ 
			?>
			<label class="section-heading"><?php echo pjSanitize::clean($v['title']);?></label>
			<?php
		} 
		?>
		<div class="section-content">
			<?php echo !empty($tpl['arr']['i18n'][$v['id']]['section_content']) ? stripslashes(@$tpl['arr']['i18n'][$v['id']]['section_content']) : ''; ?>
		</div>
	</div>
	<?php
}
?>
