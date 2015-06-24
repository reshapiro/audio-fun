#!/bin/sh
dir=$1
for file in "$dir"/*.flac
do
base=`basename "$file"`
new="$dir"/"$base-16.flac"

echo "convert "$file" to "$new"" 
# sox -S  foo.flac  -r 44100 -b 16 new.flac
 sox -S "${file}" -r 44100 -b 16 "$new" dither -s
done






