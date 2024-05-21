EDIT_LOG=$1
FUNNEL=$2
IMAGES=$3
AUDIO=$4
DOCUMENTS=$5
VIDEO=$6
MISCELLANEOUS=$7

funnel_file_cnt=`ls $FUNNEL | wc -l`

if [ ! $funnel_file_cnt -eq 0 ]; then
	for file in $FUNNEL/*; do
		destination=$MISCELLANEOUS
		extension=`echo $file | sed 's/.*\.//'`
		case $extension in

			docx | docs | odt | pdf | md | txt | ppt | pptx)
				destination=$DOCUMENTS
				;;

			jpg | png | jpeg | gif | webp | tiff)
				destination=$IMAGES
				;;
			mp4 | mkv | webm | avi | mov)
				destination=$VIDEO
				;;
			mp3 | wav | m4a | ogg | aac)
				destination=$AUDIO
				;;
			*)
				destination=$MISCELLANEOUS
				;;
		esac
		echo "$destination"
		mv "$file" "$destination"
		if [ $EDIT_LOG ]; then
			echo "$file moved to $destination on $(date)." >> /tmp/file_organizer.log
		fi
	done
fi
