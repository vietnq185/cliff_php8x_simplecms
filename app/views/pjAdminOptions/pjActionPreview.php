<!DOCTYPE html>
<html>
	<head>
		<title>Simple CMS - Preview</title>
	<head>
	<body>
		<div style="max-width: 1024px;">
			<link href="<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjFront&action=pjActionLoadCss" type="text/css" rel="stylesheet" />
			<script type="text/javascript" src="<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjFront&action=pjActionLoad<?php echo isset($_GET['locale']) ? '&locale=' . $_GET['locale'] : null;?>"></script>		
		</div>
	</body>
</html>