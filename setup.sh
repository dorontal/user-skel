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
    if [ -e $MY_DIR/dot_files/$i ]; then
        backups="$i $backups"
    fi
done
echo "Backing up: $backups"

# backup
tar czvhf $HOME/BACKUPS/dot_files$DATE.tgz $backups

# destructive
cd $MY_DIR/dot_files
for i in .[a-z,A-Z]*; do
    if [[ "$i" != ".gitignore" && "$i" != ".git" ]]; then
        cp -f $i $HOME
    fi
done

# more kind
cd $MY_DIR
# cp -ri bin $HOME
# cp -ri lib $HOME
rsync -av bin $HOME/
rsync -av lib $HOME/
