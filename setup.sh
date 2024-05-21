#!/bin/bash

# Folder Locations

FUNNEL="/tmp/Funnel"
IMAGES="/tmp/Images"
AUDIO="/tmp/Audio"
DOCUMENTS="/tmp/Documents"
VIDEOS="/tmp/Videos"
MISCELLANEOUS="/tmp/Miscellaneous"
CREATE_LOG_FILE=false
LOCATIONS=($FUNNEL $IMAGES $AUDIO $DOCUMENTS $VIDEOS $MISCELLANEOUS)

# Check Whether the Locations Exists

for location in ${LOCATIONS[@]};
	do
		if [ ! -d $location ]; then
			echo "$location doesnot exist."
			read -p "Create this Directory ? (y/n)" confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
			mkdir "$location"
			if [ $? -eq 0 ]; then
				echo "Folder Created Successfully."
			else
				echo "Failed to create the folder."
			fi	
		fi

	done


# Asking to create log file

read -p "Create log file ? (y/n)" log_file 

if [[ $log_file == [yY] || $log_file == [yY][eE][sS] ]]; then
	CREATE_LOG_FILE=true
	echo "Log File Created on $(date)" > /tmp/file_organizer.log 
	echo "Log File Created"
else
	CREATE_LOG_FILE=false
fi

# Adding File Organizer cron job

echo "Creating a cron job ...."
CURR_DIR=`pwd`
echo "$CURR_DIR"
crontab -l > /tmp/curr_cron
echo "* * * * * $CURR_DIR/file_organizer.sh $CREATE_LOG_FILE ${LOCATIONS[@]}" >> curr_cron
crontab curr_cron
rm curr_cron

if [ $? -eq 0 ]; then
	echo "Cron Job added successfully."
else
	echo "Failed to create Cron Job."
fi
