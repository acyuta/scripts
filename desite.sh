#!/bin/bash

##############################
#
# 	Site  managment script
#	disable site under NGINX
#
#	created at 2015-11-01
#	by Akim Glushkov aka acyut <mikaakim1 at gmail dot com>
#
#	FOR ARHC only
#
##############################


NAME=$1
CONFIG_PATH=/etc/nginx
AVALIABLE=$CONFIG_PATH/sites-available
ENABLED=$CONFIG_PATH/sites-enabled
FILE_TYPE=.conf
NAME_WITH_TYPE=$NAME$FILE_TYPE

if [[ -z $NAME ]]; then
	echo "USAGE:	$0 config_file";
	exit 0;
fi

# param -l
if [[ "$NAME" == "-l" ]] ; then
	echo "Enabled configs:"
	ls -lx $ENABLED
	exit 0;
fi

if [[ ! -e $ENABLED/$NAME_WITH_TYPE ]]; then
	echo "Config file '$NAME_WITH_TYPE' not enabled"
	exit 1;
else
	sudo rm -rvf $ENABLED/$NAME_WITH_TYPE && 
	sudo systemctl restart nginx
fi
