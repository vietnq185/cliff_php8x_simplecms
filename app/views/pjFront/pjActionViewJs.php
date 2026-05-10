<?php
if(isset($tpl['arr']) && $tpl['arr']['status'] == 'T')
{ 
	?>
	<div class="scmsHeader">
		<?php
		include PJ_VIEWS_PATH . 'pjFront/elements/locale_js.php'; 
		?>
	</div>
	<div class="scmsSectionContent">
		<?php echo $tpl['arr']['section_content'];?>
	</div>
	<?php
} 
?>