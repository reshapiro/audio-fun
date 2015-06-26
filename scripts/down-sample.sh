#!/bin/sh

if [ $# -lt 2 ]; then
    echo "Two arguments are required."
    echo
    echo "The first argument should be a directory containing hi-def audio files."
    echo "The second argument should name the directory which will be created and will contain a 16/44.1 file for each hi-def file"
    exit -1
fi

dir=$1

f [  ! -d "$dir" ]; then
  echo "The directory $dir does not exist"
  exit -2
fi

newdir=$2
mkdir -p $newdir
for file in "$dir"/*.flac
do
   fname=`basename "${file}"`
   new="$newdir"/"$fname"
   echo "convert "$file" to "$new"" 
    sox -S "${file}" -r 44100 -b 16 "$new" dither -s
done






