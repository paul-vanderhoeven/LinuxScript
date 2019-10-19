#!/bin/bash

list=""
destination="configSave.tar"

while read line ; do
	if [ -e $line ]
	then
		list+="$line ";
	fi
done < folderToSave

sudo tar cfp $destination --exclude="$destination" $list
sudo chown $USER $destination
chmod 600 $destination
chgrp $USER $destination