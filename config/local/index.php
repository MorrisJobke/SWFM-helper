<html>
<head>
	<title>Smart Web File Manager - Demo</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="swfm/swfm-core.js"></script>
	<link rel="shortcut icon" type="image/png" href="swfm/themes/default/favicon.png" />
</head>
<body>
	<script type="text/javascript">
		function getGETParam( name ){
			name = name.replace("/[\[]/","\\\[").replace("/[\]]/","\\\]");
			var regexS = "[\\?&]"+name+"=([^&#]*)";
			var regex = new RegExp( regexS );
			var results = regex.exec( window.location.href );
			if( results == null )
				return undefined;
			else
				return results[1];
		 }

		var lang = getGETParam('lang');
		if(lang == undefined) {
			lang = 'de';
		}

		var config = {
			'command_url': '../php-dev/index.php',
			'lang': lang,
			'plugins' : [
				'base_actions',
				'extra',
				'image_viewer',
				'setting',
				'esource_viewer',
				'archives'
			],
			'widgets' : [
				'treemenu',
				'browser',
				'search'
			],
			'menu.main.file': [
				'newtab',
				'new_folder'
			],
			'menu.main.edit': [
				'copy',
				'move',
				'paste',
				'rename',
				'delete',
				'create_archive'
			],
			'menu.main.view': [
				'iconview',
				'listview'
			],
			'menu.main.tools': [
				'setting.show_hidden',
				'search'
			],
			'menu.main.extras': [
				'setting.save',
				'setting.edit'
			],
			'plugin.setting.items': {
				'setting.menu.hidden_files' : 'plugin.example.booltest',
				'setting.show_hidden': 'swfm.files.show_hidden'
			},
			'plugin.extra.open_with.menu': [
				'image_viewer',
				'esource_viewer',
				'archive_viewer'
			],
			'setting.load.auto': true,
			'setting.load.enable': true,
			'setting.save.enable': true,
			'widget.treemenu.menu.context': [
				'treemenu-newtab',
				'treemenu-reload'
			],
			'widget.browser.menu.item_context': [
				'extra.open_with',
				'copy',
				'move',
				'paste',
				'rename',
				'download',
				'create_archive',
				'|',
				'delete'
			],
			'widget.browser.menu.context': [
				'new_folder',
				'copy',
				'move',
				'paste',
				'rename',
				'download',
				'upload',
				'|',
				'delete'
			],
			'statusbar.left': [
			],
			'widget.treemenu.root_name': '/var/www/test'

		};

		var home = getGETParam('home');

		if(home != undefined) {
			config['home_path'] = home;
		} else {
			config['home_path'] = "/";
		}

		var extra_path = getGETParam('extra_path');

		if(extra_path != undefined) {
			var t = extra_path.split(';');
			if(t.length > 0) {
				config['listeners'] = {
					'load': {
						callback: function() {
							var i;
							for(i=0; i < this.path_list.length; i++) {
								SWFM.Event.fire('main', 'folder_open', this.path_list[i], false);
							}
						},
						scope: {'path_list': t}
					}
				};
			}
		}

		SmartWFM.init(config);
	</script>
</body>
</html>
