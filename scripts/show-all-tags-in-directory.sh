#!/bin/sh

if [ $# -lt 1 ]; then
    echo "No flac directory was provided"
    exit -1
fi

dir="$1"

# echo "directory is  "$dir""
if [  ! -d "$dir" ]; then
  echo "The directory "$dir" does not exist"
  exit -2
fi

for file in "$dir"/*.flac
do
   base=`basename "$file"`
   echo "$base:"
   echo
   metaflac --export-tags-to=- "$file"
   echo
   echo
done






