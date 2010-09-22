#!/bin/sh

while { inotifywait -e modify -e close_write -e create -e move -e delete -r backend-php/; }; do
    #rm -R build/*
    rm -R ../www/SWFM/
	mkdir ../www/SWFM

    # DEVELOPMENT
    cp -pR backend-php/src/* ../www/SWFM
	#rm -R ../www/SWFM/*~
done

