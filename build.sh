#!/bin/sh

while { inotifywait -e modify -e close_write -e create -e move -e delete -r --fromfile files.txt; }; do
	#rm -R build/*
	rm -R build/php build/swfm-dev

	mkdir build/php
	mkdir build/swfm-dev
	#mkdir build/swfm

	# DEVELOPMENT
	cd swfm
	ant build_dev && cp -R build/* ../build/swfm-dev
	cd ..

	cp -R backend-php/src/* build/php
	cp -R localconfig/backend-php/src/* build/php
	cp -R localconfig/swfm/* build/swfm-dev
	
	# PRODUCTIVE 
	#cd swfm
	#ant clean && ant build && cp -R build/* ../build/swfm && ant clean
    #    cd ..
	#
    #  	cp -R localconfig/swfm/* build/swfm
	#
	find build/ -name *~ -exec rm {} \;
done
