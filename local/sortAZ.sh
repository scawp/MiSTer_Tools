#!/bin/bash

source_dir=$1
ext=$2 #eg zip, chd, bin
pre_dir=$3 # eg when you want ./cart/A/GAME / ./tape/B/GAME etc

#check "source_dir" has been entered or die
if [ -z "$source_dir" ]; then
  echo "Source Directory is Null, qutting."
  exit 1;
elif [ ! -d "$source_dir" ]; then
  echo "Source Directory doesn't exist, qutting."
  exit 1;
fi

#check "ext" has been entered or die
if [ ! -z "$pre_dir" ]; then
  path="./$pre_dir/"
fi

#check "ext" has been entered or die
if [ -z "$ext" ]; then
  echo "Extention not specified, quitting"
  exit 1;
fi

source_dir="$(realpath "$source_dir")"

echo "$source_dir"
cd "$source_dir"

for file in *.$ext; do 
  #echo $file
  if ! [[ -f "$file" ]]; then
    echo "Whoops - $file"
    exit 1
  fi

  starts_with="${file:0:1}"
  folder="$path#"
  if [[ $starts_with =~ ^[a-Z]$ ]]; then
    folder="$path${starts_with^^}"
  fi

  mkdir -p "$folder"
  mv -v "$file" "$folder/"
done

#Group Disk games into folders
IFS=$'\n'
list_of_files=($(find "$source_dir" -mindepth 2 -iregex '.*(disc.[0-9]).*' | perl -pe 's/\s\(Disc.+?\).*//' | sort | uniq -D | uniq))
unset IFS
for line in "${list_of_files[@]}"; do
  IFS=$'\n'
  discs=($(find "$source_dir" -type f -wholename "$line*"))
  unset IFS
  for disc_name in "${discs[@]}"; do
    mkdir -p "$line"
    mv -v "$disc_name" "$line/"
  done
done

echo "Fin."
