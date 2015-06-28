#!/bin/sh

if [ $# -lt 1 ]; then
    echo
    echo "This operation tries to generate and save flac tags given a directory of flac files."
    echo "To run this the metaflac command must be on your PATH."
    echo
    echo "No tags will be added to the flac files themselves"
    echo "Instead the tags will be saved to a parallel directory where you can edit them if necessary"
    echo "To add tags to the flac files use add-tags.sh or replace-tags.sh"
    echo
    echo "The tag generation logic is as follows:"
    echo
    echo "The ALBUM tag is derived form the basename of flac directory."
    echo  "The TITLE tag is derived from the basename of each flac file, sans .flac suffix."
    echo "The TRACKNUMBER tag is derived from the position of the flac file in the directory"
    echo "The TRACKTOTAL tag is derived from the number of flac files in the directory"
    
    echo
    echo "Required arguments:"
    echo
    echo "The name of the directory of flac files"
    echo
    echo "Optional arguments:"
    echo
    echo "You can add any number of other arguments in name=value form where name is a flac tag, for instance ARTIST=Bob\ Dylan"
    echo "If a value includes whitespace it must be quoted, as in example above"
    exit 0
fi

flacdir="$1"

if [  ! -d "$flacdir" ]; then
  echo "The directory $flacdir does not exist"
  exit -2
fi
total=0
for f in "$flacdir"/*.flac
 do
   total=`expr $total + 1`
 done


index=1
album=`basename "$flacdir"`
for f in "$flacdir"/*.flac
 do
#  echo " file is $f"
  base=`basename "$f" ".flac"`
# echo " basename is  $base"
  tagsfile="$flacdir"/"$base".tag
#  echo "mf file is "$tagsfile""
  echo "TITLE"=$base"" >> "$tagsfile"
  echo "TRACKNUMBER=$index" >> "$tagsfile"
  echo "TRACKTOTAL=$total" >> "$tagsfile"
  echo "ALBUM=$album" >> "$tagsfile"
  
  
  
  # add other tags
  vardex=1
  for var in "$@"
  do
   if [ $vardex -ge 2 ]; then 
     echo "$var" >> "$tagsfile"
   fi
    vardex=`expr $vardex + 1`
  done
  
  
  index=`expr $index + 1`
done
