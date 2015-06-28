#!/bin/sh

if [ $# -lt 1 ]; then
    echo
    echo "This operation will display all tags of all flac files in a given directory"
    echo "To run this the metaflac command must be on your PATH."
    echo
    echo "Required arguments:"
    echo
    echo "The name of the directory of flac files"
    exit 0
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






