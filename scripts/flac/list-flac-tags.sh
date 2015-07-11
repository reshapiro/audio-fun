#!/bin/sh

if [ $# -lt 1 ]; then
    echo
    echo "This operation will display all tags of all flac files in a given file or directory"
    echo "To run this the metaflac command must be on your PATH."
    echo
    echo "Required arguments:"
    echo
    echo "The name of the directory of flac files"
    exit 0
fi

dir="$1"

if  [ -f "$dir" ]; then
# arg is a file, not a directory
metaflac --export-tags-to=- "$dir"
exit 0	
fi

if [  ! -d "$dir" ]; then
  echo "The directory "$dir" does not exist"
  exit -2
fi

for file in "$dir"/*.flac
do
   base=`basename "$file" .flac`
 echo "File: "$base""
   echo
   metaflac --export-tags-to=- "$file"
   echo
   echo
done






