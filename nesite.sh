#!/bin/bash

##############################
#
# 	Site  managment script
#	enable site under NGINX
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
	echo "Available configs:"
	ls -lx $AVALIABLE
	exit 0;
fi


if [[ -e $AVALIABLE/$NAME ]] ; then
	FULL_NAME=$AVALIABLE/$NAME;
else if [[ -e $AVALIABLE/$NAME_WITH_TYPE ]]; then
		FULL_NAME=$AVALIABLE/$NAME_WITH_TYPE;
	else
		echo "Config file '$NAME' does't exists"
		exit 1;
	fi
fi

if [ -e $ENABLED/$NAME ] || [ -e $ENABLED/$NAME_WITH_TYPE ] ; then
	echo "Config enabled already"
	exit 1;
fi

sudo ln -s $FULL_NAME $ENABLED/$NAME_WITH_TYPE
sudo systemctl restart nginx
