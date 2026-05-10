<?php
if(isset($tpl['arr']) && $tpl['arr']['status'] == 'T')
{ 
	?>
	<div class="scmsContainer">
		<div class="scmsHeader">
			<?php
			include PJ_VIEWS_PATH . 'pjFront/elements/locale_php.php'; 
			?>
		</div>
		<div class="scmsSectionContent">
			<?php echo $tpl['arr']['section_content'];?>
		</div>
	</div>
	<?php
} 
?>