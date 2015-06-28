#!/bin/sh

if [ $# -lt 2 ]; then
    echo
    echo "For each tag file in a given directory, this operation will add all the tags in that file  a corresponding flac file file in a parallel directory" 
    echo "To run this the metaflac command must be on your PATH."
    echo
    echo "Required arguments:"
    echo
    echo "The name of a directory of tag files"
    echo "The name of the parallel directory of flac files"
    echo
    echo "Both directories must exist"
    echo
    echo "Note that this operation can leade to duplicated tags."
    echo "To replace tags rather than adding them, use replace-tags.sh"
    exit 0
fi

tagsdir="$1"
flacdir="$2"

if [  ! -d "$flacdir" ]; then
  echo "The directory "$flacdir" does not exist"
  exit -2
fi

if [  ! -d "$tagsdir" ]; then
  echo "The directory "$tagsdir" does not exist"
  exit -2
fi

for file in "$flacdir"/*.flac
do
   base=`basename "$file" .flac`
   tagsfile=${tagsdir}/"${base}".tag
#   echo "importing $tagsfile to $file"
   metaflac --import-tags-from="$tagsfile" "$file"
done
