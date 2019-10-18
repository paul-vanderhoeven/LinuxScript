#!/bin/bash

list=""

while read line ; do
	if [ -d "$line" ]
	then
		list+="$line ";
	fi
done < folderToSave

echo $list
tar cvf configSave.tar $list