#!/bin/sh

if [ $# -lt 1 ]; then
    echo "No directory of hi-def audio files was provided"
    exit -1
fi

dir=$1

f [  ! -d "$dir" ]; then
  echo "The directory $dir does not exist"
  exit -2
fi

for file in "$dir"/*.flac
do
base=`basename "$file"`
new="$dir"/"$base-16.flac"

echo "convert "$file" to "$new"" 
# sox -S  foo.flac  -r 44100 -b 16 new.flac
 sox -S "${file}" -r 44100 -b 16 "$new" dither -s
done






