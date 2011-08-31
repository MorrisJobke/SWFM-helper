<?php
	SmartWFM_Registry::set('basepath', '/afs/tu-chemnitz.de');
	SmartWFM_Registry::set('commands', array(
		'base_actions', 'base_direct_commands', 'archive_actions', 
		'afs_special_actions', 'setting_actions', 'search_actions', 
		'feedback_actions', 'file_info_actions', 'bookmarks_actions'
	));
	SmartWFM_Registry::set('commands_path', 'commands');
	/* How to detect the mime type
	   Modes:
		 internal: use the internal php function to detect the mime type
		 cmd_file: call the file command to detect the mime type
		 file: use an internal file to detect the mime type
	*/
	SmartWFM_Registry::set('mimetype_detection_mode', 'internal');
	SmartWFM_Registry::set('filesystem_type', 'afs');

	/* Set to True to use the X-Sendfile header
	   The Webserver must support X-Sendfile header!!!
	   Apache 2.x:
	   - install mod_xsendfile
	   - Set config options:
		 - XSendFIle On
		 - XSendFileAllowAbove On
	*/
	SmartWFM_Registry::set('use_x_sendfile', False);

	/* Use this file to store the settings.
	   For multiuser support you have to modify the filename dynamically.
	   E.g.: SmartWFM_Registry::set('setting_filename', '/home/'.$_SERVER['PHP_AUTH_USER'].'/.smartwfm.ini');
	*/
	$user = $_SERVER['REMOTE_USER'];
	$path = '/afs/tu-chemnitz.de/home/urz/';
	$path .= substr($user,0,1) . '/'. $user;
	SmartWFM_Registry::set('setting_filename', $path . '/.smartwfm.ini');
	
	SmartWFM_Registry::set('bookmarks_filename', $path . '/.smartwfm_bookmarks.ini');

?>
