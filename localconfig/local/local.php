<?php
	SmartWFM_Registry::set('basepath', '/var/www/test');	
	SmartWFM_Registry::set('commands', array('base_actions', 'base_direct_commands', 'archive_actions', 'setting_actions', 'search_actions'));
	SmartWFM_Registry::set('commands_path', 'commands');
	/* How to detect the mime type
	   Modes:
	     internale: use the internal php function to detect the mime type
	     cmd_file: call the file command to detect the mime type
	     file: use an internal file to detect the mime type
	*/
	SmartWFM_Registry::set('mimetype_detection_mode', 'internal');
	SmartWFM_Registry::set('filesystem_type', 'local');

	/* Set to True to use the X-Sendfile header
	   The Webserver must support X-Sendfile header!!!
	   Apache 2.x:
	   - install mod_xsendfile
	   - Set config options:
	     - XSendFIle On
	     - XSendFileAllowAbove On
	*/
	SmartWFM_Registry::set('use_x_sendfile', False);

?>
