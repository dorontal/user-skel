#!/bin/bash

# sets up a new user while backing up skeleton replaced files

MY_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DATE="`date +%F`"

if [ ! -e $HOME/BACKUPS ]; then
    mkdir $HOME/BACKUPS
fi

if [ ! -e $HOME/.DEL ]; then
    mkdir $HOME/.DEL
fi

cd $HOME
backups=""
for i in .[a-z,A-Z]*; do
    if [ -e $MY_DIR/$i ]; then
        backups="$i $backups"
    fi
done
echo $backups

# backup
tar czvhf $HOME/BACKUPS/dot_files$DATE.tgz $backups

# destructive
cp -f $MY_DIR/.[a-z,A-Z]* $HOME
# more kind
cp -ri $MY_DIR/bin $HOME
cp -ri $MY_DIR/lib $HOME
