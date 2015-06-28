#!/bin/sh

if [ $# -lt 2 ]; then
    echo
    echo "For each flac file in a given directory, this operation will create  a tag file in parallel directory" 
    echo "To run this the metaflac command must be on your PATH."
    echo
    echo "Required arguments:"
    echo
    echo "The name of a directory of flac files"
    echo "The name of the directory in which to store the tag files"
    echo
    echo "The flac file directory must exist.  The tag directory generally should not exist. It will be created for you."
    echo "In this case all the tag files will of course be newly created as well."
    
    echo "If the any tag file already exists the tags will be added to it. This can potentially lead to tag duplication."
    
    exit 0
fi

flacdir="$1"

if [  ! -d "$flacdir" ]; then
  echo "The directory $flacdir does not exist"
  exit -2
fi

tagsdir="$2"

mkdir -p "$tagsdir"

for f in "$flacdir"/*.flac
 do
#  echo " file is $f"
  base=`basename "$f" ".flac"`
# echo " basename is  $base"
  tagsfile="$tagsdir"/"$base".tag
#  echo "mf file is "$tagsfile""
  metaflac --export-tags-to="$tagsfile" "$f"
done
