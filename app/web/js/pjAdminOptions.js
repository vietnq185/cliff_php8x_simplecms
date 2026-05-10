var jQuery_1_8_2 = jQuery_1_8_2 || $.noConflict();
(function ($, undefined) {
	$(function () {
		"use strict";
		var tabs = ($.fn.tabs !== undefined),
			$tabs = $("#tabs"),
			tOpt = {
				select: function (event, ui) {
					$(":input[name='tab_id']").val(ui.panel.id);
				}
			};
		
		if ($tabs.length > 0 && tabs) {
			$tabs.tabs(tOpt);
		}
		$(".field-int").spinner({
			min: 0
		});
		
		function setInstall()
		{
			var clone = $('#pj_install_clone').text(),
				locale = $('#install_locale').val(),
				rel = $('#pj_preview_install').attr('rel');
			
			if(locale == '')
			{
				clone = clone.replace(/\{LOCALE\}/g, '');
			}else{
				clone = clone.replace(/\{LOCALE\}/g, '&locale=' + locale);
			}
			if(locale == '')
			{
				rel = rel.replace(/\{LOCALE\}/g, '');
			}else{
				rel = rel.replace(/\{LOCALE\}/g, '&locale=' + locale);
			}
			$('#install_code').val(clone);
			$('#pj_preview_install').attr('href', rel);
		}
		if($('#install_code').length > 0)
		{
			setInstall();
		}
		
		$("#content").on("focusin", ".textarea_install", function (e) {
			$(this).select();
		}).on("change", "select[name='value-enum-o_send_email']", function (e) {
			switch ($("option:selected", this).val()) {
			case 'mail|smtp::mail':
				$(".boxSmtp").hide();
				break;
			case 'mail|smtp::smtp':
				$(".boxSmtp").show();
				break;
			}
		}).on("change", ".pj-install-config", function (e) {
			setInstall();
		});
	});
})(jQuery_1_8_2);