var scApp = scApp || {};
var jQuery_1_8_2 = jQuery_1_8_2 || $.noConflict();
(function ($, undefined) {
	$(function () {
		"use strict";
		$(".pj-table tbody tr").hover(
			function () {
				$(this).addClass("pj-table-row-hover");
			}, 
			function () {
				$(this).removeClass("pj-table-row-hover");
			}
		);
		$(".pj-button").hover(
			function () {
				$(this).addClass("pj-button-hover");
			}, 
			function () {
				$(this).removeClass("pj-button-hover");
			}
		);
		$(".pj-checkbox").hover(
				function () {
					$(this).addClass("pj-checkbox-hover");
				}, 
				function () {
					$(this).removeClass("pj-checkbox-hover");
				}
			);
		$("#content").on("click", ".notice-close", function (e) {
			if (e && e.preventDefault) {
				e.preventDefault();
			}
			$(this).closest(".notice-box").fadeOut();
			return false;
		});
		
		$.fn.multilangFix = function () {
			var haystack = [];
			var $bar = $('.pj-form-langbar a[data-index]');
			$('.pj-multilang-wrap[data-index]').each(function () {
				var $this = $(this),
					index = $this.data('index'),
					$img = $this.find('.pj-multilang-input img');

				if (haystack.indexOf(index) !== -1) {
					return true;
				}
				haystack.push(index);

				$bar.each(function () {
					var $el = $(this);
					if ($el.data('index') == index) {
						$el.find('abbr').css('backgroundImage', 'url(' + $img.attr('src') + ')');
					}
				});
			});
		};
	});
})(jQuery_1_8_2);