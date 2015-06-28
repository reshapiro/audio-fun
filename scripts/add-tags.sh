#!/bin/sh

if [ $# -lt 1 ]; then
    echo
    echo "For each tag file in the given directory, this operation will add all the tags in that file  a corresponding flac file" 
    echo "To run this the metaflac command must be on your PATH."
    echo
    echo "Required arguments:"
    echo
    echo "The name of a directory of tag files"
    echo
    echo "Note that this operation can leade to duplicated tags."
    echo "To replace tags rather than adding them, use replace-tags.sh"
    exit 0
fi

flacdir="$1"


if [  ! -d "$flacdir" ]; then
  echo "The directory "$flacdir" does not exist"
  exit -2
fi

for file in "$flacdir"/*.flac
do
   base=`basename "$file" .flac`
   tagsfile=${flacdir}/"${base}".tag
#   echo "importing $tagsfile to $file"
   metaflac --import-tags-from="$tagsfile" "$file"
done
