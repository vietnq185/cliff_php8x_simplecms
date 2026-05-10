<?php
require $content_tpl;
$content = ob_get_contents();
ob_end_clean();

$content = preg_replace('/\r\n|\n|\t/', '', $content);
$content = str_replace("'", "\"", $content);

$pattern = '|<script.*>(.*)</script>|';
if (preg_match($pattern, $content, $matches))
{
	$content = preg_replace($pattern, '', $content);
}
?>
(function () {
	var element = null;
	var scripts = document.getElementsByTagName("script");
	for (var i = 0; i < scripts.length; i++) 
	{
		if (scripts[i].src.indexOf("<?php echo PJ_INSTALL_FOLDER;?>index.php?controller=pjFront&action=pjActionLoad&id=<?php echo @$_GET['id']; ?>") != -1)
		{
			element = scripts[i];
		}
	}
	var div = document.createElement('div');
	div.innerHTML = '<?php echo $content;?>';
	if(element != null)
	{
		element.parentNode.insertBefore(div, element);
	}else{
		document.body.appendChild(div);
	}
	<?php
	if ($matches)
	{
		?>
		var script = document.createElement('script');
		script.text = '<?php echo $matches[1];?>';
		if(element != null)
		{
			element.parentNode.insertBefore(script, element);
		}else{
			document.body.appendChild(script);
		}
		<?php
	}
	?>
})();