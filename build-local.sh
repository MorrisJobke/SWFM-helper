#!/bin/sh

while { inotifywait -e modify -e close_write -e create -e move -e delete -r backend-php/; }; do
    make local_dev
done

