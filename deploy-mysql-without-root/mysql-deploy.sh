#!/bin/bash

# shitty script to deploy a mysql server without root access

# Path to the Oracle archive
TARGZ=/path/to/mysql-5.6.19-linux-glibc2.5-x86_64.tar.gz

# DEST: top-level destination of the server software
DEST=/path/to/mysql_install/folder

# INST: full path of the expanded archive
INST=$DEST/`basename $TARGZ .tar.gz`

# MYPORT: Port on which the server will respond
MYPORT=3399

# Create path and uncompress archive
mkdir -p $DEST
cd $DEST
tar zxvf $TARGZ
ln -s $INST mysql

# Create key work directories for the server
MYLOGDIR=$DEST/log
MYDATADIR=$DEST/data
MYTMPDIR=$DEST/tmp

## Or in RAM disk
# MYDATADIR=/dev/shm/mysql_$USER/data
# MYTMPDIR=/dev/shm/mysql_$USER/tmp

## Do some clean up if necessary
# rm -r $MYDATADIR
# rm -r $MYTMPDIR

# Create the directories
mkdir -p $MYLOGDIR
mkdir -p $MYDATADIR
mkdir -p $MYTMPDIR

cd mysql

# Deploy the database (without RAMdisk)
#scripts/mysql_install_db --user=$USER --datadir=$MYDATADIR --explicit_defaults_for_timestamp
scripts/mysql_install_db --datadir=$MYDATADIR --explicit_defaults_for_timestamp

## ... or with RAMdisk back-end 
# scripts/mysql_install_db --user=$USER --datadir=$MYDATADIR --explicit_defaults_for_timestamp --innodb_use_native_aio=0
# echo "innodb_use_native_aio=0" >> my.cnf

# Start the server
bin/mysqld \
       --port=$MYPORT \
       --bind-address=0.0.0.0 \
       --basedir=$DEST/mysql \
       --socket=$DEST/mysqld.sock \
       --pid-file=$DEST/mysqld.pid \
       --log_error=$MYLOGDIR/error.log \
       --datadir=$MYDATADIR \
       --tmpdir=$MYTMPDIR \
       --explicit_defaults_for_timestamp


export PATH=$DEST/mysql/bin:$PATH

# Set admin password
#mysqladmin -P $MYPORT -h 127.0.0.1 -u root password "password"

# Create work database and user (here ncbi)
#mysql -P $MYPORT -u root -ppassword -h 127.0.0.1 <<EOF
#   create database ncbi;
#   create user 'ncbi'@'localhost' identified by 'ncbi';
#   create user 'ncbi'@'%'         identified by 'ncbi';
#   grant all privileges on ncbi.* to 'ncbi'@'localhost';
#   grant all privileges on ncbi.* to 'ncbi'@'%';
#   flush privileges; 
#EOF

# Copy the tables to work with
#mysqldump --single-transaction -h dbmsql01 -u ncbi -pncbi ncbi msigdb msigdb_meta | mysql -P $MYPORT -u ncbi -pncbi -h 127.0.0.1 ncbi

#
#  Here the regular MySQL session can take place
#

# Clean shutdown
#mysqladmin -P $MYPORT -h 127.0.0.1 -u root -ppassword shutdown

## Final cleanup (double check)
# rm -r $MYLOGDIR $MYDATADIR $MYTMPDIR $DEST

