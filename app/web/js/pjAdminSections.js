var jQuery_1_8_2 = jQuery_1_8_2 || $.noConflict();
(function ($, undefined) {
	$(function () {
		"use strict";
		var $frmCreateSection = $("#frmCreateSection"),
			$frmUpdateSection = $("#frmUpdateSection"),
			$dialogView = $("#dialogView"),
			$dialogRestore = $("#dialogRestore"),
			dialog = ($.fn.dialog !== undefined),
			multiselect = ($.fn.multiselect !== undefined),
			datagrid = ($.fn.datagrid !== undefined);
		
		if (multiselect) {
			$("#user_id").multiselect({
				noneSelectedText: myLabel.select_users
			});
		}
		
		if ($frmCreateSection.length > 0 || $frmUpdateSection.length > 0) 
		{
			$.validator.addMethod("scmsURL", function(val, elem) {
			    
				if(val != '')
				{
					var regexp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/
					if(!regexp.test(val)) 
					{
						return false;
					} else {
						return true;
					}
				}else{
					return true;
				}
				
			}, myLabel.invalid_url);
		}
		if ($frmCreateSection.length > 0) 
		{
			$frmCreateSection.validate({
				rules: {
					url:{
						scmsURL: true
					}
			    },
				errorPlacement: function (error, element) {
					error.insertAfter(element.parent());
				},
				onkeyup: false,
				errorClass: "err",
				wrapper: "em",
				ignore: ''
			});
			if(myLabel.locale_array.length > 0)
			{
				var locale_array = myLabel.locale_array;
				for(var i = 0; i < locale_array.length; i++)
				{
					var element = $("#i18n_section_name_" + locale_array[i]),
						locale = element.attr('lang');
					element.rules('add', {
						messages: {
					    	required: myLabel.field_required
					    }
					});
				}
			}
		}
		if ($frmUpdateSection.length > 0) {
			$frmUpdateSection.validate({
				rules: {
					url:{
						scmsURL: true
					}
			    },
				errorPlacement: function (error, element) {
					if(element.attr('name') == 'url')
					{
						error.insertAfter(element.parent().parent());
					}else{
						error.insertAfter(element.parent());
					}
				},
				onkeyup: false,
				errorClass: "err",
				wrapper: "em",
				ignore: ''
			});
		}
		
		function setInstallCode() 
		{
			var js_install_code = $('#js_hidden_code').val(),
				php_install_code = $('#php_hidden_code').val(),
				locale = $('#install_locale').val();
			
			if(locale != '')
			{
				js_install_code = js_install_code.replace(/\{LOCALE\}/g, '&locale=' + locale);
				php_install_code = php_install_code.replace(/\{php_LOCALE\}/g, '$pjLocale = ' + locale + '; ');
			}else{
				js_install_code = js_install_code.replace(/\{LOCALE\}/g, '');
				php_install_code = php_install_code.replace(/\{php_LOCALE\}/g, '');
			}
			
			if($("#install_hide").is(":checked"))
			{
				js_install_code = js_install_code.replace(/\{HIDE\}/g, '&hide=1');
				php_install_code = php_install_code.replace(/\{php_HIDE\}/g, '$pjHide = 1; ');
			}else{
				js_install_code = js_install_code.replace(/\{HIDE\}/g, '');
				php_install_code = php_install_code.replace(/\{php_HIDE\}/g, '');
			}
			
			$('#js_install_code').val(js_install_code);
			$('#php_install_code').val(php_install_code);
		}
		
		if($('#js_install_code').length > 0)
		{
			setInstallCode();
		}
		
		function formatDefault (str, obj) {
			if (obj.role_id == 3) {
				return '<a href="#" class="pj-status-icon pj-status-' + (str == 'F' ? '0' : '1') + '" style="cursor: ' +  (str == 'F' ? 'pointer' : 'default') + '"></a>';
			} else {
				return '<a href="#" class="pj-status-icon pj-status-1" style="cursor: default"></a>';
			}
		}
		
		if ($("#grid").length > 0 && datagrid) {
			var gridOpts = {
				buttons: [{type: "edit", url: "index.php?controller=pjAdminSections&action=pjActionUpdate&id={:id}", title: myLabel.edit},
				          {type: "delete", url: "index.php?controller=pjAdminSections&action=pjActionDeleteSection&id={:id}", title: myLabel.delete},
				          {type: "menu", url: "#", text: myLabel.more, items:[
				              {text: myLabel.duplicate, url: "index.php?controller=pjAdminSections&action=pjActionCreate&id={:id}"},
				              {text: myLabel.install, url: "index.php?controller=pjAdminSections&action=pjActionInstall&id={:id}"},
				              {text: myLabel.preview, url: "{:url}", target: '_blank'},
				              {text: myLabel.view, url: "index.php?controller=pjAdminSections&action=pjActionHistory&section_id={:id}"}
				          ]}],
				columns: [{text: myLabel.section, type: "text", sortable: true, editable: true, width: 300, editableWidth: 280},
				          {text: myLabel.last_changed, type: "text", sortable: true, editable: false, width: 150},	
				          {text: myLabel.status, type: "select", sortable: true, editable: true, width: 100, options: [
				                                                                                     {label: myLabel.active, value: "T"}, 
				                                                                                     {label: myLabel.inactive, value: "F"}
				                                                                                     ], applyClass: "pj-status"}],
				dataUrl: "index.php?controller=pjAdminSections&action=pjActionGetSection",
				dataType: "json",
				fields: ['section_name', 'modified', 'status'],
				paginator: {
					actions: [
					   {text: myLabel.delete_selected, url: "index.php?controller=pjAdminSections&action=pjActionDeleteSectionBulk", render: true, confirmation: myLabel.delete_confirmation}
					],
					gotoPage: true,
					paginate: true,
					total: true,
					rowCount: true
				},
				saveUrl: "index.php?controller=pjAdminSections&action=pjActionSaveSection&id={:id}",
				select: {
					field: "id",
					name: "record[]"
				}
			};
			if(pjGrid.isEditor == true)
			{
				gridOpts.buttons = [{type: "edit", url: "index.php?controller=pjAdminSections&action=pjActionUpdate&id={:id}", title: myLabel.edit},
			   				          {type: "delete", url: "index.php?controller=pjAdminSections&action=pjActionDeleteSection&id={:id}", title: myLabel.delete},
							          {type: "menu", url: "#", text: myLabel.more, items:[
							              {text: myLabel.duplicate, url: "index.php?controller=pjAdminSections&action=pjActionCreate&id={:id}"},
							              {text: myLabel.install, url: "index.php?controller=pjAdminSections&action=pjActionInstall&id={:id}"},
							              {text: myLabel.preview, url: "{:url}", target: '_blank'}
							          ]}];
				if(pjGrid.isSectionAllowed == false)
				{
					gridOpts.buttons = [{type: "edit", url: "index.php?controller=pjAdminSections&action=pjActionUpdate&id={:id}", title: myLabel.edit},
				   				          {type: "delete", url: "index.php?controller=pjAdminSections&action=pjActionDeleteSection&id={:id}", title: myLabel.delete},
								          {type: "menu", url: "#", text: myLabel.more, items:[
								              {text: myLabel.install, url: "index.php?controller=pjAdminSections&action=pjActionInstall&id={:id}"},
								              {text: myLabel.preview, url: "{:url}", target: '_blank'}
								          ]}];
				}
			}
			var $grid = $("#grid").datagrid(gridOpts);
		}
		
		if ($("#history_grid").length > 0 && datagrid) {
			
			var gridOpts = {
				buttons: [{type: "view", url: "index.php?controller=pjAdminSections&action=pjActionView&id={:id}&section_id={:section_id}", title: myLabel.view},
				          {type: "edit", url: "index.php?controller=pjAdminSections&action=pjActionUpdate&id={:section_id}", title: myLabel.edit},
				          {type: "delete", url: "index.php?controller=pjAdminSections&action=pjActionDeleteHistory&id={:id}", title: myLabel.delete}
				         ],
				columns: [{text: myLabel.section, type: "text", sortable: true, editable: false, width: 220},
				          {text: myLabel.datetime, type: "text", sortable: true, editable: false, width: 140},
				          {text: myLabel.user, type: "text", sortable: true, editable: false, width: 120},
				          {text: myLabel.ip, type: "text", sortable: true, editable: false, width: 90}],
				dataUrl: "index.php?controller=pjAdminSections&action=pjActionGetHistory" + pjGrid.queryString,
				dataType: "json",
				fields: ['section_name', 'modified', 'name', 'ip'],
				paginator: {
					actions: [
					   {text: myLabel.delete_selected, url: "index.php?controller=pjAdminSections&action=pjActionDeleteHistoryBulk", render: true, confirmation: myLabel.delete_confirmation}
					],
					gotoPage: true,
					paginate: true,
					total: true,
					rowCount: true
				},
				saveUrl: "index.php?controller=pjAdminSections&action=pjActionSaveHistory&id={:id}",
				select: {
					field: "id",
					name: "record[]"
				}
			};
			if(pjGrid.queryString != "")
			{
				gridOpts.buttons = [
				                    {type: "view", url: "index.php?controller=pjAdminSections&action=pjActionView&id={:id}&section_id={:section_id}", title: myLabel.view},
				                    {type: "edit", url: "index.php?controller=pjAdminSections&action=pjActionUpdate&id={:section_id}", title: myLabel.edit},
							        {type: "delete", url: "index.php?controller=pjAdminSections&action=pjActionDeleteHistory&id={:id}", title: myLabel.delete}
		        ];
				gridOpts.columns = [
				          {text: myLabel.datetime, type: "text", sortable: true, editable: false, width: 250},
				          {text: myLabel.user, type: "text", sortable: true, editable: false, width: 200},
				          {text: myLabel.ip, type: "text", sortable: true, editable: false, width: 120}
				];
				gridOpts.fields = ['modified', 'name', 'ip'];
			}
			var $history_grid = $("#history_grid").datagrid(gridOpts);
		}
		
		$(document).on("click", ".btn-all", function (e) {
			if (e && e.preventDefault) {
				e.preventDefault();
			}
			$(this).addClass("pj-button-active").siblings(".pj-button").removeClass("pj-button-active");
			var content = $grid.datagrid("option", "content"),
				cache = $grid.datagrid("option", "cache");
			$.extend(cache, {
				status: "",
				q: ""
			});
			$grid.datagrid("option", "cache", cache);
			$grid.datagrid("load", "index.php?controller=pjAdminSections&action=pjActionGetSection", "created", "DESC", content.page, content.rowCount);
			return false;
		}).on("click", ".btn-filter", function (e) {
			if (e && e.preventDefault) {
				e.preventDefault();
			}
			var $this = $(this),
				content = $grid.datagrid("option", "content"),
				cache = $grid.datagrid("option", "cache"),
				obj = {};
			$this.addClass("pj-button-active").siblings(".pj-button").removeClass("pj-button-active");
			obj.status = "";
			obj[$this.data("column")] = $this.data("value");
			$.extend(cache, obj);
			$grid.datagrid("option", "cache", cache);
			$grid.datagrid("load", "index.php?controller=pjAdminSections&action=pjActionGetSection", "created", "DESC", content.page, content.rowCount);
			return false;
		}).on("submit", ".frm-filter", function (e) {
			if (e && e.preventDefault) {
				e.preventDefault();
			}
			var $this = $(this),
				content = $grid.datagrid("option", "content"),
				cache = $grid.datagrid("option", "cache");
			$.extend(cache, {
				q: $this.find("input[name='q']").val()
			});
			$grid.datagrid("option", "cache", cache);
			$grid.datagrid("load", "index.php?controller=pjAdminSections&action=pjActionGetSection", "created", "DESC", content.page, content.rowCount);
			return false;
		}).on("submit", ".frm-history-filter", function (e) {
			if (e && e.preventDefault) {
				e.preventDefault();
			}
			var $this = $(this),
				content = $grid.datagrid("option", "content"),
				cache = $grid.datagrid("option", "cache");
			$.extend(cache, {
				q: $this.find("input[name='q']").val()
			});
			$grid.datagrid("option", "cache", cache);
			$grid.datagrid("load", "index.php?controller=pjAdminSections&action=pjActionGetHistory", "modified", "DESC", content.page, content.rowCount);
			return false;
		}).on("change", "#section_id", function (e) {
			if($(this).val() == '')
			{
				window.location.href = "index.php?controller=pjAdminSections&action=pjActionHistory";
			}else{
				window.location.href = "index.php?controller=pjAdminSections&action=pjActionHistory&section_id=" + $(this).val();
			}
		}).on("change", "#install_method", function (e) {
			var method = $(this).val();
			
			if(method == 'php')
			{
				$('.scmsPhpBox').show();
				$('.scmsJsBox').hide();
			}else{
				$('.scmsPhpBox').hide();
				$('.scmsJsBox').show();
			}
		}).on("focusin", ".textarea_install", function (e) {
			$(this).select();
		}).on("change", "#install_locale", function (e) {
			setInstallCode();
		}).on("click", "#install_hide", function (e) {
			setInstallCode();
		});
		
		if($('#install_method').length > 0)
		{
			if($('#install_method').val() == 'php')
			{
				$('.scmsPhpBox').show();
				$('.scmsJsBox').hide();
			}else{
				$('.scmsPhpBox').hide();
				$('.scmsJsBox').show();
			}
		}
		if ($dialogView.length > 0 && dialog) 
		{
			$dialogView.dialog({
				modal: true,
				autoOpen: false,
				resizable: false,
				draggable: false,
				width: 650,
				height: 450,
				open: function (event, ui) {
					$.get($dialogView.data('href')).done(function (data) {
						var title = $dialogView.attr('data-title');
						title = title.replace("{DATETIME}", $dialogView.data('datetime'));
						title = title.replace("{USER}", $dialogView.data('user'));
						$dialogView.dialog('option', 'title', title);
						$dialogView.html(data);
					});
					$(".scmsPreviewLink").remove();
					$('<a />', {
		                'class': 'scmsPreviewLink',
		                text: myLabel.preview,
		                href: 'index.php?controller=pjAdminSections&action=pjActionPreviewHistory&id=' + $dialogView.data('id'),
		                target: '_blank'
		            })
		            .appendTo($(".ui-dialog-buttonpane"));
				},
				buttons: (function () {
					var buttons = {};
					buttons[scApp.locale.button.restore] = function () {
						var restore_href = $dialogView.data('href');
						restore_href = restore_href.replace('pjActionView', 'pjActionRestore');
						$dialogRestore.data('href', restore_href).dialog("open");
					};
					buttons[scApp.locale.button.close] = function () {
						$dialogView.dialog("close");
					};
					
					return buttons;
				})()
			});
		}
		if ($dialogRestore.length > 0 && dialog) 
		{
			$dialogRestore.dialog({
				modal: true,
				autoOpen: false,
				resizable: false,
				draggable: false,
				width: 450,
				height: 150,
				open: function () {
					
				},
				buttons: (function () {
					var buttons = {};
					buttons[scApp.locale.button.yes] = function () {
						$.get($dialogRestore.data('href')).done(function (data) {
							$dialogRestore.dialog("close");
						});
					};
					buttons[scApp.locale.button.no] = function () {
						$dialogRestore.dialog("close");
					};
					return buttons;
				})()
			});
		}
		$('#history_grid').on("click", '.pj-table-icon-view', function(e){
			if (e && e.preventDefault) {
				e.preventDefault();
			}
			var i = 0;
			$(this).parent().siblings().each(function(e){
				if(i == 0)
				{
					$dialogView.data('id', $(this).find("input.pj-table-select-row").val());
				}
				if(i == 1)
				{
					$dialogView.data('datetime', $(this).find(">:first-child").html());
				}
				if(i == 2)
				{
					$dialogView.data('user', $(this).find(">:first-child").html());
				}
				i++;
			});
			$dialogView.data('href', $(this).attr('href')).dialog("open");
			return false;
		});
		
		if ($frmCreateSection.length > 0 || $frmUpdateSection.length > 0) 
		{			
			tinymce.init({
			    selector: "textarea.mceEditor",
			    theme: "modern",
			    width: 550,
			    height: 400,
			    relative_urls: false,
			    remove_script_host: false,
			    plugins: [
			         "advlist autolink link image lists charmap print preview hr anchor pagebreak",
			         "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
			         "save table contextmenu directionality emoticons template paste textcolor"
		        ],
		        toolbar: "insertfile undo redo | styleselect | fontselect | fontsizeselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | print preview media fullpage | forecolor backcolor emoticons",
		        image_advtab: true,
			    menubar: "file edit insert view table tools",
			    external_filemanager_path: myLabel.filemanager_path,
			    filemanager_title: "Responsive Filemanager" ,
			    external_plugins: {
			    	"filemanager": "../../filemanager/" + myLabel.filemanager_version + "/plugin.min.js"
			    },
			});
		}
	});
})(jQuery_1_8_2);