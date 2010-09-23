.PHONY: clean dev prod backend all test local_dev

clean:
	rm -fR build/php build/swfm-dev

backend:
	mkdir build/php
	cp -R backend-php/src/* build/php
	cp -R localconfig/backend-php/src/* build/php
	find build/ -name '*~'  -exec rm {} \;
		
dev:
	mkdir build/swfm-dev
	ant build_dev -f swfm/build.xml && cp -R swfm/build/* build/swfm-dev
	cp -R localconfig/swfm/* build/swfm-dev
	find build/ -name '*~'  -exec rm {} \;
	
prod:
	rm -fR build/swfm 
	mkdir build/swfm
	ant clean -f swfm/build.xml && ant build -f swfm/build.xml && cp -R swfm/build/* build/swfm && ant clean -f swfm/build.xml 
	cp -R localconfig/swfm/* build/swfm
	find build/ -name '*~'  -exec rm {} \;
	
all:
	make clean
	make backend
	make dev
	make prod

test:
	make clean
	make backend
	make dev
	
local_dev:
	rm -fR ../www/SWFM/
	mkdir ../www/SWFM
	cp -pR backend-php/src/* ../www/SWFM
