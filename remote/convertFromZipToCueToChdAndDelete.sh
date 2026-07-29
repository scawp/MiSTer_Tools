#!/bin/bash

for file in *.zip; do 
  7za x -aoa "$file" -o"${file%.*}"
  RESULT=$?
  if [ $RESULT -eq 0 ]; then
	chdman createcd -i "./${file%.*}/${file%.*}.cue" -o "${file%.*}.chd" --force
	RESULT=$?
	if [ $RESULT -eq 0 ]; then
	  echo "Deleting zip $file"
	  rm "$file"
	  echo "Deleting folder ./${file%.*}/"
	  rm -r "./${file%.*}/"
	else
      echo "Chd'ing failed! Skipping delete step!"
	fi
  else
    echo "Unzip failed! Skipping delete step and chd'ing!"
  fi
done

echo "Fin!"
