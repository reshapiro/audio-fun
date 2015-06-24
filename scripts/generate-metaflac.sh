#!/bin/sh
flacdir=$1
metaflacdir=$2

mkdir "$metaflacdir"

for f in $flacdir/*.flac
 do
  echo " file is $f"
  base=`basename "$f" ".flac"`
  echo " basename is  $base"
  metaflacfile="$metaflacdir"/"$base".mfl
  echo "mf file is "$metaflacfile""
  echo "TITLE=$base" >> "$metaflacfile"
done
