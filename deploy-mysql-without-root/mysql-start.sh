#!/bin/bash

DEST=/path/to/mysql_install/folder
MYLOGDIR=$DEST/log
MYDATADIR=$DEST/data
MYTMPDIR=$DEST/tmp
MYPORT=3306

export PATH=$DEST/mysql/bin:$PATH

mysqld --port=$MYPORT \
       --bind-address=0.0.0.0 \
       --basedir=$DEST/mysql \
       --socket=$DEST/mysqld.sock \
       --pid-file=$DEST/mysqld.pid \
       --log_error=$MYLOGDIR/error.log \
       --datadir=$MYDATADIR \
       --tmpdir=$MYTMPDIR \
       --explicit_defaults_for_timestamp > $HOME/.mysql.log 2>&1 &

