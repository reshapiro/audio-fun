#!/bin/sh

if [ $# -lt 2 ]; then
    echo "Two arguments are required."
    echo
    
    echo "The first argument should be a directory containing hi-def audio files."
    echo "The second argument should name the directory which will be created and will contain a down-sampled file for each hi-def file"
    echo "An optional third argument can be used to specify the sample rate if you don't want  to sample at 48k rather 44100
    echo "An optional fourth argument can be used to specify the sample size if you don't want 16
    
    exit -1
fi
dir=$1
newdir=$2
#default rate and size

rate=44100
size=16

if [ $# -gt 2 ]; then
   rate=$3
fi

if [ $# -gt 3 ]; then
   size=$4
fi

f [  ! -d "$dir" ]; then
  echo "The directory $dir does not exist"
  exit -2
fi

mkdir -p $newdir
for file in "$dir"/*.flac
do
   fname=`basename "${file}"`
   new="$newdir"/"$fname"
   echo "convert "$file" to "$new"" 
    sox -S "${file}" -r $rate -b $size "$new" dither -s
done






