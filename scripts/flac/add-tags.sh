#!/bin/sh

if [ $# -lt 1 ]; then
    echo
    echo "This script will add an arbitary set of tags to a given flac file or to  each  to flac file in a given directory" 
    echo "Note that if a tag with the same name already exists you will be adding another value for that tag, not replacing the existing one"
    echo "To run this the metaflac command must be on your PATH."
    echo
    echo "Required arguments:"
    echo
    echo "The name of a directory of flac files"
    echo
    echo
    echo "Optional arguments:"
    echo
    echo "The tags to add in name=value form where name is a flac tag, for instance ARTIST=Bob\ Dylan"
    echo "If a value includes whitespace it must be quoted, as in example above"
    exit 0
fi

target=$1
if [ -f "$target" ]; then

  vardex=1
  for var in "$@"
  do
   if [ $vardex -gt 1 ]; then 
     echo "$var" >> "$target"
 #    echo " metaflac --set-tag="$var" "$target" "
     metaflac --set-tag="$var" "$target"
   fi
    vardex=`expr $vardex + 1`
  done
  exit 0
  
fi


flacdir="$target"

if [  ! -d "$flacdir" ]; then
  echo "The directory "$flacdir" does not exist"
  exit -2
fi

for file in "$flacdir"/*.flac
 do
   base=`basename "$file" .flac`
   tagsfile="$flacdir"/"$base".tag
   
  vardex=1
  for var in "$@"
  do
   if [ $vardex -gt 1 ]; then 
     echo "$var" >> "$tagsfile"
 #    echo " metaflac --set-tag="$var" "$file" "
     metaflac --set-tag="$var" "$file"
   fi
    vardex=`expr $vardex + 1`
  done
     
done
