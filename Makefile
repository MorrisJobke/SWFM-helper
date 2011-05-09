.PHONY: clean dev prod backend all test local_dev doc

clean:
	rm -fR build/php-dev build/swfm-dev

backend:
	rm -fR build/php
	mkdir build/php
	cp -R backend-php/src/* build/php
	cp config/prod/local.php build/php/config/local.php
	rm -fR build/php/install

backend_dev:
	mkdir -p build/php-dev
	cp -R backend-php/src/* build/php-dev
	cp config/dev/local.php build/php-dev/config/local.php
	rm -fR build/php-dev/install

dev:
	mkdir -p build/swfm-dev
	ant build_dev -f swfm/build.xml && cp -R swfm/build/* build/swfm-dev
	cp config/dev/index.php build/swfm-dev/index.php
	cp config/dev/json-test.html build/swfm-dev/json-test.html
	cp -pR config/dev/js build/swfm-dev/js

prod:
	rm -fR build/swfm
	mkdir build/swfm
	ant clean -f swfm/build.xml && ant build -f swfm/build.xml && cp -R swfm/build/* build/swfm && ant clean -f swfm/build.xml
	cp config/prod/index.php build/swfm/index.php

all:
	make clean
	make backend
	make backend_dev
	make dev
	make prod
	make doc
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
	cp config/local/local.php ../www/SWFM/php/config/local.php
	cp config/local/json-test.html ../www/SWFM/php/json-test.html
	cp -pR config/dev/js ../www/SWFM/php/js
	find ../www/SWFM/ -name '*~'  -exec rm {} \;

local_full_dev:
	make test
	cp config/local/local.php build/php-dev/config/local.php
	cp config/local/index.php build/swfm-dev/index.php
	cp config/local/json-test.html build/swfm-dev/json-test.html

local_full:
	make local_full_dev
	make prod
	cp config/local/index.php build/swfm/index.php


doc:
	ant doc -f swfm/build.xml
