#!/bin/sh

while { inotifywait -e modify -e close_write -e create -e move -e delete -r --fromfile files.txt; }; do
	make test
done
