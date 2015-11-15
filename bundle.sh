#!/bin/bash

######################################################
#
# Bash script for packaging Java Source files 
# and Textfiles into a tar archive that should
# be accepted by the praktomat system.
#
######################################################
#
#                      USAGE 
#
# If the script is invoked without any arguments
# it will assume that the entry point's file name 
# is "Shell.java".
#
# If you want to change the entry point's file name
# simply pass the file name as the first argument 
# to the script.
#
######################################################

wd=$(pwd)

if [ -z "$1" ]; then
   entryfile=Shell.java
else
   entryfile=$1
fi

function warning {
   echo -e "\e[1m\e[31m"
   echo "WARNING: $1";
   echo -e "\e[0m"
}

outfile=$wd/bundle.tar;

echo "Creating tar archive at $outfile"

if [ -f $outfile ]; then
   rm $outfile;
fi

entry_found=false

while read file; do
   tar rf $outfile -C $(dirname $file) $(basename $file)
   entry_found=true
done < <(find $wd -name $entryfile -print -quit)

if [ "$entry_found" = false ]; then
   warning "Could not find entry file $entryfile";
fi

find $wd -type f -name "*.java" -or -name "*.txt" | while read file; do 
    if [ $(basename $file) == $entryfile ]; then
       continue;
    fi
    tar rf $outfile -C $(dirname $file) $(basename $file)
done

if [ ! -f $outfile ]; then
    warning "Outfile was not created. Probably no source files found?"
    exit 1
fi

echo "The created archive contains the following files:"
echo "#################################################"
tar tf $outfile
echo "#################################################"
