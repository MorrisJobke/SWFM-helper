.PHONY: clean dev prod backend all test local_dev

clean:
	rm -fR build/php-dev build/swfm-dev

backend:
	rm -fR build/php
	mkdir build/php
	cp -R backend-php/src/* build/php
	cp localconfig/prod/local.php build/php/config/local.php
	rm -fR build/php/install
	
backend_dev:
	mkdir build/php-dev
	cp -R backend-php/src/* build/php-dev
	cp localconfig/dev/local.php build/php-dev/config/local.php
	rm -fR build/php-dev/install
		
dev:
	mkdir build/swfm-dev
	ant build_dev -f swfm/build.xml && cp -R swfm/build/* build/swfm-dev
	cp localconfig/dev/index.php build/swfm-dev/index.php
	cp localconfig/dev/json-test.html build/swfm-dev/json-test.html
	cp -pR localconfig/dev/js build/swfm-dev/js
	
prod:
	rm -fR build/swfm 
	mkdir build/swfm
	ant clean -f swfm/build.xml && ant build -f swfm/build.xml && cp -R swfm/build/* build/swfm && ant clean -f swfm/build.xml 
	cp localconfig/prod/index.php build/swfm/index.php
	
all:
	make clean
	make backend
	make backend_dev
	make dev
	make prod
	find build/ -name '*~'  -exec rm {} \;

test:
	make clean
	make backend_dev
	make dev
	find build/ -name '*~'  -exec rm {} \;
	
local_dev:
	rm -fR ../www/SWFM/
	mkdir -p ../www/SWFM/php
	cp -pR backend-php/src/* ../www/SWFM/php
	rm -fR ../www/SWFM/php/install
	cp localconfig/local/local.php ../www/SWFM/php/config/local.php
	find ../www/SWFM/ -name '*~'  -exec rm {} \;
	

