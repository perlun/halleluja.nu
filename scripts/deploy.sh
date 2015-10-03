#!/bin/sh

rsync -gloprtv --delete . www-data@85.134.56.45:www.halleluja.nu/
