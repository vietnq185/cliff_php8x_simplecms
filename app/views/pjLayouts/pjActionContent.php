<?php
foreach ($controller->getCss() as $css)
{
	echo '<link type="text/css" rel="stylesheet" href="'.(isset($css['remote']) && $css['remote'] ? NULL : PJ_INSTALL_URL).$css['path'].$css['file'].'" />';
}
require $content_tpl;
?>