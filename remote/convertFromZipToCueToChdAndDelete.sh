#!/bin/bash

batchSize=0 #unlimited
#startsWith="" #TODO: Maybe...
doNotDelete=0 #delete original zip files and gemerated cue/bins

for param in "$@"; do
  if [[ $param =~ ^[0-9]+$ ]]; then
    batchSize="$param"
  fi
  #if [[ $param =~ ^[a-Z]$ ]]; then
  #  startsWith="${param^^}"
  #fi
  if [[ "${param,,}" = "safe" ]]; then
    doNotDelete=1
  fi
done

for file in *.zip; do 
  7za x -aoa "$file" -o"${file%.*}"
  retVal=$?
  if [ $retVal -eq 0 ]; then
    chdman createcd -i "./${file%.*}/${file%.*}.cue" -o "${file%.*}chd" --force
    retVal=$?
    if [ $retVal -eq 0 ]; then
      if [ $doNotDelete -eq 0 ]; then
      echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Deleting zip $file"
      rm "$file"
      echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Deleting folder ./${file%.*}/"
      rm -r "./${file%.*}/"
      else
        echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Do not delete flag active, leaving files!"
      fi
    else
      echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Chd'ing failed! Skiping delete step!"
    fi
  else
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Unzip failed! Skiping delete step and chd'ing!"
  fi
  if [ $batchSize -gt 0 ]; then
    if [ $batchSize -eq 1 ]; then
      echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Batch Complete! Quitting!"
      exit 0;
    else
    ((batchSize=batchSize-1))
      echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$batchSize to go in this batch!"
    fi
  fi
done
