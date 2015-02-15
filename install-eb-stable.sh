#!/bin/bash

## Install latest EasyBuild stable release and generate
## a file "setup-env.sh" to use it

if [ $# -ne 1 ]
then
    echo "Usage: $0 <full install path>"
    exit 1
fi

INSTALL_DIR=`readlink -f $1`
LOGFILE=$INSTALL_DIR/install.log

echo -e "starting installation. Logging to ${LOGFILE}\n"

if [ ! -d "$INSTALL_DIR" ]; then
    mkdir $INSTALL_DIR
fi

for repo in framework easyconfigs easyblocks;
do
    echo "downloading http://github.com/hpcugent/easybuild-${repo}/archive/master.tar.gz"
    wget http://github.com/hpcugent/easybuild-${repo}/archive/master.tar.gz -O /tmp/eb-${repo}-master_$(date +"%d_%m_%Y").tar.gz >> $LOGFILE 2>&1
    
    echo -e "uncompressing ${repo}\n"
    tar xf /tmp/eb-${repo}-master_$(date +"%d_%m_%Y").tar.gz -C $INSTALL_DIR --strip-components=1
done

rm -fr /tmp/eb-{framework,easyconfigs,easyblocks}-master_$(date +"%d_%m_%Y").tar.gz

cat > $INSTALL_DIR/setup-env.sh << EOF
export PYTHONPATH=${INSTALL_DIR}:\$PYTHONPATH
export PATH=${INSTALL_DIR}:\$PATH
EOF

echo "Installation complete. To start using it do \"source $INSTALL_DIR/setup-env.sh\""

touch $INSTALL_DIR/INSTALLED_$(date +"%d_%m_%Y")
