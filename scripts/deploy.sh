#!/bin/sh

rsync -gloprtv --delete . www-data@www.halleluja.nu:www.halleluja.nu/
