#!/bin/sh

if [ $# -lt 2 ]; then
    echo
    echo "For each tag file in a given directory, this operation will replace all the tags in that file  a corresponding flac file file in a parallel directory" 
    echo "To run this the metaflac command must be on your PATH."
    echo
    echo "Required arguments:"
    echo
    echo "The name of a directory of tag files"
    echo "The name of the parallel directory of flac files"
    echo
    echo "Both directories must exist"
    echo
    echo "Note that this will remove all existing tags before adding the new ones."
    echo "As a precaution, the existing will be saved in a file with the suffix .bak"
    echo "To add tags rather than replacing them, use add-tags.sh"
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
   tagsfile="$tagsdir"/"$base".tag
   tagsbackup="$tagsdir"/"$base".bak
   echo "backing up old tags to "$tagsbackup""
   metaflac --export-tags-to="$tagsbackup" "$file"
   metaflac --remove-all-tags "$file"
   metaflac --import-tags-from="$tagsfile" "$file"
done
