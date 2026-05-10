/*!
 * Simple CMS v5.0
 * http://www.phpjabbers.com/simple-cms/
 * 
 * Copyright 2014, StivaSoft Ltd.
 * 
 */
(function (window, undefined){
	"use strict";
	var document = window.document;
	
	function log() {
		if (window.console && window.console.log) {
			for (var x in arguments) {
				if (arguments.hasOwnProperty(x)) {
					window.console.log(arguments[x]);
				}
			}
		}
	}
	
	function assert() {
		if (window && window.console && window.console.assert) {
			window.console.assert.apply(window.console, arguments);
		}
	}
	
	function SimpleCMS(opts) {
		if (!(this instanceof SimpleCMS)) {
			return new SimpleCMS(opts);
		}
				
		this.reset.call(this);
		this.init.call(this, opts);
		
		return this;
	}
	
	SimpleCMS.inObject = function (val, obj) {
		var key;
		for (key in obj) {
			if (obj.hasOwnProperty(key)) {
				if (obj[key] == val) {
					return true;
				}
			}
		}
		return false;
	};
	
	SimpleCMS.size = function(obj) {
		var key,
			size = 0;
		for (key in obj) {
			if (obj.hasOwnProperty(key)) {
				size += 1;
			}
		}
		return size;
	};
	
	SimpleCMS.prototype = {
		reset: function () {
			this.$container = null;
			this.container = null;
			this.page = null;
			this.opts = {};
			
			return this;
		},
		
		init: function (opts) {
			var self = this;
			this.opts = opts;
			this.container = document.getElementById("scmsContainer_" + this.opts.index);
			this.$container = pjQ.$(this.container);
			
			this.$container.on("click.scms", ".scmsSelectorLocale", function (e) {
				if (e && e.preventDefault) {
					e.preventDefault();
				}
				var locale = pjQ.$(this).data("id");
				var params = {"locale_id": locale};
				if(self.opts.session_id != '')
				{
					params.session_id = self.opts.session_id;
				}
				self.opts.locale = locale;
				pjQ.$(this).addClass("smcsLocaleFocus").parent().parent().find("a.smcsSelectorLocale").not(this).removeClass("smcsLocaleFocus");
				
				pjQ.$.get([self.opts.folder, "index.php?controller=pjFront&action=pjActionLocale"].join(""), params).done(function (data) {
					self.loadSection.call(self);
				}).fail(function () {
					log("Deferred is rejected");
				});
				return false;
			});
			
			self.loadSection.call(self);
		},
		loadSection: function () {
			var self = this,
				index = this.opts.index,
				params = {
							"id": this.opts.id,
							"locale": this.opts.locale,
							"hide": this.opts.hide,
							"index": this.opts.index
						 };
			if(self.opts.session_id != '')
			{
				params.session_id = self.opts.session_id;
			}
			pjQ.$.get([this.opts.folder, "index.php?controller=pjFront&action=pjActionViewJs"].join(""), params).done(function (data) {
				self.$container.html(data);
			}).fail(function () {
				self.enableButtons.call(self);
			});
		}
	};
	
	window.SimpleCMS = SimpleCMS;	
})(window);