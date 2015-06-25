#!/bin/sh
flacdir=$1
metaflacdir=$2

mkdir -p "$metaflacdir"

total=0
for f in $flacdir/*.flac
 do
   total=`expr $total + 1`
 done


index=1
for f in $flacdir/*.flac
 do
 # echo " file is $f"
  base=`basename "$f" ".flac"`
  # echo " basename is  $base"
  metaflacfile="$metaflacdir"/"$base".mfl
#  echo "mf file is "$metaflacfile""
  echo "TITLE"=$base"" >> "$metaflacfile"
  echo "TRACKNUMBER=$index" >> "$metaflacfile"
  echo "TRACKTOTAL=$total" >> "$metaflacfile"
 # add the varargs should probably be a function. 
 
 
  vardex=1
  for var in "$@"
do
  if [ $vardex -ge 3 ]; then 
     echo "$var" >> "$metaflacfile"
  fi
  vardex=`expr $vardex + 1`
done
  
  
  index=`expr $index + 1`
done
