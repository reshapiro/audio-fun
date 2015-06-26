#!/bin/sh

if [ $# -lt 2 ]; then
    echo "Two arguments are required."
    echo
    echo "The first argument should be a directory containing flac files."
    echo "The second argument should name the directory which will be created and will contain a tags file for each flac file."
    exit -1
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
