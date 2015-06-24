#!/bin/sh
dir=$1
newdir=$2
mkdir $newdir
for file in "$dir"/*.flac
do
   fname=`basename "${file}"`
   new="$newdir"/"$fname"
   echo "convert "$file" to "$new"" 
    sox -S "${file}" -r 44100 -b 16 "$new" dither -s
done






