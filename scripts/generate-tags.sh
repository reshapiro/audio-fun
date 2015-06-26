#!/bin/sh

if [ $# -lt 2 ]; then
    echo "At least two arguments are required."
    echo
    echo "The first argument should be a directory containing flac files."
    echo "The second argument should name the directory which will be created and will contain a tags file for each flac file."
    echo
    echo "You can add any number of other arguments in name=value form where name is a flac tag, for instance ARTIST=Bob\ Dylan"
    echo "If a value includes whitespace it must be quoted, as above"
    exit -1
fi

flacdir="$1"

if [  ! -d "$flacdir" ]; then
  echo "The directory $flacdir does not exist"
  exit -2
fi

tagsdir="$2"

mkdir -p "$tagsdir"

total=0
for f in "$flacdir"/*.flac
 do
   total=`expr $total + 1`
 done


index=1
for f in "$flacdir"/*.flac
 do
#  echo " file is $f"
  base=`basename "$f" ".flac"`
# echo " basename is  $base"
  tagsfile="$tagsdir"/"$base".tag
#  echo "mf file is "$tagsfile""
  echo "TITLE"=$base"" >> "$tagsfile"
  echo "TRACKNUMBER=$index" >> "$tagsfile"
  echo "TRACKTOTAL=$total" >> "$tagsfile"
 # add the varargs should probably be a function. 
 
 
  vardex=1
  for var in "$@"
do
  if [ $vardex -ge 3 ]; then 
     echo "$var" >> "$tagsflacfile"
  fi
  vardex=`expr $vardex + 1`
done
  
  
  index=`expr $index + 1`
done
