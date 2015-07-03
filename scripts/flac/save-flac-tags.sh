#!/bin/sh

if [ $# -lt 1 ]; then
    echo
    echo "For each flac file in a given directory, this operation will create  a tags file" 
    echo "To run this the metaflac command must be on your PATH."
    echo
    echo "Required arguments:"
    echo
    echo "The name of a directory of flac files"
    echo
    
    echo "If the any tag file already exists the tags will be added to it. This can potentially lead to tag duplication."
    
    exit 0
fi

flacdir="$1"

if [  ! -d "$flacdir" ]; then
  echo "The directory $flacdir does not exist"
  exit -2
fi

for f in "$flacdir"/*.flac
 do
#  echo " file is $f"
  base=`basename "$f" ".flac"`
# echo " basename is  $base"
  tagsfile="$flacdir"/"$base".tag
#  echo "mf file is "$tagsfile""
  metaflac --export-tags-to="$tagsfile" "$f"
done
