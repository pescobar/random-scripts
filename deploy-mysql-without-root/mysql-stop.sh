#!/bin/bash

DEST=/path/to/mysql_install/folder
MYLOGDIR=$DEST/log
MYDATADIR=$DEST/data
MYTMPDIR=$DEST/tmp
MYPORT=3306

export PATH=$DEST/mysql/bin:$PATH

mysqladmin -P $MYPORT -h 127.0.0.1 -u root -prootpass shutdown

